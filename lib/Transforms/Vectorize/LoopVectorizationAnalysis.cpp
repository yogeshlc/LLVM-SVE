//===- LoopVectorizationAnalysis.cpp ----------------------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Analyzes a loop to determine suitability for vectorization
//
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopIterator.h"
#include "llvm/Analysis/LoopVectorizationAnalysis.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/Analysis/ScalarEvolutionExpander.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/IR/DiagnosticInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

// TODO: Parameterize this for LoopVectorizeHints instead of
// #defining it here.
#define SLV_NAME "search-loop-vectorize"

#define LVA_NAME "loop-vec-analysis"
#define DEBUG_TYPE LVA_NAME
#ifndef NDEBUG
#define NODEBUG_EARLY_BAILOUT()                                           \
  do { if (!::llvm::DebugFlag || !::llvm::isCurrentDebugType(DEBUG_TYPE)) \
      { return false; } } while (0)
#else
#define NODEBUG_EARLY_BAILOUT() { return false; }
#endif

/// TODO: Rename flags? Also reorder....
/////////////////////////
/// This enables versioning on the strides of symbolically striding memory
/// accesses in code like the following.
///   for (i = 0; i < N; ++i)
///     A[i * Stride1] += B[i * Stride2] ...
///
/// Will be roughly translated to
///    if (Stride1 == 1 && Stride2 == 1) {
///      for (i = 0; i < N; i+=4)
///       A[i:i+3] += ...
///    } else
///      ...
static cl::opt<bool> EnableMemAccessVersioning(
    "sl-enable-mem-access-versioning", cl::init(true), cl::Hidden,
    cl::desc("Enable symblic stride memory access versioning"));

static cl::opt<bool> EnableInterleavedMemAccesses(
    "sl-enable-interleaved-mem-accesses", cl::init(false), cl::Hidden,
    cl::desc("Enable vectorization on interleaved memory accesses in a loop"));

/// The number of stores in a loop that are allowed to need predication.
static cl::opt<unsigned> NumberOfStoresToPredicate(
    "sl-vectorize-num-stores-pred", cl::init(1), cl::Hidden,
    cl::desc("Max number of stores to be predicated behind an if."));

/// Maximum factor for an interleaved memory access.
static cl::opt<unsigned> MaxInterleaveGroupFactor(
    "sl-max-interleave-group-factor", cl::Hidden,
    cl::desc("Maximum factor for an interleaved access group (default = 8)"),
    cl::init(8));

static cl::opt<bool> EnableCondStoresVectorization(
    "sl-enable-cond-stores-vec", cl::init(false), cl::Hidden,
    cl::desc("Enable if predication of stores during vectorization."));

static cl::opt<bool> MaximizeBandwidth(
    "sl-vectorizer-maximize-bandwidth", cl::init(false), cl::Hidden,
    cl::desc("Maximize bandwidth when selecting vectorization factor which "
             "will be determined by the smallest type in loop."));

/// We don't interleave loops with a known constant trip count below this
/// number.
static const unsigned TinyTripCountInterleaveThreshold = 128;

static cl::opt<unsigned> ForceTargetNumScalarRegs(
    "sl-force-target-num-scalar-regs", cl::init(0), cl::Hidden,
    cl::desc("A flag that overrides the target's number of scalar registers."));

static cl::opt<unsigned> ForceTargetNumVectorRegs(
    "sl-force-target-num-vector-regs", cl::init(0), cl::Hidden,
    cl::desc("A flag that overrides the target's number of vector registers."));

static cl::opt<bool> EnableIndVarRegisterHeur(
    "sl-enable-ind-var-reg-heur", cl::init(true), cl::Hidden,
    cl::desc("Count the induction variable only once when interleaving"));

static cl::opt<unsigned> ForceTargetMaxScalarInterleaveFactor(
    "sl-force-target-max-scalar-interleave", cl::init(0), cl::Hidden,
    cl::desc("A flag that overrides the target's max interleave factor for "
             "scalar loops."));

static cl::opt<unsigned> ForceTargetMaxVectorInterleaveFactor(
    "sl-force-target-max-vector-interleave", cl::init(0), cl::Hidden,
    cl::desc("A flag that overrides the target's max interleave factor for "
             "vectorized loops."));

static cl::opt<unsigned> ForceTargetInstructionCost(
    "sl-force-target-instruction-cost", cl::init(0), cl::Hidden,
    cl::desc("A flag that overrides the target's expected cost for "
             "an instruction to a single constant value. Mostly "
             "useful for getting consistent testing."));

static cl::opt<unsigned> SmallLoopCost(
    "sl-small-loop-cost", cl::init(20), cl::Hidden,
    cl::desc(
        "The cost of a loop that is considered 'small' by the interleaver."));

// Runtime interleave loops for load/store throughput.
static cl::opt<bool> EnableLoadStoreRuntimeInterleave(
    "sl-enable-loadstore-runtime-interleave", cl::init(true), cl::Hidden,
    cl::desc(
        "Enable runtime interleaving until load/store ports are saturated"));

static cl::opt<unsigned> MaxNestedScalarReductionIC(
    "sl-max-nested-scalar-reduction-interleave", cl::init(2), cl::Hidden,
    cl::desc("The maximum interleave count to use when interleaving a scalar "
             "reduction in a nested loop."));

static cl::opt<unsigned> PragmaVectorizeMemoryCheckThreshold(
    "sl-pragma-vectorize-memory-check-threshold", cl::init(128), cl::Hidden,
    cl::desc("The maximum allowed number of runtime memory checks with a "
             "vectorize(enable) pragma."));

static cl::opt<unsigned> VectorizeSCEVCheckThreshold(
    "sl-vectorize-scev-check-threshold", cl::init(16), cl::Hidden,
    cl::desc("The maximum number of SCEV checks allowed."));

static cl::opt<unsigned> PragmaVectorizeSCEVCheckThreshold(
    "sl-pragma-vectorize-scev-check-threshold", cl::init(128), cl::Hidden,
    cl::desc("The maximum number of SCEV checks allowed with a "
             "vectorize(enable) pragma"));

static cl::opt<bool> EnableNonConsecutiveStrideIndVars(
    "sl-enable-non-consecutive-stride-ind-vars", cl::init(false), cl::Hidden,
    cl::desc("Enable recognition of induction variables that aren't consecutive between loop iterations"));

static cl::opt<bool>
EnableIfConversion("sl-enable-if-conversion", cl::init(true), cl::Hidden,
                   cl::desc("Enable if-conversion during vectorization."));

static cl::opt<bool> EnableScalableVectorisation(
    "sl-force-scalable-vectorization", cl::init(true), cl::Hidden,
    cl::desc("Enable vectorization using scalable vectors"));

static cl::opt<bool> EnableUncountedLoops(
    "sl-enable-lv-uncounted-loops", cl::init(false), cl::Hidden,
    cl::desc("Enable vectorization of loops without a defined trip count"));

////////////////////////////////////////////////////////////////////////////////
// Helper functions (TODO: Move some?)
////////////////////////////////////////////////////////////////////////////////

/// \brief Check whether it is safe to if-convert this phi node.
///
/// Phi nodes with constant expressions that can trap are not safe to if
/// convert.
static bool canIfConvertPHINodes(BasicBlock *BB) {
  for (BasicBlock::iterator I = BB->begin(), E = BB->end(); I != E; ++I) {
    PHINode *Phi = dyn_cast<PHINode>(I);
    if (!Phi)
      return true;
    // TODO: Use to drive predication instead of bailing out?
    // Need to find an example that triggers this.
    for (unsigned p = 0, e = Phi->getNumIncomingValues(); p != e; ++p)
      if (Constant *C = dyn_cast<Constant>(Phi->getIncomingValue(p)))
        if (C->canTrap())
          return false;
  }
  return true;
}

// TODO: Feels ugly, see if there's a better way where invoked.
static Type *convertPointerToIntegerType(const DataLayout &DL, Type *Ty) {
  if (Ty->isPointerTy())
    return DL.getIntPtrType(Ty);

  // It is possible that char's or short's overflow when we ask for the loop's
  // trip count, work around this by changing the type size.
  if (Ty->getScalarSizeInBits() < 32)
    return Type::getInt32Ty(Ty->getContext());

  return Ty;
}

// TODO: Feels like something that should be provided by types instead.
static Type* getWiderType(const DataLayout &DL, Type *Ty0, Type *Ty1) {
  Ty0 = convertPointerToIntegerType(DL, Ty0);
  Ty1 = convertPointerToIntegerType(DL, Ty1);
  if (Ty0->getScalarSizeInBits() > Ty1->getScalarSizeInBits())
    return Ty0;
  return Ty1;
}

// TODO: Rename, clarify. Rework entirely? RPhis not neccesarily special
// anymore...
/// \brief Check that the instruction has outside loop users and is not an
/// identified reduction variable.
static bool hasOutsideLoopUser(const Loop *TheLoop, Instruction *Inst,
                               SmallPtrSetImpl<Value *> &Reductions) {
  // Reduction instructions are allowed to have exit users. All other
  // instructions must not have external users.
  if (!Reductions.count(Inst))
    //Check that all of the users of the loop are inside the BB.
    for (User *U : Inst->users()) {
      Instruction *UI = cast<Instruction>(U);
      // This user may be a reduction exit value.
      if (!TheLoop->contains(UI)) {
        DEBUG(dbgs() << "LVA: Found an outside user " << *UI << " for : "
              << *Inst << "\n");
        return true;
      }
    }
  return false;
}

////////////////////////////////////////////////////////////////////////////////
// LoopVectorizeHints
////////////////////////////////////////////////////////////////////////////////
LoopVectorizeHints::LoopVectorizeHints(const Loop *L, bool DisableInterleaving)
  : Width("vectorize.width", VectorizerParams::VectorizationFactor, HK_WIDTH),
    Interleave("interleave.count", DisableInterleaving, HK_UNROLL),
    Force("vectorize.enable", FK_Undefined, HK_FORCE), TheLoop(L) {

  // Populate values with existing loop metadata.
  getHintsFromMetadata();

  // force-vector-interleave overrides DisableInterleaving.
  if (VectorizerParams::isInterleaveForced())
    Interleave.Value = VectorizerParams::VectorizationInterleave;

  DEBUG(if (DisableInterleaving && Interleave.Value == 1) dbgs()
        << "LVA: Interleaving disabled by the pass manager\n");
}

bool LoopVectorizeHints::allowVectorization(Function *F, Loop *L,
                                            bool AlwaysVectorize) const {
  if (getForce() == LoopVectorizeHints::FK_Disabled) {
    DEBUG(dbgs() << "LVA: Not vectorizing: #pragma vectorize disable.\n");

    emitOptimizationRemarkAnalysis(F->getContext(),
                                   vectorizeAnalysisPassName(), *F,
                                   L->getStartLoc(), emitRemark());
    return false;
  }

  if (!AlwaysVectorize && getForce() != LoopVectorizeHints::FK_Enabled) {
    DEBUG(dbgs() << "LVA: Not vectorizing: No #pragma vectorize enable.\n");

    emitOptimizationRemarkAnalysis(F->getContext(),
                                   vectorizeAnalysisPassName(), *F,
                                   L->getStartLoc(), emitRemark());
    return false;
  }

  if (getWidth() == 1 && getInterleave() == 1) {
    // TODO: As below.
    // FIXME: Add a separate metadata to indicate when the loop has already
    // been vectorized instead of setting width and count to 1.
    DEBUG(dbgs() << "LVA: Not vectorizing: Disabled/already vectorized.\n");

    // FIXME: Add interleave.disable metadata. This will allow
    // vectorize.disable to be used without disabling the pass and errors
    // to differentiate between disabled vectorization and a width of 1.
    emitOptimizationRemarkAnalysis(
      F->getContext(), vectorizeAnalysisPassName(), *F, L->getStartLoc(),
      "loop not vectorized: vectorization and interleaving are explicitly "
      "disabled, or vectorize width and interleave count are both set to 1");

    return false;
  }

  return true;
}

const char *LoopVectorizeHints::vectorizeAnalysisPassName() const {
  // If hints are provided that don't disable vectorization use the
  // AlwaysPrint pass name to force the frontend to print the diagnostic.
  // TODO: Parameterize based on calling vectorizer.
  if (getWidth() == 1)
    return SLV_NAME;
  if (getForce() == LoopVectorizeHints::FK_Disabled)
    return SLV_NAME;
  if (getForce() == LoopVectorizeHints::FK_Undefined && getWidth() == 0)
    return SLV_NAME;
  return DiagnosticInfo::AlwaysPrint;
}

void LoopVectorizeHints::getHintsFromMetadata() {
  MDNode *LoopID = TheLoop->getLoopID();
  if (!LoopID)
    return;

  // First operand should refer to the loop id itself.
  assert(LoopID->getNumOperands() > 0 && "requires at least one operand");
  assert(LoopID->getOperand(0) == LoopID && "invalid loop id");

  // TODO: Range based possible?
  for (unsigned i = 1, ie = LoopID->getNumOperands(); i < ie; ++i) {
    const MDString *S = nullptr;
    SmallVector<Metadata *, 4> Args;

    // The expected hint is either a MDString or a MDNode with the first
    // operand a MDString.
    if (const MDNode *MD = dyn_cast<MDNode>(LoopID->getOperand(i))) {
      if (!MD || MD->getNumOperands() == 0)
        continue;
      S = dyn_cast<MDString>(MD->getOperand(0));
      for (unsigned i = 1, ie = MD->getNumOperands(); i < ie; ++i)
        Args.push_back(MD->getOperand(i));
    } else {
      S = dyn_cast<MDString>(LoopID->getOperand(i));
      assert(Args.size() == 0 && "too many arguments for MDString");
    }

    if (!S)
      continue;

    // Check if the hint starts with the loop metadata prefix.
    StringRef Name = S->getString();
    if (Args.size() == 1)
      setHint(Name, Args[0]);
  }
}

void LoopVectorizeHints::setHint(StringRef Name, Metadata *Arg) {
  if (!Name.startswith(Prefix()))
    return;
  Name = Name.substr(Prefix().size(), StringRef::npos);

  const ConstantInt *C = mdconst::dyn_extract<ConstantInt>(Arg);
  if (!C) return;
  unsigned Val = C->getZExtValue();

  Hint *Hints[] = {&Width, &Interleave, &Force};
  for (auto H : Hints) {
    if (Name == H->Name) {
      if (H->validate(Val))
        H->Value = Val;
      else
        DEBUG(dbgs() << "LVA: ignoring invalid hint '" << Name << "'\n");
      break;
    }
  }
}

MDNode *LoopVectorizeHints::createHintMetadata(StringRef Name,
                                               unsigned V) const {
  LLVMContext &Context = TheLoop->getHeader()->getContext();
  Metadata *MDs[] = {MDString::get(Context, Name),
                     ConstantAsMetadata::get(
                            ConstantInt::get(Type::getInt32Ty(Context), V))};
  return MDNode::get(Context, MDs);
}

bool LoopVectorizeHints::matchesHintMetadataName(MDNode *Node,
                                                 ArrayRef<Hint> HintTypes) {
  MDString* Name = dyn_cast<MDString>(Node->getOperand(0));
  if (!Name)
    return false;

  for (auto H : HintTypes)
    if (Name->getString().endswith(H.Name))
      return true;
  return false;
}

void LoopVectorizeHints::writeHintsToMetadata(ArrayRef<Hint> HintTypes) {
  if (HintTypes.size() == 0)
    return;

  // Reserve the first element to LoopID (see below).
  SmallVector<Metadata *, 4> MDs(1);
  // If the loop already has metadata, then ignore the existing operands.
  MDNode *LoopID = TheLoop->getLoopID();
  if (LoopID) {
    for (unsigned i = 1, ie = LoopID->getNumOperands(); i < ie; ++i) {
      MDNode *Node = cast<MDNode>(LoopID->getOperand(i));
      // If node in update list, ignore old value.
      if (!matchesHintMetadataName(Node, HintTypes))
        MDs.push_back(Node);
    }
  }

  // Now, add the missing hints.
  for (auto H : HintTypes)
    MDs.push_back(createHintMetadata(Twine(Prefix(), H.Name).str(), H.Value));

  // Replace current metadata node with new one.
  LLVMContext &Context = TheLoop->getHeader()->getContext();
  MDNode *NewLoopID = MDNode::get(Context, MDs);
  // Set operand 0 to refer to the loop id itself.
  NewLoopID->replaceOperandWith(0, NewLoopID);

  TheLoop->setLoopID(NewLoopID);
}

////////////////////////////////////////////////////////////////////////////////
// LoopVectorizationRequirements
////////////////////////////////////////////////////////////////////////////////

bool LoopVectorizationRequirements::doesNotMeet(Function *F, Loop *L,
                                                const LoopVectorizeHints &Hints) {
  const char *Name = Hints.vectorizeAnalysisPassName();
  bool Failed = false;
  if (UnsafeAlgebraInst && !Hints.allowReordering()) {
    emitOptimizationRemarkAnalysisFPCommute(
        F->getContext(), Name, *F, UnsafeAlgebraInst->getDebugLoc(),
        VectorizationReport() << "cannot prove it is safe to reorder "
                                 "floating-point operations");
    Failed = true;
  }

  // Test if runtime memcheck thresholds are exceeded.
  bool PragmaThresholdReached =
    NumRuntimePointerChecks > PragmaVectorizeMemoryCheckThreshold;
  bool ThresholdReached =
    NumRuntimePointerChecks > VectorizerParams::RuntimeMemoryCheckThreshold;
  if ((ThresholdReached && !Hints.allowReordering()) ||
      PragmaThresholdReached) {
    emitOptimizationRemarkAnalysisAliasing(
        F->getContext(), Name, *F, L->getStartLoc(),
        VectorizationReport()
            << "cannot prove it is safe to reorder memory operations");

    DEBUG(dbgs() << "LVA: Too many memory checks needed.\n");
    Failed = true;
  }

  return Failed;
}

////////////////////////////////////////////////////////////////////////////////
// LoopVectorizationLegality
////////////////////////////////////////////////////////////////////////////////
bool LoopVectorizationLegality::isLegalMaskedStore(Type *DataType, Value *Ptr) {
  return isConsecutivePtr(Ptr) && TTI->isLegalMaskedStore(DataType);
}

bool LoopVectorizationLegality::isLegalMaskedLoad(Type *DataType, Value *Ptr) {
  return isConsecutivePtr(Ptr) && TTI->isLegalMaskedLoad(DataType);
}

int LoopVectorizationLegality::isConsecutivePtr(Value *Ptr) {
  assert(Ptr->getType()->isPointerTy() && "Unexpected non-ptr");
  // Make sure that the pointer does not point to structs.
  if (Ptr->getType()->getPointerElementType()->isAggregateType())
    return 0;

  // If this value is a pointer induction variable we know it is consecutive.
  PHINode *Phi = dyn_cast_or_null<PHINode>(Ptr);
  if (Phi && Inductions.count(Phi)) {
    InductionDescriptor II = Inductions[Phi];
    return II.getConsecutiveDirection();
  }

  // Look passed casts that have no affect on address generation.
  auto *BC = dyn_cast_or_null<BitCastInst>(Ptr);
  if (BC && BC->getSrcTy()->isPointerTy()) {
    const DataLayout &DL = BC->getModule()->getDataLayout();
    Type *DstEltTy = cast<PointerType>(BC->getDestTy())->getElementType();
    Type *SrcEltTy = cast<PointerType>(BC->getSrcTy())->getElementType();

    if (DL.getTypeAllocSize(DstEltTy) != DL.getTypeAllocSize(SrcEltTy))
      return 0;

    Ptr = BC->getOperand(0);
  }

  GetElementPtrInst *Gep = getGEPInstruction(Ptr);
  if (!Gep)
    return 0;

  ScalarEvolution *SE = PSE.getSE();
  unsigned NumOperands = Gep->getNumOperands();
  Value *GpPtr = Gep->getPointerOperand();
  // If this GEP value is a consecutive pointer induction variable and all of
  // the indices are constant then we know it is consecutive. We can
  Phi = dyn_cast<PHINode>(GpPtr);
  if (Phi && Inductions.count(Phi)) {

    // Make sure that the pointer does not point to structs.
    PointerType *GepPtrType = cast<PointerType>(GpPtr->getType());
    if (GepPtrType->getElementType()->isAggregateType())
      return 0;

    // Make sure that all of the index operands are loop invariant.
    for (unsigned i = 1; i < NumOperands; ++i)
      if (!SE->isLoopInvariant(SE->getSCEV(Gep->getOperand(i)), TheLoop))
        return 0;

    InductionDescriptor II = Inductions[Phi];
    return II.getConsecutiveDirection();
  }

  unsigned InductionOperand = getGEPInductionOperand(Gep);

  // Check that all of the gep indices are uniform except for our induction
  // operand.
  for (unsigned i = 0; i != NumOperands; ++i)
    if (i != InductionOperand &&
        !SE->isLoopInvariant(SE->getSCEV(Gep->getOperand(i)), TheLoop))
      return 0;

  // We can emit wide load/stores only if the last non-zero index is the
  // induction variable.
  const SCEV *Last = nullptr;
  if (!Strides.count(Gep))
    Last = SE->getSCEV(Gep->getOperand(InductionOperand));
  else {
    // Because of the multiplication by a stride we can have a s/zext cast.
    // We are going to replace this stride by 1 so the cast is safe to ignore.
    //
    //  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
    //  %0 = trunc i64 %indvars.iv to i32
    //  %mul = mul i32 %0, %Stride1
    //  %idxprom = zext i32 %mul to i64  << Safe cast.
    //  %arrayidx = getelementptr inbounds i32* %B, i64 %idxprom
    //
    Last = replaceSymbolicStrideSCEV(PSE, Strides,
                                     Gep->getOperand(InductionOperand), Gep);
    if (const SCEVCastExpr *C = dyn_cast<SCEVCastExpr>(Last))
      Last =
          (C->getSCEVType() == scSignExtend || C->getSCEVType() == scZeroExtend)
              ? C->getOperand()
              : Last;
  }
  if (const SCEVAddRecExpr *AR = dyn_cast<SCEVAddRecExpr>(Last)) {
    const SCEV *Step = AR->getStepRecurrence(*SE);

    // The memory is consecutive because the last index is consecutive
    // and all other indices are loop invariant.
    if (Step->isOne())
      return 1;
    if (Step->isAllOnesValue())
      return -1;

    // Try and find a different constant stride
    if (EnableNonConsecutiveStrideIndVars) {
      if (const SCEVConstant *SCC = dyn_cast<SCEVConstant>(Step)) {
        const ConstantInt *CI = SCC->getValue();
        // TODO: Error checking vs. INT_MAX?
        return (int)CI->getLimitedValue(INT_MAX);
      }
    }
  }

  return 0;
}

bool LoopVectorizationLegality::isUniform(Value *V) {
  return LAI->isUniform(V);
}

bool LoopVectorizationLegality::canVectorizeWithIfConvert() {
  bool CanIfConvert = true;

  if (!EnableIfConversion) {
    emitAnalysis(VectorizationReport() << "if-conversion is disabled");
    DEBUG(dbgs() << "LVA: Not vectorizing - if-conversion is disabled.\n");
    CanIfConvert = false;
    NODEBUG_EARLY_BAILOUT();
  }

  assert(TheLoop->getNumBlocks() > 1 && "Single block loops are vectorizable");

  // A list of pointers that we can safely read and write to.
  SmallPtrSet<Value *, 8> SafePointes;

  // Collect safe addresses.
  for (Loop::block_iterator BI = TheLoop->block_begin(),
         BE = TheLoop->block_end(); BI != BE; ++BI) {
    BasicBlock *BB = *BI;

    if (blockNeedsPredication(BB))
      continue;

    for (BasicBlock::iterator I = BB->begin(), E = BB->end(); I != E; ++I) {
      if (LoadInst *LI = dyn_cast<LoadInst>(I))
        SafePointes.insert(LI->getPointerOperand());
      else if (StoreInst *SI = dyn_cast<StoreInst>(I))
        SafePointes.insert(SI->getPointerOperand());
    }
  }

  // Collect the blocks that need predication.
  BasicBlock *Header = TheLoop->getHeader();
  for (Loop::block_iterator BI = TheLoop->block_begin(),
         BE = TheLoop->block_end(); BI != BE; ++BI) {
    BasicBlock *BB = *BI;

    // We don't support switch statements inside loops.
    if (!isa<BranchInst>(BB->getTerminator())) {
      emitAnalysis(VectorizationReport(BB->getTerminator())
                   << "loop contains a switch statement");
      DEBUG(dbgs() <<
            "LVA: Not vectorizing - loop contains a switch statement.\n");
      CanIfConvert = false;
      NODEBUG_EARLY_BAILOUT();
    }

    // We must be able to predicate all blocks that need to be predicated.
    if (blockNeedsPredication(BB)) {
      if (!blockCanBePredicated(BB, SafePointes)) {
        emitAnalysis(VectorizationReport(BB->getTerminator())
                     << "control flow cannot be substituted for a select");
        DEBUG(dbgs() <<
              "LVA: Not vectorizing - cannot predicate all blocks for if-conversion.\n");
        CanIfConvert = false;
        NODEBUG_EARLY_BAILOUT();
      }
    } else if (BB != Header && !canIfConvertPHINodes(BB)) {
      emitAnalysis(VectorizationReport(BB->getTerminator())
                   << "control flow cannot be substituted for a select");
      DEBUG(dbgs() <<
            "LVA: Not vectorizing - phi nodes cannot be if converted.\n");
      CanIfConvert = false;
      NODEBUG_EARLY_BAILOUT();
    }
  }

  // We can if-convert this loop.
  return CanIfConvert;
}

// Find break conditions that can be safely moved to the top of the loop body.
// Conditions:
//   - Cannot be a PHI from something else than the loop header
//      (meaning: it must be a SCEVable induction variable)
//   - Cannot be an intrinsic with possible side effects
//   - Cannot be a load if there may be a write in between.
bool LoopVectorizationLegality::findConditionSubExprsRecurse(
                                        Value *V, ConditionExprs &SubExprs) {
  // Prevent unnecessary work
  if (std::find(SubExprs.begin(),SubExprs.end(),V) != SubExprs.end())
    return true;

  Instruction *I = dyn_cast<Instruction>(V);
  if ((I && !TheLoop->contains(I)) || isa<Constant>(V) ||
      isa<Argument>(V)) {
    SubExprs.push_back(V); // Must be loop invariant
    return true;
  }

  // Otherwise it must be an instruction
  if (!I)
    return false;

  // Only allow call instruction without side-effects.
  if (auto *CI = dyn_cast<CallInst>(I))
    if (!CI->doesNotAccessMemory())
      return false;

  if (auto *LI = dyn_cast<LoadInst>(I)) {
    // TODO: Currently we only allow consecutive loads with positive
    // stride.
    //  1. It needs to be consecutive because we do not yet
    //     have first faulting gathers implemented.
    //  2. It needs to be a positive stride because first faulting
    //     consecutive loads do not work with reversed loads:
    //     For example:
    //       int foo(void) {
    //         for(int hp=14; incs[hp] > 0; hp--);
    //         return hp;
    //       }
    //
    //     The problem with this is that we use first faulting loads to
    //     load 'incs[hp]'. This works absolutely fine when hp is incrementing,
    //     since the next value to load is one value next to the last loaded
    //     (and verified) element in the vector, e.g.
    //              V0                 V1
    //       ________________   ________________
    //      [ e0, e1, e2, e3 ] [ e4, e5, e6, e7 ]
    //                    ^^
    //                    last element loaded in V0,
    //
    //     V0 is used to compare against 'incs[hp]' to decide whether e4..e7
    //     will be loaded for a second iteration. The distance between 'e3'
    //     and 'e4' is 1.
    //
    //     In the decrementing case, we need to load e7..e4, which is done by
    //     loading e4..e7 and reversing the result. The next vector we load
    //     will be e0..e3. The distance between e0 and e4 is 4.
    //     If 'e0' would signal a fault (first faulting behaviour)
    //     then we cannot process e1..e3.
    //
    //     Possible solution: Use first faulting gathers and do not reverse the
    //     order of the load addresses like we do above.
    if (isConsecutivePtr(LI->getPointerOperand()) <= 0)
      return false;

    if (!LI->isSimple())
      return false;
  }

  ScalarEvolution *SE = PSE.getSE();
  // PHI nodes are allowed only if they are loop SCEVs
  if (isa<PHINode>(I)) {
    // No support for complex data flow in loop
    if (I->getParent() != TheLoop->getHeader())
      return false;

    // We must be able to tell something about this PHI node
    if (!SE->isSCEVable(I->getType()))
      return false;

    // Should be either LIV or computable
    const SCEV *SC = SE->getSCEV(I);
    if (!SE->isLoopInvariant(SC, TheLoop) &&
        SC == SE->getCouldNotCompute())
      return false;

    // Safe
    SubExprs.push_back(I);
    return true;
  }

  // Test all operands
  bool OperandsSafe = true;
  for (Value *Op: I->operands())
    OperandsSafe &= findConditionSubExprsRecurse(Op, SubExprs);

  if (!OperandsSafe)
    return false;

  SubExprs.push_back(V);
  return true;
}

bool LoopVectorizationLegality::findConditionSubExprs(Value *V,
                                                  ConditionExprs &SubExprs) {
  // Prevent unnecessary work
  if (std::find(SubExprs.begin(),SubExprs.end(),V) != SubExprs.end())
    return true;

  // Recurse to find subexpressions
  if (!findConditionSubExprsRecurse(V, SubExprs))
    return false;

  // It is always safe IR if V is not an instruction
  auto *VI = dyn_cast<Instruction>(V);
  if (!VI)
    return true;

  // If there are any Load Instructions in the SubExprs, make sure it does not
  // read anything that may be written to in between.
  SmallVector<LoadInst*,5> Loads;
  for (Value *L : SubExprs) {
    if (auto *LI = dyn_cast<LoadInst>(L)) {
      if (TheLoop->contains(LI))
        Loads.push_back(LI);
    }
  }

  // If there are no loads, all is safe
  if (!Loads.size())
    return true;


  SmallVector<StoreInst*,5> Stores;
  SmallVector<BasicBlock*,5> Descs;
  auto *LatchBr =
      dyn_cast<BranchInst>(TheLoop->getLoopLatch()->getTerminator());

  // Find all stores from the loop header upto V, except for the condition
  // in the LatchBr, because that condition is not moved 'up'.
  if (!LatchBr->isConditional() || V != LatchBr->getCondition()) {
    PDT->getDescendants(VI->getParent(), Descs);
    for (auto *BB : Descs) {
      // FIXME: Check if this is not too restrictive.
      if (!TheLoop->contains(BB))
        break;
      BasicBlock::reverse_iterator I, E;
      for (I = BB->rbegin(), E = BB->rend(); I != E; ++I) {
        if (StoreInst *SI = dyn_cast<StoreInst>(&*I))
          Stores.push_back(SI);
      }
    }
  }

  // If any of the loads may alias with one of the stores, be conservative.
  for (auto *LI : Loads) {
    for (auto *SI : Stores) {
      // If it is an exact alias, we can take the value of that store.
      AliasResult AR = AA->alias(LI->getPointerOperand(),
                                 SI->getPointerOperand());
      if (AR == MustAlias) {
        // Recursion, updates SubExprs
        if (!findConditionSubExprs(SI->getValueOperand(), SubExprs))
          return false;
      } else if (AR != NoAlias)
        return false;
    }
  }

  // All is safe
  return true;
}

bool LoopVectorizationLegality::canVectorizeExits() {
  bool CanVectorize = true;

  // TODO: Exit info struct separate from branch -> condition mapping?
  // TODO: Interaction with if-conversion?
  // TODO: When vectorizing instructions, check branch for if-convert
  // vs. exit mapping; change predicate and adjust mapping
  // in the latter case.

  SmallVector<BasicBlock*, 4> ExitingBlocks;
  TheLoop->getExitingBlocks(ExitingBlocks);
  bool FoundCountedExit = false;

  auto DFSCompare = [this](BasicBlock *A, BasicBlock*B) {
    return DFS->getPostorder(A) >= DFS->getPostorder(B);
  };
  std::sort(ExitingBlocks.begin(), ExitingBlocks.end(), DFSCompare);

  // If we're only allowing counted loops, then we currently have a stricter
  // set of constraints before we can vectorize.
  // Counted loops currently only allow for a single exit block.
  if (!AllowUncounted && ExitingBlocks.size() != 1) {
    CanVectorize = false;
    emitAnalysis(VectorizationReport() <<
                 "loop control flow is not understood by vectorizer");
    DEBUG(dbgs() << "LVA: Not vectorizing - multiple exit blocks.\n");
    NODEBUG_EARLY_BAILOUT();
  }

  // Check each exiting block
  for (auto *EB: ExitingBlocks) {
    BranchInst *Br = dyn_cast<BranchInst>(EB->getTerminator());
    if (!Br || !Br->isConditional()) {
      // No idea what to do with something that isn't a condbr yet
      CanVectorize = false;
      DEBUG(dbgs() <<
            "LVA: Not vectorizing - exit is not a conditional branch\n");
      NODEBUG_EARLY_BAILOUT();
      continue;
    }

    // TODO: Use getExitEdges here?
    BasicBlock *ExitBlock = nullptr;
    for (unsigned i = 0; i < Br->getNumSuccessors(); ++i)
      if (!TheLoop->contains(Br->getSuccessor(i)))
        ExitBlock = Br->getSuccessor(i);

    assert(ExitBlock &&
           "Unable to find exit block from BranchInst of exiting block\n");

    bool AllLIV = true;
    PHINode *LastPhi = nullptr;
    for (BasicBlock::iterator I = ExitBlock->begin(); I != ExitBlock->end() &&
                                                      isa<PHINode>(I); ++I) {
      LastPhi = cast<PHINode>(I);
      Value *EV = LastPhi->getIncomingValueForBlock(EB);
      auto *EI = dyn_cast<Instruction>(EV);
      if (EI && TheLoop->contains(EI)) {
          AllLIV = false;
          break;
      }
    }

    if (AllLIV && LastPhi) {
      // This must be a mergenode.
      // TODO: Check the following assumption is true, could have picked
      // the wrong PHI node.
      (void) EF->CreateEscapee(LastPhi);
    }

    // TODO: Figure out a better way of doing this. See ggHMatrix3::type in
    // eon for a case where the immediate exit block doesn't have a phi,
    // but its (sole) successor has a phi on the exit block and uses a
    // constant as the value.
    // Probably also lies with getEscapeeValuesFromMergeNode, though
    // it may be difficult to tell what the eventual merge node is,
    // since many other loops contribute to it.
    if (!LastPhi) {
      CanVectorize = false;
      DEBUG(dbgs() << "LVA: Not vectorizing - "
            "unable to resolve exit phi\n");
      NODEBUG_EARLY_BAILOUT();
    }

    ConditionExprs SubExprs;
    if (!findConditionSubExprs(Br->getCondition(), SubExprs)) {
      CanVectorize = false;
      DEBUG(dbgs() <<
            "LVA: Not vectorizing - unable to safely move condition to top of "
            "loop body.\n");
      NODEBUG_EARLY_BAILOUT();
    }

    // Check for a counted exit.
    if (PSE.getSE()->getExitCount(TheLoop, EB) != PSE.getSE()->getCouldNotCompute()) {
      // Only permit one at this time.
      if (!FoundCountedExit && EB == TheLoop->getLoopLatch()) {
        FoundCountedExit = true;
        Exits.emplace_back(EK_Counted, EB, ExitBlock, SubExprs);
        DEBUG(dbgs() << "LVA: Adding counted exit: " <<
              *(EB->getTerminator()) << "\n");
        continue;
      }
    }

    // Bail out unless uncounted loops are explicitly allowed.
    if (!AllowUncounted) {
      CanVectorize = false;
      emitAnalysis(VectorizationReport() <<
                   "could not determine number of loop iterations");
      DEBUG(dbgs() <<
            "LVA: Not vectorizing - SCEV could not compute the loop "
            "exit count.\n");
      NODEBUG_EARLY_BAILOUT();
      continue;
    }

    if (Br->getParent() != TheLoop->getLoopLatch() &&
        !DT->dominates(Br, TheLoop->getLoopLatch())) {
      CanVectorize = false;
      DEBUG(dbgs() << "LVA: Not vectorizing - Exiting block does not "
            "dominate latch\n");
      NODEBUG_EARLY_BAILOUT();
      continue;
    }

    if (CanVectorize) {
      Exits.emplace_back(EK_LoadCompare, EB, ExitBlock, SubExprs);
      DEBUG(dbgs() << "LVA: Adding uncounted exit: " <<
            *(EB->getTerminator()) << "\n");
      IsUncounted = true;
    }
  }

  return CanVectorize;
}

bool LoopVectorizationLegality::canVectorizeInstrs() {
  BasicBlock *Header = TheLoop->getHeader();

  bool CanVectorize = true;
  ScalarEvolution *SE = PSE.getSE();

  // Look for the attribute signaling the absence of NaNs.
  Function &F = *Header->getParent();
  const DataLayout &DL = F.getParent()->getDataLayout();
  if (F.hasFnAttribute("no-nans-fp-math"))
    HasFunNoNaNAttr =
        F.getFnAttribute("no-nans-fp-math").getValueAsString() == "true";

  // For each block in the loop.
  for (Loop::block_iterator bb = TheLoop->block_begin(),
       be = TheLoop->block_end(); bb != be; ++bb) {
      // Scan the instructions in the block and look for hazards.
    for (BasicBlock::iterator it = (*bb)->begin(), e = (*bb)->end(); it != e;
         ++it) {

      if (PHINode *Phi = dyn_cast<PHINode>(it)) {
        Type *PhiTy = Phi->getType();
        // Check that this PHI type is allowed.
        if (!PhiTy->isIntegerTy() &&
            !PhiTy->isFloatingPointTy() &&
            !PhiTy->isPointerTy()) {
          emitAnalysis(VectorizationReport(&*it)
                       << "loop control flow is not understood by vectorizer");
          DEBUG(dbgs() <<
                "LVA: Not vectorizing - Found an non-int non-pointer PHI.\n");
          CanVectorize = false;
          NODEBUG_EARLY_BAILOUT();
        }

        // If this PHINode is not in the header block, then we know that we
        // can convert it to select during if-conversion. No need to check if
        // the PHIs in this block are induction or reduction variables.
        if (*bb != Header) {
          // Check that this instruction has no outside users or is an
          // identified reduction value with an outside user.
          // TODO: For now, we ignore this case with uncounted loops and just
          // focus on phis created in the header block.
          if (!hasOutsideLoopUser(TheLoop, &*it, AllowedExit))
            continue;
          emitAnalysis(VectorizationReport(&*it) <<
                       "value could not be identified as "
                       "an induction or reduction variable");
          DEBUG(dbgs() <<
                "LVA: Not vectorizing - if-convertible induction phi used outside loop.\n");
          CanVectorize = false;
          NODEBUG_EARLY_BAILOUT();
          continue;
        }

        // We only allow if-converted PHIs with exactly two incoming values.
        if (Phi->getNumIncomingValues() != 2) {
          emitAnalysis(VectorizationReport(&*it)
                       << "control flow not understood by vectorizer");
          DEBUG(dbgs() <<
                "LVA: Not vectorizing - Phi with more than two incoming values.\n");
          CanVectorize = false;
          NODEBUG_EARLY_BAILOUT();
          continue;
        }

        InductionDescriptor ID;
        if (InductionDescriptor::isInductionPHI(Phi, SE, ID)) {
          DEBUG(dbgs() << "isInductionPHI(" << *Phi << ")\n");
          Inductions[Phi] = ID;
          // Get the widest type.
          if (!WidestIndTy)
            WidestIndTy = convertPointerToIntegerType(DL, PhiTy);
          else
            WidestIndTy = getWiderType(DL, PhiTy, WidestIndTy);

          // Int inductions are special because we only allow one IV.
          if (ID.getKind() == InductionDescriptor::IK_IntInduction &&
              ID.getConstIntStepValue() &&
              ID.getConstIntStepValue()->isOne() &&
              isa<Constant>(ID.getStartValue()) &&
              cast<Constant>(ID.getStartValue())->isNullValue()) {
            // Use the phi node with the widest type as induction. Use the last
            // one if there are multiple (no good reason for doing this other
            // than it is expedient). We've checked that it begins at zero and
            // steps by one, so this is a canonical induction variable.
            if (!Induction || PhiTy == WidestIndTy)
              Induction = Phi;
          }

          DEBUG(dbgs() << "LVA: Found an induction variable " << *Phi << "\n");

          // Until we explicitly handle the case of an induction variable with
          // an outside loop user we have to give up vectorizing this loop.
          if (hasOutsideLoopUser(TheLoop, &*it, AllowedExit)) {
            Escapee *Esc;
            if (!EF->canVectorizeEscapeeValue(Phi, Esc)) {
              emitAnalysis(VectorizationReport(&*it) <<
                           "use of induction value outside of the "
                           "loop is not handled by vectorizer");
              DEBUG(dbgs() <<
                    "LVA: Not vectorizing - induction phi used outside loop.\n");
              CanVectorize = false;
              NODEBUG_EARLY_BAILOUT();
            }
          }

          continue;
        }

        if (RecurrenceDescriptor::isReductionPHI(Phi, TheLoop, SE,
                                                 Reductions[Phi],
                                                 AllowUncounted)) {
          DEBUG(dbgs() << "isReductionPHI(" << *Phi << ")\n");
          if (Reductions[Phi].hasUnsafeAlgebra())
            Requirements->addUnsafeAlgebraInst(
                Reductions[Phi].getUnsafeAlgebraInst());

          // TODO: There has to be a nicer way to do this?
          RecurrenceDescriptor::ExitInstrList::iterator  I, E;
          RecurrenceDescriptor::ExitInstrList *EIList =
            Reductions[Phi].getLoopExitInstrs();

          // All reduction variables are also escapees! (Or at least, they
          // should be, so add a check that the number of ExitInstructions
          // equals the number of Exits).
          // Reuse the same logic by adding the merge nodes of a reduction
          // to the Escapee stuff.

          // Get exiting blocks
          SmallVector<BasicBlock*, 4> Exits;
          TheLoop->getExitingBlocks(Exits);
          if (IsUncounted &&
              Reductions[Phi].getLoopExitInstrs()->size() != Exits.size()) {
            emitAnalysis(VectorizationReport(&*it) <<
                         "not all exits represented by reduction exit "
                         "instructions, so it does not match the criteria "
                         "for an escapee. Cannot vectorize.");
            DEBUG(dbgs() <<
                  "LVA: Not vectorizing - reduction phi does not classify as "
                  "an escapee\n");
            CanVectorize = false;
            NODEBUG_EARLY_BAILOUT();

          } else {
            // If this is a valid reductio, we need to create an Escapee
            // object for it as well.
            if (!EF->CreateEscapee(Phi, Reductions[Phi])) {
              CanVectorize = false;
              NODEBUG_EARLY_BAILOUT();
              continue;
            }

            for (I = EIList->begin(), E = EIList->end(); I != E; ++I)
              AllowedExit.insert(*I);

            DEBUG(dbgs() << "LVA: Found a reduction variable " << *Phi << "\n");

            if (!ScalarizedReduction)
              ScalarizedReduction = !TTI->canReduceInVector(Reductions[Phi],
                                                            hasNoNaNAttr());
            continue;
          }
        }

        emitAnalysis(VectorizationReport(&*it) <<
                     "value that could not be identified as "
                     "reduction is used outside the loop");
        DEBUG(dbgs() <<
              "LVA: Not vectorizing - unidentified phi " << *Phi <<
              " found (not a known reduction).\n");
        CanVectorize = false;
        NODEBUG_EARLY_BAILOUT();
        continue;
      }// end of PHI handling

      // We handle calls that:
      //   * Are debug info intrinsics.
      //   * Have a mapping to an IR intrinsic.
      //   * Have a vector version available.
      CallInst *CI = dyn_cast<CallInst>(it);
      if (CI && !getVectorIntrinsicIDForCall(CI, TLI) && !isa<DbgInfoIntrinsic>(CI) &&
          !(CI->getCalledFunction() && TLI &&
            TLI->isFunctionVectorizable(CI->getCalledFunction()->getName()))) {
        emitAnalysis(VectorizationReport(&*it) <<
                     "call instruction " << *CI << "cannot be vectorized");
        DEBUG(dbgs() <<
              "LVA: Not vectorizing - found a non-intrinsic, non-libfunc callsite " <<
              *CI << "\n");
        CanVectorize = false;
        NODEBUG_EARLY_BAILOUT();
        continue;
      }

      // Intrinsics such as powi,cttz and ctlz are legal to vectorize if the
      // second argument is the same (i.e. loop invariant)
      if (CI &&
          hasVectorInstrinsicScalarOpd(getVectorIntrinsicIDForCall(CI, TLI), 1)) {
        if (!SE->isLoopInvariant(PSE.getSCEV(CI->getOperand(1)), TheLoop)) {
          emitAnalysis(VectorizationReport(&*it)
                       << "intrinsic instruction cannot be vectorized");
          DEBUG(dbgs() <<
                "LVA: Not vectorizing - found unvectorizable intrinsic " << *CI << "\n");
          CanVectorize = false;
          NODEBUG_EARLY_BAILOUT();
          continue;
        }
      }

      // Check that the instruction return type is vectorizable.
      // Also, we can't vectorize extractelement instructions.
      if ((!VectorType::isValidElementType(it->getType()) &&
           !it->getType()->isVoidTy()) ||
          it->getType()->isFP128Ty() ||
          isa<ExtractElementInst>(it)) {
        emitAnalysis(VectorizationReport(&*it)
                     << "instruction return type cannot be vectorized");
        DEBUG(dbgs() << "LVA: Found unvectorizable type.\n");
        DEBUG(dbgs() <<
              "LVA: Not vectorizing - found unvectorizable type " <<
              *(it->getType()) << "\n");
        CanVectorize = false;
        NODEBUG_EARLY_BAILOUT();
        continue;
      }

      // Check that the stored type is vectorizable.
      if (StoreInst *ST = dyn_cast<StoreInst>(it)) {
        Type *T = ST->getValueOperand()->getType();
        if (!VectorType::isValidElementType(T) || it->getType()->isFP128Ty()) {
          emitAnalysis(VectorizationReport(ST) <<
                       "store instruction cannot be vectorized");
          DEBUG(dbgs() <<
                "LVA: Not vectorizing - cannot vectorize store instruction " <<
                *ST << "\n");
          CanVectorize = false;
          NODEBUG_EARLY_BAILOUT();
          continue;
        }

        if (EnableMemAccessVersioning)
          collectStridedAccess(ST);
      }

      if (EnableMemAccessVersioning)
        if (LoadInst *LI = dyn_cast<LoadInst>(it))
          collectStridedAccess(LI);

      // We do allow some escapees, especially for reductions
      if (hasOutsideLoopUser(TheLoop, &*it, AllowedExit)) {
        Escapee *Esc;
        if (!EF->canVectorizeEscapeeValue(&*it, Esc)) {
          emitAnalysis(VectorizationReport(&*it) <<
                       "use of induction value outside of the "
                       "loop is not handled by vectorizer");
          DEBUG(dbgs() <<
                "LVA: Not vectorizing - induction phi used outside loop.\n");
          CanVectorize = false;
          NODEBUG_EARLY_BAILOUT();
        }
      }
    } // next instr.

  }

  if (!Induction) {
    DEBUG(dbgs() << "LVA: Did not find one integer induction var.\n");
    if (Inductions.empty()) {
      emitAnalysis(VectorizationReport()
                   << "loop induction variable could not be identified");
      DEBUG(dbgs() <<
            "LVA: Not vectorizing - unable to identify loop induction variable.\n");
      CanVectorize = false;
    }
  }

  // Now we know the widest induction type, check if our found induction
  // is the same size. If it's not, unset it here and InnerLoopVectorizer
  // will create another.
  if (Induction && WidestIndTy != Induction->getType())
    Induction = nullptr;

  return CanVectorize;
}

void EscapeeFactory::getEscapeeValuesFromMergeNode(PHINode *Merge,
                      SmallVectorImpl<MergeValTuple> &Values) {
  unsigned NumLoopExitValues = 0;
  for (unsigned I=0; I < Merge->getNumIncomingValues(); ++I) {
    BasicBlock *BB = Merge->getIncomingBlock(I);
    if (DFS->getLoop()->contains(BB))
      NumLoopExitValues++;
  }

  bool LookThroughPHIs = NumLoopExitValues > 1;

  // For each value incoming to the PHI
  for (unsigned I=0; I < Merge->getNumIncomingValues(); ++I) {
    Value *Value = Merge->getIncomingValue(I);
    BasicBlock *BB = Merge->getIncomingBlock(I);

    // If it is an exit value from the loop, add it to list
    if (DFS->getLoop()->contains(BB)) {
      Values.push_back(std::tie(BB, Value));
      continue;
    }

    // Otherwise, check if it comes directly from an otherwise empty PHI
    auto *ValuePhi = dyn_cast<PHINode>(Value);

    // Only a direct PHI node is allowed
    if (!ValuePhi || !LookThroughPHIs)
      continue;

    // This must have only one incoming edge
    // (could this be an assert?)
    if (ValuePhi->getNumIncomingValues() != 1)
      continue;

    auto *IncomingVal = ValuePhi->getIncomingValue(0);
    BasicBlock *IncomingBB = ValuePhi->getIncomingBlock(0);

    if (!isa<Instruction>(IncomingVal)) {
      Values.push_back(std::tie(IncomingBB, IncomingVal));
      continue;
    }

    // If incoming value is not an exit value, skip
    if (!DFS->getLoop()->contains(IncomingBB))
      continue;

    // We only allow PHI nodes here, otherwise code from
    // this block needs to be executed in the vector tail.
    if (!isa<BranchInst>(IncomingBB->getFirstNonPHI()))
      continue;

    Values.push_back(std::tie(IncomingBB, IncomingVal));
  }
}

Escapee* EscapeeFactory::CreateEscapee(PHINode *Recurrence,
                                       RecurrenceDescriptor &RD) {
  Escapee *Res = nullptr;
  Instruction *Last = RD.getLoopExitInstrs()->back();

  // If the reduction has a PHI merge node, we use that logic.
  if (canVectorizeEscapeeValue(Last, Res)) {
    Res->setStore(RD.IntermediateStore);
    Res->IsReduction = true;
    return Res;
  }

  // TODO: We should be able to function without an intermediate
  // store. mesa from spec2K will trigger this, as will about
  // 20 benchmarks. Place an assert here instead to find them easily.
  // Otherwise it must have an intermediate store
  if (!RD.IntermediateStore)
    return nullptr;

  SmallVector<Instruction*, 6> Values;
  Values.push_back(Recurrence);  // add original PHI value
  Values.append(RD.getLoopExitInstrs()->begin(), RD.getLoopExitInstrs()->end());

  // Sort exiting blocks in DFS pre-order
  auto DFSCompare = [this](Instruction *A, Instruction*B) {
    return DFS->getPostorder(A->getParent()) >=
           DFS->getPostorder(B->getParent());
  };
  std::sort(Values.begin() + 1, Values.end(), DFSCompare);

  // Create a new Escapee and store it in cache
  Res = new Escapee(RD.IntermediateStore, Values.begin(), Values.end(), true);
  Escapees.insert(std::make_pair(RD.IntermediateStore, Res));

  return Res;
}

Escapee* EscapeeFactory::CreateEscapee(PHINode *Merge) {
  // First collect the loop exit blocks to the Escapee Merge Block
  // for this Escapee Merge Node.
  SmallVector<MergeValTuple, 6> BBs;
  getEscapeeValuesFromMergeNode(Merge, BBs);

  // Sort exiting blocks in DFS pre-order
  auto DFSCompare = [this](MergeValTuple A, MergeValTuple B) {
    return DFS->getPostorder(std::get<0>(A)) >= DFS->getPostorder(std::get<0>(B));
  };
  std::sort(BBs.begin(), BBs.end(), DFSCompare);

  // For each exit, add value to the Escapee Merge Node
  SmallVector<Value*, 6> Values;
  for (auto &BB : BBs) {
    Values.push_back(std::get<1>(BB));
  }

  // Create a new Escapee and store it in cache
  Escapee *Res = new Escapee(Merge, Values.begin(), Values.end());
  Escapees.insert(std::make_pair(Merge, Res));

  return Res;
}

// Determines whether a given Instruction is an Escapee Value. All
// Escapee Values can be vectorized.
//
// Definitions:
// ------------
// An Escapee Merge Block is:
//  - A basicblock that post-dominates a loop and all of its loop exits.
//  - No basic block exists that post-dominates all loop exits
//    and is dominated by the Escapee Merge Block.
//
// An Escapee Merge Node is:
//  - A PHI node that selects Escapee Values from every exit into a single
//    value. (note: it can also select values from other blocks)
//  - The Escapee Merge Node resides in the Escapee Merge Block
//
// An Escapee Value is:
//   - A value defined in the body of a loop
//   - which is either a recognized induction variable, reduction variable
//     or a non-PHI node,
//   - which is used only once outside the loop in an Escapee Merge Node.
bool EscapeeFactory::canVectorizeEscapeeValue(Instruction *Val, Escapee *&Res) {
  // Find (and only allow 1) single external user
  Instruction *ExternalUse = nullptr;
  for (User *U: Val->users()) {
    auto *UI = dyn_cast<Instruction>(U);
    if (DFS->getLoop()->contains(UI))
      continue;

    if (ExternalUse && ExternalUse != UI) {
      DEBUG(dbgs() << "LVA: Found multiple external users for candidate "
                      "Escapee Variable " << *Val << "\n");
      return false;
    }

    ExternalUse = UI;
  }

  // Require 1 external user
  if (!ExternalUse) {
    DEBUG(dbgs () << "LVA: Did not find any external users for candidate "
                     "Escapee Variable " << *Val << '\n');
    return false;
  }

  // TODO: VTail needs to perform proper transform in order to
  // support pointer indvar types...
  if (ExternalUse->getType()->isPointerTy()) {
    DEBUG(dbgs() <<
          "LVA: External use is a pointer type, vtail needs fixing\n");
    return false;
  }

  // Must be a PHI
  auto *PN = dyn_cast<PHINode>(ExternalUse);
  if (!PN) {
    DEBUG(dbgs () << "LVA: External user is not a PHI node for candidate "
                     "Escapee Value " << *Val << '\n');
    return false;
  }

  // If this merge node was already analyzed as an escapee,
  // we can safely return that.
  if (Escapees.count(PN)) {
    Res = Escapees[PN];
    return true;
  }

  // Get exiting blocks
  SmallVector<BasicBlock*, 4> Exits;
  DFS->getLoop()->getExitingBlocks(Exits);

  // Look through an otherwise empty PHI node iff there are
  // more than 1 loop exits.
  if (Exits.size() > 1 &&
      PN->hasOneUse() &&
      PN->getNumOperands() == 1 &&
      isa<PHINode>(*(PN->user_begin())))
    PN = cast<PHINode>(*(PN->user_begin()));

  // Check all loop exit nodes are represented
  SmallVector<MergeValTuple, 6> MergeValues;
  getEscapeeValuesFromMergeNode(PN, MergeValues);

  if (MergeValues.size() != Exits.size()) {
      DEBUG(dbgs () << "LVA: Not all exits are represented in PHI node for "
                       "candidate Escapee Value " << *Val << '\n');
      return false;
  }

  // Must post-dominate (may be implicit from the above)
  BasicBlock *ExternalBB = ExternalUse->getParent();
  for (BasicBlock *Exit : Exits) {
    if (!PDT->dominates(ExternalBB, Exit) && Exit != ExternalBB) {
      DEBUG(dbgs () << "LVA: PHI node does not post dominate all loop exits "
                       "for candidate Escapee Value " << *Val << '\n');
      return false;
    }
  }

  // Get nearest common block from post-dominator graph.
  BasicBlock *Nearest = ExternalBB;
  if (Exits.size() > 1) {
    Nearest = Exits[0];
    for (BasicBlock *Exit : Exits)
      Nearest = PDT->findNearestCommonDominator(Nearest, Exit);
  }

  // If this is not the nearest...
  if (Nearest != ExternalBB) {
    DEBUG(dbgs () << "LVA: PHI node not nearest common dominator for "
                     "candidate Escapee Value " << *Val << '\n');
    return false;
  }

  // Create the Escapee
  Res = CreateEscapee(PN);
  return true;
}

bool LoopVectorizationLegality::canVectorizeMemory() {
  LAI = &LAA->getInfo(TheLoop, Strides);
  auto &OptionalReport = LAI->getReport();
  if (OptionalReport)
    emitAnalysis(VectorizationReport(*OptionalReport));
  if (!LAI->canVectorizeMemory())
    return false;

  if (LAI->hasStoreToLoopInvariantAddress()) {
    emitAnalysis(
        VectorizationReport()
        << "write to a loop invariant address could not be vectorized");
    DEBUG(dbgs() << "LVA: We don't allow storing to uniform addresses\n");
    return false;
  }

  Requirements->addRuntimePointerChecks(LAI->getNumRuntimePointerChecks());
  PSE.addPredicate(LAI->PSE.getUnionPredicate());

  return true;
}

bool LoopVectorizationLegality::canVectorize() {
  bool CanVectorize = true;

  // We must have a loop in canonical form. Loops with indirectbr in them cannot
  // be canonicalized.
  if (!TheLoop->getLoopPreheader()) {
    CanVectorize = false;
    emitAnalysis(
        VectorizationReport() <<
        "loop control flow is not understood by vectorizer");
    DEBUG(dbgs() <<
          "LVA: Not vectorizing - unable to find preheader for original loop.\n");
    NODEBUG_EARLY_BAILOUT();
  }

  // We can only vectorize innermost loops.
  if (!TheLoop->empty()) {
    CanVectorize = false;
    emitAnalysis(VectorizationReport() << "loop is not the innermost loop");
    DEBUG(dbgs() << "LVA: Not vectorizing - not the innermost loop.\n");
    NODEBUG_EARLY_BAILOUT();
  }

  // We must have a single backedge.
  if (TheLoop->getNumBackEdges() != 1) {
    CanVectorize = false;
    emitAnalysis(
        VectorizationReport() <<
        "loop control flow is not understood by vectorizer");
    DEBUG(dbgs() << "LVA: Not vectorizing - multiple backedges.\n");
    NODEBUG_EARLY_BAILOUT();
  }

  // We need to have a loop header.
  DEBUG(dbgs() << "LVA: Found a loop in " << 
        TheLoop->getHeader()->getParent()->getName() << ": " <<
        TheLoop->getHeader()->getName() << '\n');

  // Check if we can if-convert non-single-bb loops.
  unsigned NumBlocks = TheLoop->getNumBlocks();
  if (NumBlocks != 1 && !canVectorizeWithIfConvert()) {
    CanVectorize = false;
    DEBUG(dbgs() << "LVA: Not vectorizing - can't if-convert the loop.\n");
    NODEBUG_EARLY_BAILOUT();
  }

  // Check if we can vectorize the instructions and CFG in this loop.
  if (!canVectorizeInstrs()) {
    CanVectorize = false;
    DEBUG(dbgs() <<
          "LVA: Not vectorizing - can't vectorize the instructions or CFG.\n");
    NODEBUG_EARLY_BAILOUT();
  }

  // Go over each instruction and look at memory deps.
  if (!canVectorizeMemory()) {
    CanVectorize = false;
    DEBUG(dbgs() <<
          "LVA: Can't vectorize due to memory conflicts.\n");
    NODEBUG_EARLY_BAILOUT();
  }

  // Check to see if all exits can be combined with predication
  if (!canVectorizeExits()) {
    CanVectorize = false;
    DEBUG(dbgs() << "LVA: Not vectorizing - unsuitable exits.\n");
    NODEBUG_EARLY_BAILOUT();
  }

  if (CanVectorize) {
    // Collect all of the variables that remain uniform after vectorization.
    collectLoopUniforms();
    DEBUG(dbgs() << "LVA: We can vectorize this loop"
                 << (LAI->getRuntimePointerChecking()->Need
                         ? " (with a runtime bound check)"
                         : "")
                 << "!\n");
  }

  bool UseInterleaved = TTI->enableInterleavedAccessVectorization();

  // If an override option has been passed in for interleaved accesses, use it.
  if (EnableInterleavedMemAccesses.getNumOccurrences() > 0)
    UseInterleaved = EnableInterleavedMemAccesses;

  // Analyze interleaved memory accesses.
  if (UseInterleaved)
     InterleaveInfo.analyzeInterleaving(Strides);

  unsigned SCEVThreshold = VectorizeSCEVCheckThreshold;
  if (Hints->getForce() == LoopVectorizeHints::FK_Enabled)
    SCEVThreshold = PragmaVectorizeSCEVCheckThreshold;

  if (PSE.getUnionPredicate().getComplexity() > SCEVThreshold) {
    emitAnalysis(VectorizationReport()
                 << "Too many SCEV assumptions need to be made and checked "
                 << "at runtime");
    DEBUG(dbgs() << "LVA: Too many SCEV checks needed.\n");
    NODEBUG_EARLY_BAILOUT();
  }

  // Okay! We can vectorize. At this point we don't have any other mem analysis
  // which may limit our maximum vectorization factor, so just return true with
  // no restrictions.
  return CanVectorize;
}

void LoopVectorizationLegality::collectStridedAccess(Value *MemAccess) {
  Value *Ptr = nullptr;
  if (LoadInst *LI = dyn_cast<LoadInst>(MemAccess))
    Ptr = LI->getPointerOperand();
  else if (StoreInst *SI = dyn_cast<StoreInst>(MemAccess))
    Ptr = SI->getPointerOperand();
  else
    return;

  Value *Stride = getStrideFromPointer(Ptr, PSE.getSE(), TheLoop);
  if (!Stride)
    return;

  DEBUG(dbgs() << "LVA: Found a strided access that we can version");
  DEBUG(dbgs() << "  Ptr: " << *Ptr << " Stride: " << *Stride << "\n");
  Strides[Ptr] = Stride;
  StrideSet.insert(Stride);
}

void LoopVectorizationLegality::collectLoopUniforms() {
  // We now know that the loop is vectorizable!
  // Collect variables that will remain uniform after vectorization.
  std::vector<Value*> Worklist;
  BasicBlock *Latch = TheLoop->getLoopLatch();

  // Start with the conditional branch and walk up the block.
  Worklist.push_back(Latch->getTerminator()->getOperand(0));

  // Also add all consecutive pointer values; these values will be uniform
  // after vectorization (and subsequent cleanup) and, until revectorization is
  // supported, all dependencies must also be uniform.
  for (Loop::block_iterator B = TheLoop->block_begin(),
       BE = TheLoop->block_end(); B != BE; ++B)
    for (BasicBlock::iterator I = (*B)->begin(), IE = (*B)->end();
         I != IE; ++I)
      if (I->getType()->isPointerTy() && isConsecutivePtr(&*I))
        Worklist.insert(Worklist.end(), I->op_begin(), I->op_end());

  while (!Worklist.empty()) {
    Instruction *I = dyn_cast<Instruction>(Worklist.back());
    Worklist.pop_back();

    // Look at instructions inside this loop.
    // Stop when reaching PHI nodes.
    // TODO: we need to follow values all over the loop, not only in this block.
    if (!I || !TheLoop->contains(I) || isa<PHINode>(I))
      continue;

    // This is a known uniform.
    Uniforms.insert(I);

    // Insert all operands.
    Worklist.insert(Worklist.end(), I->op_begin(), I->op_end());
  }
}

bool LoopVectorizationLegality::isInductionVariable(const Value *V) {
  Value *In0 = const_cast<Value*>(V);

  if (EnableScalableVectorisation) {
    // TODO: Need to handle other arithmetic/logical instructions
    Instruction *Inst = dyn_cast<Instruction>(In0);
    if (Inst && Inst->getOpcode() == Instruction::Shl) {
      Value *ShiftVal = Inst->getOperand(1);
      if (!dyn_cast<ConstantInt>(ShiftVal))
        return false;
      In0 = Inst->getOperand(0);
    }
  }

  PHINode *PN = dyn_cast_or_null<PHINode>(In0);
  if (!PN)
    return false;

  return Inductions.count(PN);
}

bool LoopVectorizationLegality::blockNeedsPredication(BasicBlock *BB)  {
  return LoopAccessInfo::blockNeedsPredication(BB, TheLoop, DT);
}

bool LoopVectorizationLegality::blockCanBePredicated(BasicBlock *BB,
                                           SmallPtrSetImpl<Value *> &SafePtrs) {
  // TODO: Modernize...
  for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e; ++it) {
    // Check that we don't have a constant expression that can trap as operand.
    for (Instruction::op_iterator OI = it->op_begin(), OE = it->op_end();
         OI != OE; ++OI) {
      if (Constant *C = dyn_cast<Constant>(*OI))
        if (C->canTrap())
          return false;
    }
    // We might be able to hoist the load.
    if (it->mayReadFromMemory()) {
      LoadInst *LI = dyn_cast<LoadInst>(it);
      if (!LI)
        return false;
      if (!SafePtrs.count(LI->getPointerOperand())) {
        if (isLegalMaskedLoad(LI->getType(), LI->getPointerOperand())) {
          MaskedOp.insert(LI);
          continue;
        }
        return false;
      }
    }

    // We don't predicate stores at the moment.
    if (it->mayWriteToMemory()) {
      StoreInst *SI = dyn_cast<StoreInst>(it);
      // We only support predication of stores in basic blocks with one
      // predecessor.
      if (!SI)
        return false;

      bool isSafePtr = (SafePtrs.count(SI->getPointerOperand()) != 0);
      bool isSinglePredecessor = SI->getParent()->getSinglePredecessor();

      if (++NumPredStores > NumberOfStoresToPredicate || !isSafePtr ||
          !isSinglePredecessor) {
        // Build a masked store if it is legal for the target, otherwise scalarize
        // the block.
        bool isLegalMaskedOp =
          isLegalMaskedStore(SI->getValueOperand()->getType(),
                             SI->getPointerOperand());
        if (isLegalMaskedOp) {
          --NumPredStores;
          MaskedOp.insert(SI);
          continue;
        }
        return false;
      }
    }
    if (it->mayThrow())
      return false;

    // The instructions below can trap.
    // TODO: Take predicated div/rem into account.
    switch (it->getOpcode()) {
    default: continue;
    case Instruction::UDiv:
    case Instruction::SDiv:
    case Instruction::URem:
    case Instruction::SRem:
      return false;
    }
  }

  return true;
}

////////////////////////////////////////////////////////////////////////////////
// InterleavedAccessInfo
////////////////////////////////////////////////////////////////////////////////
void InterleavedAccessInfo::collectConstStridedAccesses(
    MapVector<Instruction *, StrideDescriptor> &StrideAccesses,
    const ValueToValueMap &Strides) {
  // Holds load/store instructions in program order.
  SmallVector<Instruction *, 16> AccessList;

  for (auto *BB : TheLoop->getBlocks()) {
    bool IsPred = LoopAccessInfo::blockNeedsPredication(BB, TheLoop, DT);

    for (auto &I : *BB) {
      if (!isa<LoadInst>(&I) && !isa<StoreInst>(&I))
        continue;
      // FIXME: Currently we can't handle mixed accesses and predicated accesses
      if (IsPred)
        return;

      AccessList.push_back(&I);
    }
  }

  if (AccessList.empty())
    return;

  auto &DL = TheLoop->getHeader()->getModule()->getDataLayout();
  for (auto I : AccessList) {
    LoadInst *LI = dyn_cast<LoadInst>(I);
    StoreInst *SI = dyn_cast<StoreInst>(I);

    Value *Ptr = LI ? LI->getPointerOperand() : SI->getPointerOperand();
    int Stride = getPtrStride(PSE, Ptr, TheLoop, Strides);

    // The factor of the corresponding interleave group.
    unsigned Factor = std::abs(Stride);

    // Ignore the access if the factor is too small or too large.
    if (Factor < 2 || Factor > MaxInterleaveGroupFactor)
      continue;

    const SCEV *Scev = replaceSymbolicStrideSCEV(PSE, Strides, Ptr);
    PointerType *PtrTy = dyn_cast<PointerType>(Ptr->getType());
    unsigned Size = DL.getTypeAllocSize(PtrTy->getElementType());

    // An alignment of 0 means target ABI alignment.
    unsigned Align = LI ? LI->getAlignment() : SI->getAlignment();
    if (!Align)
      Align = DL.getABITypeAlignment(PtrTy->getElementType());

    StrideAccesses[I] = StrideDescriptor(Stride, Scev, Size, Align);
  }
}

// Analyze interleaved accesses and collect them into interleave groups.
//
// Notice that the vectorization on interleaved groups will change instruction
// orders and may break dependences. But the memory dependence check guarantees
// that there is no overlap between two pointers of different strides, element
// sizes or underlying bases.
//
// For pointers sharing the same stride, element size and underlying base, no
// need to worry about Read-After-Write dependences and Write-After-Read
// dependences.
//
// E.g. The RAW dependence:  A[i] = a;
//                           b = A[i];
// This won't exist as it is a store-load forwarding conflict, which has
// already been checked and forbidden in the dependence check.
//
// E.g. The WAR dependence:  a = A[i];  // (1)
//                           A[i] = b;  // (2)
// The store group of (2) is always inserted at or below (2), and the load group
// of (1) is always inserted at or above (1). The dependence is safe.
void InterleavedAccessInfo::analyzeInterleaving(
    const ValueToValueMap &Strides) {
  DEBUG(dbgs() << "LVA: Analyzing interleaved accesses...\n");

  // Holds all the stride accesses.
  MapVector<Instruction *, StrideDescriptor> StrideAccesses;
  collectConstStridedAccesses(StrideAccesses, Strides);

  if (StrideAccesses.empty())
    return;

  // Holds all interleaved store groups temporarily.
  SmallSetVector<InterleaveGroup *, 4> StoreGroups;

  // Search the load-load/write-write pair B-A in bottom-up order and try to
  // insert B into the interleave group of A according to 3 rules:
  //   1. A and B have the same stride.
  //   2. A and B have the same memory object size.
  //   3. B belongs to the group according to the distance.
  //
  // The bottom-up order can avoid breaking the Write-After-Write dependences
  // between two pointers of the same base.
  // E.g.  A[i]   = a;   (1)
  //       A[i]   = b;   (2)
  //       A[i+1] = c    (3)
  // We form the group (2)+(3) in front, so (1) has to form groups with accesses
  // above (1), which guarantees that (1) is always above (2).
  for (auto I = StrideAccesses.rbegin(), E = StrideAccesses.rend(); I != E;
       ++I) {
    Instruction *A = I->first;
    StrideDescriptor DesA = I->second;

    InterleaveGroup *Group = getInterleaveGroup(A);
    if (!Group) {
      DEBUG(dbgs() << "LVA: Creating an interleave group with:" << *A << '\n');
      Group = createInterleaveGroup(A, DesA.Stride, DesA.Align);
    }

    if (A->mayWriteToMemory())
      StoreGroups.insert(Group);

    for (auto II = std::next(I); II != E; ++II) {
      Instruction *B = II->first;
      StrideDescriptor DesB = II->second;

      // Ignore if B is already in a group or B is a different memory operation.
      if (isInterleaved(B) || A->mayReadFromMemory() != B->mayReadFromMemory())
        continue;

      // Check the rule 1 and 2.
      if (DesB.Stride != DesA.Stride || DesB.Size != DesA.Size)
        continue;

      // Calculate the distance and prepare for the rule 3.
      const SCEVConstant *DistToA =
          dyn_cast<SCEVConstant>(PSE.getSE()->getMinusSCEV(DesB.Scev, DesA.Scev));
      if (!DistToA)
        continue;

      int DistanceToA = DistToA->getAPInt().getSExtValue();

      // Skip if the distance is not multiple of size as they are not in the
      // same group.
      if (DistanceToA % static_cast<int>(DesA.Size))
        continue;

      // The index of B is the index of A plus the related index to A.
      int IndexB =
          Group->getIndex(A) + DistanceToA / static_cast<int>(DesA.Size);

      // Try to insert B into the group.
      if (Group->insertMember(B, IndexB, DesB.Align)) {
        DEBUG(dbgs() << "LVA: Inserted:" << *B << '\n'
                     << "    into the interleave group with" << *A << '\n');
        InterleaveGroupMap[B] = Group;

        // Set the first load in program order as the insert position.
        if (B->mayReadFromMemory())
          Group->setInsertPos(B);
      }
    } // Iteration on instruction B
  }   // Iteration on instruction A

  // Remove interleaved store groups with gaps.
  for (InterleaveGroup *Group : StoreGroups)
    if (Group->getNumMembers() != Group->getFactor())
      releaseGroup(Group);
}

////////////////////////////////////////////////////////////////////////////////
// LoopVectorizationCostModel
////////////////////////////////////////////////////////////////////////////////
void LoopVectorizationCostModel::emitAnalysis(const LoopAccessReport &Message)
                                                                         const {
  emitAnalysisDiag(TheFunction, TheLoop, *Hints, Message);
}

VectorizationFactor
LoopVectorizationCostModel::selectVectorizationFactor(bool OptForSize) {
  // Width 1 means no vectorize
  VectorizationFactor Factor = { 1U, 0U, !EnableScalableVectorisation };
  if (OptForSize && Legal->getRuntimePointerChecking()->Need) {
    emitAnalysis(VectorizationReport() <<
                 "runtime pointer checks needed. Enable vectorization of this "
                 "loop with '#pragma clang loop vectorize(enable)' when "
                 "compiling with -Os/-Oz");
    DEBUG(dbgs() <<
          "LVA: Aborting. Runtime ptr check is required with -Os/-Oz.\n");
    Factor.isFixed = true;
    return Factor;
  }

  if (!EnableCondStoresVectorization && Legal->getNumPredStores()) {
    emitAnalysis(VectorizationReport() <<
                 "store that is conditionally executed prevents vectorization");
    DEBUG(dbgs() << "LVA: No vectorization. There are conditional stores.\n");
    Factor.isFixed = true;
    return Factor;
  }

  // Find the trip count.
  unsigned TC = PSE.getSE()->getSmallConstantTripCount(TheLoop);
  DEBUG(dbgs() << "LVA: Found trip count: " << TC << '\n');

  MinBWs = computeMinimumValueSizes(TheLoop->getBlocks(), *DB, &TTI);
  unsigned SmallestType, WidestType;
  
  std::tie(SmallestType, WidestType) = getSmallestAndWidestTypes();
  unsigned WidestRegister = TTI.getRegisterBitWidth(true);
  unsigned MaxSafeDepDist = -1U;
  if (Legal->getMaxSafeDepDistBytes() != -1U)
    MaxSafeDepDist = Legal->getMaxSafeDepDistBytes() * 8;

  // For the case when the register size is unknown we cannot vectorise loops
  // with data dependencies in a scalable manner.  However, when the
  // architecture provides an upper bound, we can query that before reverting
  // to fixed width vectors.
  if (MaxSafeDepDist < TTI.getRegisterBitWidthUpperBound(true)) {
    Factor.isFixed = true;
    Factor.Width= 1;
    return Factor;

    // TODO: Have this disabled for now, as we only want to allow SL vectorization
    // for Scalable vectors for now. (otherwise it requires implementing
    // Neon support)
    //
    // // LAA may have assumed we can do strided during analysis
    // if (Legal->getRuntimePointerChecking()->Strided &&
    //     TTI.canVectorizeNonUnitStrides(true)) {
    //   DEBUG(dbgs() <<
    //         "LVA: Not vectorizing, can't do strided accesses on target.\n");
    //   emitAnalysis(VectorizationReport() <<
    //                "Target doesn't support vectorizing strided accesses.");
    //   Factor.Width = 1;
    //   return Factor;
    // }
  }

  WidestRegister = ((WidestRegister < MaxSafeDepDist) ?
                    WidestRegister : MaxSafeDepDist);
  unsigned MaxVectorSize = WidestRegister / WidestType;

  DEBUG(dbgs() << "LVA: The Smallest and Widest types: " << SmallestType << " / "
               << WidestType << " bits.\n");
  DEBUG(dbgs() << "LVA: The Widest register is: "
          << WidestRegister << " bits.\n");

  if (MaxVectorSize == 0) {
    DEBUG(dbgs() << "LVA: The target has no vector registers.\n");
    MaxVectorSize = 1;
  }

  assert(MaxVectorSize <= 64 && "Did not expect to pack so many elements"
         " into one vector!");

  unsigned VF = MaxVectorSize;
  if (MaximizeBandwidth && !OptForSize) {
    // Collect all viable vectorization factors.
    SmallVector<unsigned, 8> VFs;
    unsigned NewMaxVectorSize = WidestRegister / SmallestType;
    for (unsigned VS = MaxVectorSize; VS <= NewMaxVectorSize; VS *= 2)
      VFs.push_back(VS);

    // For each VF calculate its register usage.
    auto RUs = calculateRegisterUsage(VFs);

    // Select the largest VF which doesn't require more registers than existing
    // ones.
    unsigned TargetNumRegisters = TTI.getNumberOfRegisters(true);
    for (int i = RUs.size() - 1; i >= 0; --i) {
      if (RUs[i].MaxLocalUsers <= TargetNumRegisters) {
        VF = VFs[i];
        break;
      }
    }
  }

  // If we optimize the program for size, avoid creating the tail loop.
  if (OptForSize) {
    // If we are unable to calculate the trip count then don't try to vectorize.
    if (TC < 2) {
      emitAnalysis
        (VectorizationReport() <<
         "unable to calculate the loop count due to complex control flow");
      DEBUG(dbgs() << "LVA: Aborting. A tail loop is required with -Os/-Oz.\n");
      if (Factor.Width < 2)
        Factor.isFixed = true;
      return Factor;
    }

    // Find the maximum SIMD width that can fit within the trip count.
    VF = TC % MaxVectorSize;

    if (VF == 0)
      VF = MaxVectorSize;
    else {
      // If the trip count that we found modulo the vectorization factor is not
      // zero then we require a tail.
      emitAnalysis(VectorizationReport() <<
                   "cannot optimize for size and vectorize at the "
                   "same time. Enable vectorization of this loop "
                   "with '#pragma clang loop vectorize(enable)' "
                   "when compiling with -Os/-Oz");
      DEBUG(dbgs() << "LVA: Aborting. A tail loop is required with -Os/-Oz.\n");
      Factor.isFixed = true;
      return Factor;
    }
  }

  int UserVF = Hints->getWidth();
  if (UserVF != 0) {
    assert(isPowerOf2_32(UserVF) && "VF needs to be a power of two");
    DEBUG(dbgs() << "LVA: Using user VF " << UserVF << ".\n");

    Factor.Width = UserVF;
    if (Factor.Width < 2)
      Factor.isFixed = true;
    return Factor;
  }

  float Cost = expectedCost({/*Width=*/1, 0, /*isFixed=*/true});
#ifndef NDEBUG
  const float ScalarCost = Cost;
#endif /* NDEBUG */
  Factor.Width = 1;
  DEBUG(dbgs() << "LVA: Scalar loop costs: " << (int)ScalarCost << ".\n");

  bool ForceVectorization = Hints->getForce() == LoopVectorizeHints::FK_Enabled;
  // Ignore scalar width, because the user explicitly wants vectorization.
  if (ForceVectorization && VF > 1) {
    Factor.Width = 2;
    Cost = expectedCost(Factor) / (float)Factor.Width;
  }

  VectorizationFactor PotentialFactor = Factor;
  for (unsigned i=2; i <= VF; i*=2) {
    // Notice that the vector loop needs to be executed less times, so
    // we need to divide the cost of the vector loops by the width of
    // the vector elements.
    PotentialFactor.Width = i;
    float VectorCost = expectedCost(PotentialFactor) / (float)i;
    DEBUG(dbgs() << "LVA: Vector loop of width " << i << " costs: " <<
          (int)VectorCost << ".\n");
    if (VectorCost < Cost) {
      Cost = VectorCost;
      Factor = PotentialFactor;
    }
  }

  DEBUG(if (ForceVectorization && Factor.Width > 1 && Cost >= ScalarCost) dbgs()
        << "LVA: Vectorization seems to be not beneficial, "
        << "but was forced by a user.\n");
  Factor.Cost = Factor.Width * Cost;
  if (Factor.Width < 2)
    Factor.isFixed = true;
  DEBUG(dbgs() << "LVA: Selecting VF: " << (Factor.isFixed ? "" : "n x ") <<
        Factor.Width << ".\n");
  return Factor;
}

// TODO: Move to LVA
std::pair<unsigned, unsigned>
LoopVectorizationCostModel::getSmallestAndWidestTypes() {
  unsigned MinWidth = -1U;
  unsigned MaxWidth = 8;
  const DataLayout &DL = TheFunction->getParent()->getDataLayout();

  // For each block.
  for (Loop::block_iterator bb = TheLoop->block_begin(),
       be = TheLoop->block_end(); bb != be; ++bb) {
    BasicBlock *BB = *bb;

    // For each instruction in the loop.
    for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e; ++it) {
      Type *T = it->getType();

      // Skip ignored values.
      if (ValuesToIgnore.count(&*it))
        continue;

      // Only examine Loads, Stores and PHINodes.
      if (!isa<LoadInst>(it) && !isa<StoreInst>(it) && !isa<PHINode>(it))
        continue;

      // Examine PHI nodes that are reduction variables. Update the type to
      // account for the recurrence type.
      if (PHINode *PN = dyn_cast<PHINode>(it)) {
        if (!Legal->getReductionVars()->count(PN))
          continue;
        RecurrenceDescriptor RdxDesc = (*Legal->getReductionVars())[PN];
        T = RdxDesc.getRecurrenceType();
      }

      // Examine the stored values.
      if (StoreInst *ST = dyn_cast<StoreInst>(it))
        T = ST->getValueOperand()->getType();

      // Ignore loaded pointer types and stored pointer types that are not
      // consecutive. However, we do want to take consecutive stores/loads of
      // pointer vectors into account.
      if (T->isPointerTy() && !isConsecutiveLoadOrStore(&*it))
        continue;

      MinWidth = std::min(MinWidth,
                          (unsigned)DL.getTypeSizeInBits(T->getScalarType()));
      MaxWidth = std::max(MaxWidth,
                          (unsigned)DL.getTypeSizeInBits(T->getScalarType()));
    }
  }

  return {MinWidth, MaxWidth};
}

unsigned
LoopVectorizationCostModel::selectInterleaveCount(bool OptForSize,
                                                  VectorizationFactor VF,
                                                  unsigned LoopCost) {

  // -- The interleave heuristics --
  // We interleave the loop in order to expose ILP and reduce the loop overhead.
  // There are many micro-architectural considerations that we can't predict
  // at this level. For example, frontend pressure (on decode or fetch) due to
  // code size, or the number and capabilities of the execution ports.
  //
  // We use the following heuristics to select the interleave count:
  // 1. If the code has reductions, then we interleave to break the cross
  // iteration dependency.
  // 2. If the loop is really small, then we interleave to reduce the loop
  // overhead.
  // 3. We don't interleave if we think that we will spill registers to memory
  // due to the increased register pressure.

  // TODO: Not sure of the best approach for combining uncounted loops and
  // unrolling. Disable for now.
  //  if (EnableUncountedLoops)
    return 1;

  // TODO: revisit this decision but for now it is not worth considering
  if (!VF.isFixed)
    return 1;

  // When we optimize for size, we don't interleave.
  if (OptForSize)
    return 1;

  // We used the distance for the interleave count.
  if (Legal->getMaxSafeDepDistBytes() != -1U)
    return 1;

  // Do not interleave loops with a relatively small trip count.
  unsigned TC = PSE.getSE()->getSmallConstantTripCount(TheLoop);
  if (TC > 1 && TC < TinyTripCountInterleaveThreshold)
    return 1;

  unsigned TargetNumRegisters = TTI.getNumberOfRegisters(VF.Width > 1);
  DEBUG(dbgs() << "LVA: The target has " << TargetNumRegisters <<
        " registers\n");

  if (VF.Width == 1) {
    if (ForceTargetNumScalarRegs.getNumOccurrences() > 0)
      TargetNumRegisters = ForceTargetNumScalarRegs;
  } else {
    if (ForceTargetNumVectorRegs.getNumOccurrences() > 0)
      TargetNumRegisters = ForceTargetNumVectorRegs;
  }

  RegisterUsage R = calculateRegisterUsage({VF.Width})[0];
  // We divide by these constants so assume that we have at least one
  // instruction that uses at least one register.
  R.MaxLocalUsers = std::max(R.MaxLocalUsers, 1U);
  R.NumInstructions = std::max(R.NumInstructions, 1U);

  // We calculate the interleave count using the following formula.
  // Subtract the number of loop invariants from the number of available
  // registers. These registers are used by all of the interleaved instances.
  // Next, divide the remaining registers by the number of registers that is
  // required by the loop, in order to estimate how many parallel instances
  // fit without causing spills. All of this is rounded down if necessary to be
  // a power of two. We want power of two interleave count to simplify any
  // addressing operations or alignment considerations.
  unsigned IC = PowerOf2Floor((TargetNumRegisters - R.LoopInvariantRegs) /
                              R.MaxLocalUsers);

  // Don't count the induction variable as interleaved.
  if (EnableIndVarRegisterHeur)
    IC = PowerOf2Floor((TargetNumRegisters - R.LoopInvariantRegs - 1) /
                       std::max(1U, (R.MaxLocalUsers - 1)));

  // Clamp the interleave ranges to reasonable counts.
  unsigned MaxInterleaveCount = TTI.getMaxInterleaveFactor(VF.Width);

  // Check if the user has overridden the max.
  if (VF.Width == 1) {
    if (ForceTargetMaxScalarInterleaveFactor.getNumOccurrences() > 0)
      MaxInterleaveCount = ForceTargetMaxScalarInterleaveFactor;
  } else {
    if (ForceTargetMaxVectorInterleaveFactor.getNumOccurrences() > 0)
      MaxInterleaveCount = ForceTargetMaxVectorInterleaveFactor;
  }

  // If we did not calculate the cost for VF (because the user selected the VF)
  // then we calculate the cost of VF here.
  if (LoopCost == 0)
    LoopCost = expectedCost(VF);

  // Clamp the calculated IC to be between the 1 and the max interleave count
  // that the target allows.
  if (IC > MaxInterleaveCount)
    IC = MaxInterleaveCount;
  else if (IC < 1)
    IC = 1;

  // Interleave if we vectorized this loop and there is a reduction that could
  // benefit from interleaving.
  if (VF.Width > 1 && Legal->getReductionVars()->size()) {
    DEBUG(dbgs() << "LVA: Interleaving because of reductions.\n");
    return IC;
  }

  // Note that if we've already vectorized the loop we will have done the
  // runtime check and so interleaving won't require further checks.
  bool InterleavingRequiresRuntimePointerCheck =
      (VF.Width == 1 && Legal->getRuntimePointerChecking()->Need);

  // We want to interleave small loops in order to reduce the loop overhead and
  // potentially expose ILP opportunities.
  DEBUG(dbgs() << "LVA: Loop cost is " << LoopCost << '\n');
  if (!InterleavingRequiresRuntimePointerCheck && LoopCost < SmallLoopCost) {
    // We assume that the cost overhead is 1 and we use the cost model
    // to estimate the cost of the loop and interleave until the cost of the
    // loop overhead is about 5% of the cost of the loop.
    unsigned SmallIC =
        std::min(IC, (unsigned)PowerOf2Floor(SmallLoopCost / LoopCost));

    // Interleave until store/load ports (estimated by max interleave count) are
    // saturated.
    unsigned NumStores = Legal->getNumStores();
    unsigned NumLoads = Legal->getNumLoads();
    unsigned StoresIC = IC / (NumStores ? NumStores : 1);
    unsigned LoadsIC = IC / (NumLoads ? NumLoads : 1);

    // If we have a scalar reduction (vector reductions are already dealt with
    // by this point), we can increase the critical path length if the loop
    // we're interleaving is inside another loop. Limit, by default to 2, so the
    // critical path only gets increased by one reduction operation.
    if (Legal->getReductionVars()->size() &&
        TheLoop->getLoopDepth() > 1) {
      unsigned F = static_cast<unsigned>(MaxNestedScalarReductionIC);
      SmallIC = std::min(SmallIC, F);
      StoresIC = std::min(StoresIC, F);
      LoadsIC = std::min(LoadsIC, F);
    }

    if (EnableLoadStoreRuntimeInterleave &&
        std::max(StoresIC, LoadsIC) > SmallIC) {
      DEBUG(dbgs() << "LVA: Interleaving to saturate store or load ports.\n");
      return std::max(StoresIC, LoadsIC);
    }

    DEBUG(dbgs() << "LVA: Interleaving to reduce branch cost.\n");
    return SmallIC;
  }

  // Interleave if this is a large loop (small loops are already dealt with by
  // this
  // point) that could benefit from interleaving.
  bool HasReductions = (Legal->getReductionVars()->size() > 0);
  if (TTI.enableAggressiveInterleaving(HasReductions)) {
    DEBUG(dbgs() << "LVA: Interleaving to expose ILP.\n");
    return IC;
  }

  DEBUG(dbgs() << "LVA: Not Interleaving.\n");
  return 1;
}

SmallVector<LoopVectorizationCostModel::RegisterUsage, 8>
LoopVectorizationCostModel::calculateRegisterUsage(
    const SmallVector<unsigned, 8> &VFs) {
  // This function calculates the register usage by measuring the highest number
  // of values that are alive at a single location. Obviously, this is a very
  // rough estimation. We scan the loop in a topological order in order and
  // assign a number to each instruction. We use RPO to ensure that defs are
  // met before their users. We assume that each instruction that has in-loop
  // users starts an interval. We record every time that an in-loop value is
  // used, so we have a list of the first and last occurrences of each
  // instruction. Next, we transpose this data structure into a multi map that
  // holds the list of intervals that *end* at a specific location. This multi
  // map allows us to perform a linear search. We scan the instructions linearly
  // and record each time that a new interval starts, by placing it in a set.
  // If we find this value in the multi-map then we remove it from the set.
  // The max register usage is the maximum size of the set.
  // We also search for instructions that are defined outside the loop, but are
  // used inside the loop. We need this number separately from the max-interval
  // usage number because when we unroll, loop-invariant values do not take
  // more register.
  LoopBlocksDFS DFS(TheLoop);
  DFS.perform(LI);

  RegisterUsage RU;
  RU.NumInstructions = 0;

  // Each 'key' in the map opens a new interval. The values
  // of the map are the index of the 'last seen' usage of the
  // instruction that is the key.
  typedef DenseMap<Instruction*, unsigned> IntervalMap;
  // Maps instruction to its index.
  DenseMap<unsigned, Instruction*> IdxToInstr;
  // Marks the end of each interval.
  IntervalMap EndPoint;
  // Saves the list of instruction indices that are used in the loop.
  SmallSet<Instruction*, 8> Ends;
  // Saves the list of values that are used in the loop but are
  // defined outside the loop, such as arguments and constants.
  SmallPtrSet<Value*, 8> LoopInvariants;

  unsigned Index = 0;
  for (LoopBlocksDFS::RPOIterator bb = DFS.beginRPO(),
       be = DFS.endRPO(); bb != be; ++bb) {
    RU.NumInstructions += (*bb)->size();
    for (Instruction &I : **bb) {
      IdxToInstr[Index++] = &I;

      // Save the end location of each USE.
      for (unsigned i = 0; i < I.getNumOperands(); ++i) {
        Value *U = I.getOperand(i);
        Instruction *Instr = dyn_cast<Instruction>(U);

        // Ignore non-instruction values such as arguments, constants, etc.
        if (!Instr) continue;

        // If this instruction is outside the loop then record it and continue.
        if (!TheLoop->contains(Instr)) {
          LoopInvariants.insert(Instr);
          continue;
        }

        // Overwrite previous end points.
        EndPoint[Instr] = Index;
        Ends.insert(Instr);
      }
    }
  }

  // Saves the list of intervals that end with the index in 'key'.
  typedef SmallVector<Instruction*, 2> InstrList;
  DenseMap<unsigned, InstrList> TransposeEnds;

  // Transpose the EndPoints to a list of values that end at each index.
  for (IntervalMap::iterator it = EndPoint.begin(), e = EndPoint.end();
       it != e; ++it)
    TransposeEnds[it->second].push_back(it->first);

  SmallSet<Instruction*, 8> OpenIntervals;

  // Get the size of the widest register.
  unsigned MaxSafeDepDist = -1U;
  if (Legal->getMaxSafeDepDistBytes() != -1U)
    MaxSafeDepDist = Legal->getMaxSafeDepDistBytes() * 8;
  unsigned WidestRegister =
      std::min(TTI.getRegisterBitWidth(true), MaxSafeDepDist);
  const DataLayout &DL = TheFunction->getParent()->getDataLayout();

  SmallVector<RegisterUsage, 8> RUs(VFs.size());
  SmallVector<unsigned, 8> MaxUsages(VFs.size(), 0);

  DEBUG(dbgs() << "LV(REG): Calculating max register usage:\n");

  // A lambda that gets the register usage for the given type and VF.
  auto GetRegUsage = [&DL, WidestRegister](Type *Ty, unsigned VF) {
    unsigned TypeSize = DL.getTypeSizeInBits(Ty->getScalarType());
    return std::max<unsigned>(1, VF * TypeSize / WidestRegister);
  };

  for (unsigned int i = 0; i < Index; ++i) {
    Instruction *I = IdxToInstr[i];
    // Ignore instructions that are never used within the loop.
    if (!Ends.count(I)) continue;

    // Remove all of the instructions that end at this location.
    InstrList &List = TransposeEnds[i];
    for (unsigned int j = 0, e = List.size(); j < e; ++j)
      OpenIntervals.erase(List[j]);

    // Skip ignored values.
    if (ValuesToIgnore.count(I))
      continue;

    // For each VF find the maximum usage of registers.
    for (unsigned j = 0, e = VFs.size(); j < e; ++j) {
      if (VFs[j] == 1) {
        MaxUsages[j] = std::max(MaxUsages[j], OpenIntervals.size());
        continue;
      }

      // Count the number of live intervals.
      unsigned RegUsage = 0;
      for (auto Inst : OpenIntervals) {
        // Skip ignored values for VF > 1.
        if (VecValuesToIgnore.count(Inst))
          continue;
        RegUsage += GetRegUsage(Inst->getType(), VFs[j]);
      }
      MaxUsages[j] = std::max(MaxUsages[j], RegUsage);
    }

    DEBUG(dbgs() << "LV(REG): At #" << i << " Interval # "
                 << OpenIntervals.size() << '\n');

    // Add the current instruction to the list of open intervals.
    OpenIntervals.insert(I);
  }

  for (unsigned i = 0, e = VFs.size(); i < e; ++i) {
    unsigned Invariant = 0;
    if (VFs[i] == 1)
      Invariant = LoopInvariants.size();
    else {
      for (auto Inst : LoopInvariants)
        Invariant += GetRegUsage(Inst->getType(), VFs[i]);
    }

    DEBUG(dbgs() << "LV(REG): VF = " << VFs[i] <<  '\n');
    DEBUG(dbgs() << "LV(REG): Found max usage: " << MaxUsages[i] << '\n');
    DEBUG(dbgs() << "LV(REG): Found invariant usage: " << Invariant << '\n');
    DEBUG(dbgs() << "LV(REG): LoopSize: " << RU.NumInstructions << '\n');

    RU.LoopInvariantRegs = Invariant;
    RU.MaxLocalUsers = MaxUsages[i];
    RUs[i] = RU;
  }

  return RUs;
}

unsigned LoopVectorizationCostModel::expectedCost(VectorizationFactor VF) {
  unsigned Cost = 0;

  // For each block.
  for (Loop::block_iterator bb = TheLoop->block_begin(),
       be = TheLoop->block_end(); bb != be; ++bb) {
    unsigned BlockCost = 0;
    BasicBlock *BB = *bb;

    // For each instruction in the old loop.
    for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e; ++it) {
      // Skip dbg intrinsics.
      if (isa<DbgInfoIntrinsic>(it))
        continue;

      // Skip ignored values.
      if (ValuesToIgnore.count(&*it))
        continue;

      unsigned C = getInstructionCost(&*it, VF);

      // Check if we should override the cost.
      if (ForceTargetInstructionCost.getNumOccurrences() > 0)
        C = ForceTargetInstructionCost;

      BlockCost += C;
      DEBUG(dbgs() << "LVA: Found an estimated cost of " << C << " for VF " <<
            (VF.isFixed ? "" : "n x ") << VF.Width << " For instruction: "
            << *it << '\n');
    }

    // We assume that if-converted blocks have a 50% chance of being executed.
    // When the code is scalar then some of the blocks are avoided due to CF.
    // When the code is vectorized we execute all code paths.
    if (VF.Width == 1 && Legal->blockNeedsPredication(*bb))
      BlockCost /= 2;

    Cost += BlockCost;
  }

  return Cost;
}

/// Estimate the overhead of scalarizing a value. Insert and Extract are set if
/// the result needs to be inserted and/or extracted from vectors.
unsigned LoopVectorizationCostModel::getScalarizationOverhead(Type *Ty,
                                               bool Insert, bool Extract,
                                               const TargetTransformInfo &TTI) {
  if (Ty->isVoidTy())
    return 0;

  assert(Ty->isVectorTy() && "Can only scalarize vectors");
  unsigned Cost = 0;

  for (int i = 0, e = Ty->getVectorNumElements(); i < e; ++i) {
    if (Insert)
      Cost += TTI.getVectorInstrCost(Instruction::InsertElement, Ty, i);
    if (Extract)
      Cost += TTI.getVectorInstrCost(Instruction::ExtractElement, Ty, i);
  }

  return Cost;
}

// Estimate cost of a call instruction CI if it were vectorized with factor VF.
// Return the cost of the instruction, including scalarization overhead if it's
// needed. The flag NeedToScalarize shows if the call needs to be scalarized -
// i.e. either vector version isn't available, or is too expensive.
unsigned LoopVectorizationCostModel::getVectorCallCost(CallInst *CI,
                                                 unsigned VF,
                                                 const TargetTransformInfo &TTI,
                                                 const TargetLibraryInfo *TLI,
                                                 bool &NeedToScalarize) {
  Function *F = CI->getCalledFunction();
  StringRef FnName = CI->getCalledFunction()->getName();
  Type *ScalarRetTy = CI->getType();
  SmallVector<Type *, 4> Tys, ScalarTys;
  for (auto &ArgOp : CI->arg_operands())
    ScalarTys.push_back(ArgOp->getType());

  // Estimate cost of scalarized vector call. The source operands are assumed
  // to be vectors, so we need to extract individual elements from there,
  // execute VF scalar calls, and then gather the result into the vector return
  // value.
  unsigned ScalarCallCost = TTI.getCallInstrCost(F, ScalarRetTy, ScalarTys);
  if (VF == 1)
    return ScalarCallCost;

  // Compute corresponding vector type for return value and arguments.
  // TODO: Doesn't take WA into account.
  Type *RetTy = ToVectorTy(ScalarRetTy, VF);
  for (unsigned i = 0, ie = ScalarTys.size(); i != ie; ++i)
    Tys.push_back(ToVectorTy(ScalarTys[i], VF));

  // Compute costs of unpacking argument values for the scalar calls and
  // packing the return values to a vector.
  unsigned ScalarizationCost =
      getScalarizationOverhead(RetTy, true, false, TTI);
  for (unsigned i = 0, ie = Tys.size(); i != ie; ++i)
    ScalarizationCost += getScalarizationOverhead(Tys[i], false, true, TTI);

  unsigned Cost = ScalarCallCost * VF + ScalarizationCost;

  // If we can't emit a vector call for this function, then the currently found
  // cost is the cost we need to return.
  NeedToScalarize = true;
  if (!TLI || !TLI->isFunctionVectorizable(FnName, VF) || CI->isNoBuiltin())
    return Cost;

  // If the corresponding vector cost is cheaper, return its cost.
  unsigned VectorCallCost = TTI.getCallInstrCost(nullptr, RetTy, Tys);
  if (VectorCallCost < Cost) {
    NeedToScalarize = false;
    return VectorCallCost;
  }
  return Cost;
}


// Estimate cost of an intrinsic call instruction CI if it were vectorized with
// factor VF.  Return the cost of the instruction, including scalarization
// overhead if it's needed.
unsigned LoopVectorizationCostModel::getVectorIntrinsicCost(CallInst *CI,
                                                 unsigned VF,
                                                 const TargetTransformInfo &TTI,
                                                 const TargetLibraryInfo *TLI) {
  Intrinsic::ID ID = getVectorIntrinsicIDForCall(CI, TLI);
  assert(ID && "Expected intrinsic call!");

  Type *RetTy = ToVectorTy(CI->getType(), VF);
  SmallVector<Type *, 4> Tys;
  for (unsigned i = 0, ie = CI->getNumArgOperands(); i != ie; ++i)
    Tys.push_back(ToVectorTy(CI->getArgOperand(i)->getType(), VF));

  FastMathFlags FMF;
  if (auto *FPMO = dyn_cast<FPMathOperator>(CI))
    FMF = FPMO->getFastMathFlags();

  // TODO: Make the cost model scalable aware so that this decision can
  // be pass to getIntrinsicInstrCost when it has the correct types.

  // Both the code generator and loop vectoriser are unable to scalarise width
  // agnostic calls. Make calls that do no map directly to one or more
  // instructions prohibitively expensive so we never try to scalarise them.
  /// TODO: Always WA?
  if ((EnableScalableVectorisation) && (VF > 1))
    if ((ID == Intrinsic::cos) ||
        (ID == Intrinsic::exp) ||
        (ID == Intrinsic::log) ||
        (ID == Intrinsic::pow) ||
        (ID == Intrinsic::sin))
      return 99999;

  return TTI.getIntrinsicInstrCost(ID, RetTy, Tys, FMF);
}

/// \brief Check whether the address computation for a non-consecutive memory
/// access looks like an unlikely candidate for being merged into the indexing
/// mode.
///
/// We look for a GEP which has one index that is an induction variable and all
/// other indices are loop invariant. If the stride of this access is also
/// within a small bound we decide that this address computation can likely be
/// merged into the addressing mode.
/// In all other cases, we identify the address computation as complex.
static bool isLikelyComplexAddressComputation(Value *Ptr,
                                              LoopVectorizationLegality *Legal,
                                              ScalarEvolution *SE,
                                              const Loop *TheLoop) {
  GetElementPtrInst *Gep = dyn_cast<GetElementPtrInst>(Ptr);
  if (!Gep)
    return true;

  // We are looking for a gep with all loop invariant indices except for one
  // which should be an induction variable.
  unsigned NumOperands = Gep->getNumOperands();
  for (unsigned i = 1; i < NumOperands; ++i) {
    Value *Opd = Gep->getOperand(i);
    if (!SE->isLoopInvariant(SE->getSCEV(Opd), TheLoop) &&
        !Legal->isInductionVariable(Opd))
      return true;
  }

  // Now we know we have a GEP ptr, %inv, %ind, %inv. Make sure that the step
  // can likely be merged into the address computation.
  unsigned MaxMergeDistance = 64;

  const SCEVAddRecExpr *AddRec = dyn_cast<SCEVAddRecExpr>(SE->getSCEV(Ptr));
  if (!AddRec)
    return true;

  // Check the step is constant.
  const SCEV *Step = AddRec->getStepRecurrence(*SE);
  // Calculate the pointer stride and check if it is consecutive.
  const SCEVConstant *C = dyn_cast<SCEVConstant>(Step);
  if (!C)
    return true;

  const APInt &APStepVal = C->getAPInt();

  // Huge step value - give up.
  if (APStepVal.getBitWidth() > 64)
    return true;

  int64_t StepVal = APStepVal.getSExtValue();

  return StepVal > MaxMergeDistance;
}

static bool isStrideMul(Instruction *I, LoopVectorizationLegality *Legal) {
  return Legal->hasStride(I->getOperand(0)) ||
         Legal->hasStride(I->getOperand(1));
}

// Given a Chain
//  A -> B -> Z,
// where:
//  A = s/zext
//  B = add
//  C = trunc
// Check this is one of
//  s/zext(i32) -> add -> trunc(valtype)
static bool isPartOfPromotedAdd(Instruction *I, Type **OrigType) {
  Instruction *TruncOp = I;

  // If I is one of step A, find step C
  if ((I->getOpcode() == Instruction::ZExt ||
       I->getOpcode() == Instruction::SExt)) {
    // Confirm that s/zext is *only* used for the add
    for(int K=0; K<2; ++K) {
      if (!TruncOp->hasOneUse())
        return false;
      TruncOp = dyn_cast<Instruction>(TruncOp->user_back());
    }
  }
  // If I is one of step B, find step C
  else if ((I->getOpcode() == Instruction::Add)) {
    if (!I->hasOneUse())
      return false;
    TruncOp = I->user_back();
  }

  // Check if I is one of step C
  if (TruncOp->getOpcode() != Instruction::Trunc)
    return false;

  if (Instruction *Opnd = dyn_cast<Instruction>(TruncOp->getOperand(0))) {
    if (TruncOp->getOpcode() != Instruction::Trunc ||
        Opnd->getOpcode() != Instruction::Add || !Opnd->hasNUses(1))
      return false;

    // Check each operand to the 'add'
    unsigned cnt = 0;
    for (Value *V : Opnd->operands()) {
      if (const Instruction *AddOpnd = dyn_cast<const Instruction>(V)) {
        if (AddOpnd->getOpcode() != Instruction::ZExt &&
            AddOpnd->getOpcode() != Instruction::SExt)
          break;

        if (!AddOpnd->getType()->isIntegerTy(32))
          break;

        if ( AddOpnd->getOperand(0)->getType() != TruncOp->getType() ||
            !AddOpnd->hasNUses(1))
          break;
      }
      cnt++;
    }

    if (cnt == Opnd->getNumOperands()) {
      if (OrigType)
        *OrigType = TruncOp->getType();
      return true;
    }
  }

  return false;
}

static MemAccessInfo calculateMemAccessInfo(Instruction *I,
                                            Type *VectorTy,
                                            LoopVectorizationLegality *Legal,
                                            ScalarEvolution *SE) {
  const DataLayout &DL = I->getModule()->getDataLayout();

  // Get pointer operand
  Value *Ptr = nullptr;
  if (auto *LI = dyn_cast<LoadInst>(I))
    Ptr = LI->getPointerOperand();
  if (auto *SI = dyn_cast<StoreInst>(I))
    Ptr = SI->getPointerOperand();

  assert (Ptr && "Could not get pointer operand from instruction");

  // Check for uniform access (scalar load + splat)
  if (Legal->isUniform(Ptr))
    return MemAccessInfo::getUniformInfo();

  // Get whether it is a predicated memory operation
  bool IsMasked = Legal->isMaskRequired(I);

  // Try to find the stride of the pointer expression
  if (auto *SAR = dyn_cast<SCEVAddRecExpr>(SE->getSCEV(Ptr))) {
    const SCEV *StepRecurrence = SAR->getStepRecurrence(*SE);
    if (auto *StrideV = dyn_cast<SCEVConstant>(StepRecurrence)) {
      // Get the element size
      unsigned VectorElementSize =
          DL.getTypeStoreSize(VectorTy) / VectorTy->getVectorNumElements();

      // Normalize Stride from bytes to number of elements
      int Stride =
          StrideV->getValue()->getSExtValue() / ((int64_t)VectorElementSize);
      return MemAccessInfo::getStridedInfo(Stride, Stride < 0, IsMasked);
    } else {
      // Unknown stride is a subset of gather/scatter
      return MemAccessInfo::getNonStridedInfo(StepRecurrence->getType(),
                                              IsMasked);
    }
  }

  // If this is a scatter operation try to find the type of the offset,
  // if applicable, e.g. A[i] = B[C[i]]
  //                              ^^^^ get type of C[i]
  Type *IdxTy = nullptr;
  bool IsSigned = true;
  if (auto *Gep = dyn_cast<GetElementPtrInst>(Ptr)) {
    for (unsigned Op=0; Op < Gep->getNumOperands(); ++Op) {
      Value *Opnd = Gep->getOperand(Op);
      if (Legal->isUniform(Opnd)) {
        continue;
      }

      // If there are multiple non-loop invariant indices
      // in this GEP, fall back to the worst case below.
      if (IdxTy != nullptr) {
        IdxTy = nullptr;
        break;
      }

      // If type is promoted, see if we can use smaller type
      IdxTy = Opnd->getType();
      if (auto *Ext = dyn_cast<CastInst>(Opnd)) {
        if (Ext->isIntegerCast())
          IdxTy = Ext->getSrcTy();
        if (isa<ZExtInst>(Ext))
          IsSigned = false;
      }
    }
  }

  // Worst case scenario, assume pointer size
  if (!IdxTy)
    IdxTy = DL.getIntPtrType(Ptr->getType());

  return MemAccessInfo::getNonStridedInfo(IdxTy, IsMasked, IsSigned);
}

unsigned
LoopVectorizationCostModel::getInstructionCost(Instruction *I,
                                               VectorizationFactor VF) {
  // If we know that this instruction will remain uniform, check the cost of
  // the scalar version.
  if (Legal->isUniformAfterVectorization(I))
    VF.Width = 1;

  Type *RetTy = I->getType();
  if (VF.Width > 1 && MinBWs.count(I))
    RetTy = IntegerType::get(RetTy->getContext(), MinBWs[I]);
  Type *VectorTy = ToVectorTy(RetTy, VF);
  auto *SE = PSE.getSE();

  // TODO: We need to estimate the cost of intrinsic calls.
  switch (I->getOpcode()) {
  case Instruction::GetElementPtr:
    // We mark this instruction as zero-cost because the cost of GEPs in
    // vectorized code depends on whether the corresponding memory instruction
    // is scalarized or not. Therefore, we handle GEPs with the memory
    // instruction cost.
    return 0;
  case Instruction::Br: {
    return TTI.getCFInstrCost(I->getOpcode());
  }
  case Instruction::PHI:
    //TODO: IF-converted IFs become selects.
    return 0;
  case Instruction::Add:
  case Instruction::FAdd:
  case Instruction::Sub:
  case Instruction::FSub:
  case Instruction::Mul:
  case Instruction::FMul:
  case Instruction::UDiv:
  case Instruction::SDiv:
  case Instruction::FDiv:
  case Instruction::URem:
  case Instruction::SRem:
  case Instruction::FRem:
  case Instruction::Shl:
  case Instruction::LShr:
  case Instruction::AShr:
  case Instruction::And:
  case Instruction::Or:
  case Instruction::Xor: {
    // Since we will replace the stride by 1 the multiplication should go away.
    if (I->getOpcode() == Instruction::Mul && isStrideMul(I, Legal))
      return 0;
    // Certain instructions can be cheaper to vectorize if they have a constant
    // second vector operand. One example of this are shifts on x86.
    TargetTransformInfo::OperandValueKind Op1VK =
      TargetTransformInfo::OK_AnyValue;
    TargetTransformInfo::OperandValueKind Op2VK =
      TargetTransformInfo::OK_AnyValue;
    TargetTransformInfo::OperandValueProperties Op1VP =
        TargetTransformInfo::OP_None;
    TargetTransformInfo::OperandValueProperties Op2VP =
        TargetTransformInfo::OP_None;
    Value *Op2 = I->getOperand(1);

    // Check for a splat of a constant or for a non uniform vector of constants.
    if (isa<ConstantInt>(Op2)) {
      ConstantInt *CInt = cast<ConstantInt>(Op2);
      if (CInt && CInt->getValue().isPowerOf2())
        Op2VP = TargetTransformInfo::OP_PowerOf2;
      Op2VK = TargetTransformInfo::OK_UniformConstantValue;
    } else if (isa<ConstantVector>(Op2) || isa<ConstantDataVector>(Op2)) {
      Op2VK = TargetTransformInfo::OK_NonUniformConstantValue;
      Constant *SplatValue = cast<Constant>(Op2)->getSplatValue();
      if (SplatValue) {
        ConstantInt *CInt = dyn_cast<ConstantInt>(SplatValue);
        if (CInt && CInt->getValue().isPowerOf2())
          Op2VP = TargetTransformInfo::OP_PowerOf2;
        Op2VK = TargetTransformInfo::OK_UniformConstantValue;
      }
    }

    // Note: When we find a s/zext_to_i32->add->trunc_to_origtype
    //       chain, we ask the target if it has an add for the original
    //       type. This is not allowed in C, so the target should ensure
    //       that the instruction does the sign/zero conversion in 'int'.
    Type *OrigType = nullptr;
    if (isPartOfPromotedAdd(I, &OrigType))
      VectorTy = VectorType::get(OrigType, VF.Width, !VF.isFixed);

    return TTI.getArithmeticInstrCost(I->getOpcode(), VectorTy, Op1VK, Op2VK,
                                      Op1VP, Op2VP);
  }
  case Instruction::Select: {
    SelectInst *SI = cast<SelectInst>(I);
    const SCEV *CondSCEV = SE->getSCEV(SI->getCondition());
    bool ScalarCond = (SE->isLoopInvariant(CondSCEV, TheLoop));
    Type *CondTy = SI->getCondition()->getType();
    if (!ScalarCond)
      CondTy = VectorType::get(CondTy, VF.Width, !VF.isFixed);

    return TTI.getCmpSelInstrCost(I->getOpcode(), VectorTy, CondTy);
  }
  case Instruction::ICmp:
  case Instruction::FCmp: {
    Type *ValTy = I->getOperand(0)->getType();
    Instruction *Op0AsInstruction = dyn_cast<Instruction>(I->getOperand(0));
    auto It = MinBWs.find(Op0AsInstruction);
    if (VF.Width > 1 && It != MinBWs.end())
      ValTy = IntegerType::get(ValTy->getContext(), It->second);
    VectorTy = ToVectorTy(ValTy, VF);
    return TTI.getCmpSelInstrCost(I->getOpcode(), VectorTy);
  }
  case Instruction::Store:
  case Instruction::Load: {
    StoreInst *SI = dyn_cast<StoreInst>(I);
    LoadInst *LI = dyn_cast<LoadInst>(I);
    Type *ValTy = (SI ? SI->getValueOperand()->getType() :
                   LI->getType());
    VectorTy = ToVectorTy(ValTy, VF);

    unsigned Alignment = SI ? SI->getAlignment() : LI->getAlignment();
    unsigned AS = SI ? SI->getPointerAddressSpace() :
      LI->getPointerAddressSpace();
    Value *Ptr = SI ? SI->getPointerOperand() : LI->getPointerOperand();
    // We add the cost of address computation here instead of with the gep
    // instruction because only here we know whether the operation is
    // scalarized.
    if (VF.Width == 1)
      return TTI.getAddressComputationCost(VectorTy) +
        TTI.getMemoryOpCost(I->getOpcode(), VectorTy, Alignment, AS);

    // For an interleaved access, calculate the total cost of the whole
    // interleave group.
    if (Legal->isAccessInterleaved(I)) {
      auto Group = Legal->getInterleavedAccessGroup(I);
      assert(Group && "Fail to get an interleaved access group.");

      // Only calculate the cost once at the insert position.
      if (Group->getInsertPos() != I)
        return 0;

      unsigned InterleaveFactor = Group->getFactor();
      Type *WideVecTy =
          VectorType::get(VectorTy->getVectorElementType(),
                          VectorTy->getVectorNumElements() * InterleaveFactor,
                          !VF.isFixed);

      // Holds the indices of existing members in an interleaved load group.
      // An interleaved store group doesn't need this as it dones't allow gaps.
      SmallVector<unsigned, 4> Indices;
      if (LI) {
        for (unsigned i = 0; i < InterleaveFactor; i++)
          if (Group->getMember(i))
            Indices.push_back(i);
      }

      // Calculate the cost of the whole interleaved group.
      unsigned Cost = TTI.getInterleavedMemoryOpCost(
          I->getOpcode(), WideVecTy, Group->getFactor(), Indices,
          Group->getAlignment(), AS);

      if (Group->isReverse())
        Cost +=
            Group->getNumMembers() *
            TTI.getShuffleCost(TargetTransformInfo::SK_Reverse, VectorTy, 0);

      // FIXME: The interleaved load group with a huge gap could be even more
      // expensive than scalar operations. Then we could ignore such group and
      // use scalar operations instead.
      return Cost;
    }

    // Scalarized loads/stores.
    const DataLayout &DL = I->getModule()->getDataLayout();
    unsigned ScalarAllocatedSize = DL.getTypeAllocSize(ValTy);
    unsigned VectorElementSize = DL.getTypeStoreSize(VectorTy) / VF.Width;

    // Get information about vector memory access
    MemAccessInfo MAI = calculateMemAccessInfo(I, VectorTy, Legal, SE);

    // If there are no vector memory operations to support the stride,
    // get the cost for scalarizing the operation.
    if (!TTI.hasVectorMemoryOp(I->getOpcode(), VectorTy, MAI) ||
        ScalarAllocatedSize != VectorElementSize) {
      // Get cost of scalarizing
      bool IsComplexComputation =
        isLikelyComplexAddressComputation(Ptr, Legal, SE, TheLoop);
      unsigned Cost = 0;
      // The cost of extracting from the value vector and pointer vector.
      Type *PtrTy = ToVectorTy(Ptr->getType(), VF);
      for (unsigned i = 0; i < VF.Width; ++i) {
        //  The cost of extracting the pointer operand.
        Cost += TTI.getVectorInstrCost(Instruction::ExtractElement, PtrTy, i);
        // In case of STORE, the cost of ExtractElement from the vector.
        // In case of LOAD, the cost of InsertElement into the returned
        // vector.
        Cost += TTI.getVectorInstrCost(SI ? Instruction::ExtractElement :
                                            Instruction::InsertElement,
                                            VectorTy, i);
      }

      // The cost of the scalar loads/stores.
      Cost += VF.Width *
              TTI.getAddressComputationCost(PtrTy, IsComplexComputation);
      Cost += VF.Width *
              TTI.getMemoryOpCost(I->getOpcode(), ValTy->getScalarType(),
                                  Alignment, AS);
      return Cost;
    }

    // Wide load/stores.
    unsigned Cost = TTI.getAddressComputationCost(VectorTy);
    Cost += TTI.getVectorMemoryOpCost(I->getOpcode(), VectorTy, Ptr,
                                      Alignment, AS, MAI);

    if (MAI.isStrided() && MAI.isReversed())
      Cost += TTI.getShuffleCost(TargetTransformInfo::SK_Reverse,
                                  VectorTy, 0);
    else if (MAI.isUniform())
      Cost += TTI.getShuffleCost(TargetTransformInfo::SK_Broadcast,
                                  VectorTy, 0);
    return Cost;
  }
  case Instruction::ZExt:
  case Instruction::SExt:
  case Instruction::FPToUI:
  case Instruction::FPToSI:
  case Instruction::FPExt:
  case Instruction::PtrToInt:
  case Instruction::IntToPtr:
  case Instruction::SIToFP:
  case Instruction::UIToFP:
  case Instruction::Trunc:
  case Instruction::FPTrunc:
  case Instruction::BitCast: {
    // We optimize the truncation of induction variable.
    // The cost of these is the same as the scalar operation.
    if (I->getOpcode() == Instruction::Trunc &&
        Legal->isInductionVariable(I->getOperand(0)))
      return TTI.getCastInstrCost(I->getOpcode(), I->getType(),
                                  I->getOperand(0)->getType());
// TODO: determine if still useful, deleting isPartOfPromotedAdd if not
//    // Don't count these
//    if (isPartOfPromotedAdd(I, nullptr))
//      return 0;
//
//    Type *SrcVecTy = ToVectorTy(I->getOperand(0)->getType(), VF);

    Type *SrcScalarTy = I->getOperand(0)->getType();
    Type *SrcVecTy = ToVectorTy(SrcScalarTy, VF);
    if (VF.Width > 1 && MinBWs.count(I)) {
      // This cast is going to be shrunk. This may remove the cast or it might
      // turn it into slightly different cast. For example, if MinBW == 16,
      // "zext i8 %1 to i32" becomes "zext i8 %1 to i16".
      //
      // Calculate the modified src and dest types.
      Type *MinVecTy = VectorTy;
      if (I->getOpcode() == Instruction::Trunc) {
        SrcVecTy = smallestIntegerVectorType(SrcVecTy, MinVecTy);
        VectorTy = largestIntegerVectorType(ToVectorTy(I->getType(), VF),
                                            MinVecTy);
      } else if (I->getOpcode() == Instruction::ZExt ||
                 I->getOpcode() == Instruction::SExt) {
        SrcVecTy = largestIntegerVectorType(SrcVecTy, MinVecTy);
        VectorTy = smallestIntegerVectorType(ToVectorTy(I->getType(), VF),
                                             MinVecTy);
      }
    }

    return TTI.getCastInstrCost(I->getOpcode(), VectorTy, SrcVecTy);
  }
  case Instruction::Call: {
    bool NeedToScalarize;
    CallInst *CI = cast<CallInst>(I);
    unsigned CallCost = getVectorCallCost(CI, VF.Width, TTI, TLI,
                                          NeedToScalarize);
    if (getVectorIntrinsicIDForCall(CI, TLI))
      return std::min(CallCost, getVectorIntrinsicCost(CI, VF.Width, TTI, TLI));
    return CallCost;
  }
  default: {
    // We are scalarizing the instruction. Return the cost of the scalar
    // instruction, plus the cost of insert and extract into vector
    // elements, times the vector width.
    unsigned Cost = 0;

    if (!RetTy->isVoidTy() && VF.Width != 1) {
      unsigned InsCost = TTI.getVectorInstrCost(Instruction::InsertElement,
                                                VectorTy);
      unsigned ExtCost = TTI.getVectorInstrCost(Instruction::ExtractElement,
                                                VectorTy);

      // The cost of inserting the results plus extracting each one of the
      // operands.
      Cost += VF.Width * (InsCost + ExtCost * I->getNumOperands());
    }

    // The cost of executing VF copies of the scalar instruction. This opcode
    // is unknown. Assume that it is the same as 'mul'.
    Cost += VF.Width * TTI.getArithmeticInstrCost(Instruction::Mul, VectorTy);
    return Cost;
  }
  }// end of switch.
}


bool LoopVectorizationCostModel::isConsecutiveLoadOrStore(Instruction *Inst) {
  // Check for a store.
  if (StoreInst *ST = dyn_cast<StoreInst>(Inst))
    return Legal->isConsecutivePtr(ST->getPointerOperand()) != 0;

  // Check for a load.
  if (LoadInst *LI = dyn_cast<LoadInst>(Inst))
    return Legal->isConsecutivePtr(LI->getPointerOperand()) != 0;

  return false;
}

void LoopVectorizationCostModel::collectValuesToIgnore() {
  // Ignore ephemeral values.
  CodeMetrics::collectEphemeralValues(TheLoop, AC, ValuesToIgnore);

  // Ignore type-promoting instructions we identified during reduction
  // detection.
  for (auto &Reduction : *Legal->getReductionVars()) {
    RecurrenceDescriptor &RedDes = Reduction.second;
    SmallPtrSetImpl<Instruction *> &Casts = RedDes.getCastInsts();
    VecValuesToIgnore.insert(Casts.begin(), Casts.end());
  }

  // Ignore induction phis that are only used in either GetElementPtr or ICmp
  // instruction to exit loop. Induction variables usually have large types and
  // can have big impact when estimating register usage.
  // This is for when VF > 1.
  for (auto &Induction : *Legal->getInductionVars()) {
    auto *PN = Induction.first;
    auto *UpdateV = PN->getIncomingValueForBlock(TheLoop->getLoopLatch());

    // Check that the PHI is only used by the induction increment (UpdateV) or
    // by GEPs. Then check that UpdateV is only used by a compare instruction or
    // the loop header PHI.
    // FIXME: Need precise def-use analysis to determine if this instruction
    // variable will be vectorized.
    if (std::all_of(PN->user_begin(), PN->user_end(),
                    [&](const User *U) -> bool {
                      return U == UpdateV || isa<GetElementPtrInst>(U);
                    }) &&
        std::all_of(UpdateV->user_begin(), UpdateV->user_end(),
                    [&](const User *U) -> bool {
                      return U == PN || isa<ICmpInst>(U);
                    })) {
      VecValuesToIgnore.insert(PN);
      VecValuesToIgnore.insert(UpdateV);
    }
  }

  // Ignore instructions that will not be vectorized.
  // This is for when VF > 1.
  for (auto bb = TheLoop->block_begin(), be = TheLoop->block_end(); bb != be;
       ++bb) {
    for (auto &Inst : **bb) {
      switch (Inst.getOpcode()) {
      case Instruction::GetElementPtr: {
        // Ignore GEP if its last operand is an induction variable so that it is
        // a consecutive load/store and won't be vectorized as scatter/gather
        // pattern.

        GetElementPtrInst *Gep = cast<GetElementPtrInst>(&Inst);
        unsigned NumOperands = Gep->getNumOperands();
        unsigned InductionOperand = getGEPInductionOperand(Gep);
        bool GepToIgnore = true;

        // Check that all of the gep indices are uniform except for the
        // induction operand.
        for (unsigned i = 0; i != NumOperands; ++i) {
          if (i != InductionOperand &&
              !PSE.getSE()->isLoopInvariant(PSE.getSCEV(Gep->getOperand(i)),
                                            TheLoop)) {
            GepToIgnore = false;
            break;
          }
        }

        if (GepToIgnore)
          VecValuesToIgnore.insert(&Inst);
        break;
      }
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
// LoopVectorizationAnalysis
////////////////////////////////////////////////////////////////////////////////

bool LoopVectorizationAnalysis::runOnFunction(Function &F) {

  // Legality is per loop.....
  //  Legal = LoopVectorizationLegality()
  return false;
}

void LoopVectorizationAnalysis::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addRequired<ScalarEvolutionWrapperPass>();

  AU.setPreservesAll();
}

char LoopVectorizationAnalysis::ID = 0;
static const char lva_name[] = "Loop Vectorization Analysis";

INITIALIZE_PASS_BEGIN(LoopVectorizationAnalysis, LVA_NAME, lva_name, false, true)
INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
INITIALIZE_PASS_DEPENDENCY(DominatorTreeWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
INITIALIZE_PASS_END(LoopVectorizationAnalysis, LVA_NAME, lva_name, false, true)

// TODO: Not needed? Remove from Scalar.h?
Pass *createLVAPass() { return new LoopVectorizationAnalysis(); }
