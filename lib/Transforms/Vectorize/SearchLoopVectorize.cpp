//===- SearchLoopVectorize.cpp - A Search Loop Vectorizer -----------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// TODO: Fix up description
//
// This is the LLVM loop vectorizer. This pass modifies 'vectorizable' loops
// and generates target-independent LLVM-IR.
// The vectorizer uses the TargetTransformInfo analysis to estimate the costs
// of instructions in order to estimate the profitability of vectorization.
//
// The loop vectorizer combines consecutive loop iterations into a single
// 'wide' iteration. After this transformation the index is incremented
// by the SIMD vector width, and not by one.
//
// This pass has three parts:
// 1. The main loop pass that drives the different parts.
// 2. LoopVectorizationLegality - A unit that checks for the legality
//    of the vectorization.
// 3. InnerLoopVectorizer - A unit that performs the actual
//    widening of instructions.
// 4. LoopVectorizationCostModel - A unit that checks for the profitability
//    of vectorization. It decides on the optimal vector width, which
//    can be one, if vectorization is not profitable.
//
//===----------------------------------------------------------------------===//
//
// The reduction-variable vectorization is based on the paper:
//  D. Nuzman and R. Henderson. Multi-platform Auto-vectorization.
//
// Variable uniformity checks are inspired by:
//  Karrenberg, R. and Hack, S. Whole Function Vectorization.
//
// The interleaved access vectorization is based on the paper:
//  Dorit Nuzman, Ira Rosen and Ayal Zaks.  Auto-Vectorization of Interleaved
//  Data for SIMD
//
// Other ideas/concepts are from:
//  A. Zaks and D. Nuzman. Autovectorization in GCC-two years later.
//
//  S. Maleki, Y. Gao, M. Garzaran, T. Wong and D. Padua.  An Evaluation of
//  Vectorizing Compilers.
//
//===----------------------------------------------------------------------===//

#include "llvm/Transforms/Vectorize.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/Hashing.h"
#include "llvm/ADT/MapVector.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/BasicAliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/CodeMetrics.h"
#include "llvm/Analysis/DemandedBits.h"
#include "llvm/Analysis/GlobalsModRef.h"
#include "llvm/Analysis/LoopAccessAnalysis.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopIterator.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/LoopVectorizationAnalysis.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpander.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/DiagnosticInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/ValueHandle.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Pass.h"
#include "llvm/Support/BranchProbability.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include <algorithm>
#include <functional>
#include <map>
#include <tuple>
#include <string>

using namespace llvm;
using namespace llvm::PatternMatch;

#define SLV_NAME "search-loop-vectorize"
#define DEBUG_TYPE SLV_NAME
#ifndef NDEBUG
#define NODEBUG_EARLY_BAILOUT()                                           \
  do { if (!::llvm::DebugFlag || !::llvm::isCurrentDebugType(DEBUG_TYPE)) \
      { return false; } } while (0)
#else
#define NODEBUG_EARLY_BAILOUT() { return false; }
#endif

STATISTIC(SearchLoopsVectorized, "Number of loops vectorized");
STATISTIC(SearchLoopsAnalyzed, "Number of loops analyzed for vectorization");

/// We don't vectorize loops with a known constant trip count below this number.
static cl::opt<unsigned>
TinyTripCountVectorThreshold("sl-vectorizer-min-trip-count", cl::init(16),
                             cl::Hidden,
                             cl::desc("Don't vectorize loops with a constant "
                                      "trip count that is smaller than this "
                                      "value."));

static cl::opt<bool> LoopVectorizeWithBlockFrequency(
    "sl-loop-vectorize-with-block-frequency", cl::init(false), cl::Hidden,
    cl::desc("Enable the use of the block frequency analysis to access PGO "
             "heuristics minimizing code growth in cold regions and being more "
             "aggressive in hot regions."));

static cl::opt<bool> DisableReductionIntrinsics(
    "sl-disable-reduction-intrinsics", cl::init(false), cl::Hidden,
    cl::desc("Disable the loop vectoriser's use of reduction intrinsics."));

static cl::opt<bool> AnnotateWidenedInstrs(
    "sl-annotate-widened-instrs", cl::init(false), cl::Hidden,
    cl::desc("Annotate vector instructions with the scalar instruction they represent"));


// The following two options are mutually exclusive.
static cl::list<std::string>
    FuncsBlackList("sl-blacklist-funcs", cl::value_desc("function names"),
                   cl::desc("Skip search loop vectorization for functions whose"
                            " name matches one in this list"),
                   cl::CommaSeparated);

static cl::list<std::string>
    FuncsWhiteList("sl-whitelist-funcs", cl::value_desc("function names"),
                   cl::desc("Only use search loop vectorization for functions whose"
                            " name matches on in this list"),
                   cl::CommaSeparated);

////////////////////////////////////////////////////////////////////////////////
// Helpers
////////////////////////////////////////////////////////////////////////////////

/// \brief Look for a meaningful debug location on the instruction or it's
/// operands.
static Instruction *getDebugLocFromInstOrOperands(Instruction *I) {
  if (!I)
    return I;

  DebugLoc Empty;
  if (I->getDebugLoc() != Empty)
    return I;

  for (User::op_iterator OI = I->op_begin(), OE = I->op_end(); OI != OE; ++OI) {
    if (Instruction *OpInst = dyn_cast<Instruction>(*OI))
      if (OpInst->getDebugLoc() != Empty)
        return OpInst;
  }

  return I;
}

/// \brief Set the debug location in the builder using the debug location in the
/// instruction.
static void setDebugLocFromInst(IRBuilder<> &B, const Value *Ptr) {
  if (const Instruction *Inst = dyn_cast_or_null<Instruction>(Ptr))
    B.SetCurrentDebugLocation(Inst->getDebugLoc());
  else
    B.SetCurrentDebugLocation(DebugLoc());
}

#ifndef NDEBUG
/// \return string containing a file name and a line # for the given loop.
static std::string getDebugLocString(const Loop *L) {
  std::string Result;
  if (L) {
    raw_string_ostream OS(Result);
    if (const DebugLoc LoopDbgLoc = L->getStartLoc())
      LoopDbgLoc.print(OS);
    else
      // Just print the module name.
      OS << L->getHeader()->getParent()->getParent()->getModuleIdentifier();
    OS.flush();
  }
  return Result;
}
#endif

/// \brief Propagate known metadata from one instruction to another.
static void propagateMetadata(Instruction *To, const Instruction *From) {
  SmallVector<std::pair<unsigned, MDNode *>, 4> Metadata;
  From->getAllMetadataOtherThanDebugLoc(Metadata);

  for (auto M : Metadata) {
    unsigned Kind = M.first;

    // These are safe to transfer (this is safe for TBAA, even when we
    // if-convert, because should that metadata have had a control dependency
    // on the condition, and thus actually aliased with some other
    // non-speculated memory access when the condition was false, this would be
    // caught by the runtime overlap checks).
    if (Kind != LLVMContext::MD_tbaa &&
        Kind != LLVMContext::MD_alias_scope &&
        Kind != LLVMContext::MD_noalias &&
        Kind != LLVMContext::MD_fpmath &&
        Kind != LLVMContext::MD_nontemporal)
      continue;

    To->setMetadata(Kind, M.second);
  }
}

/// \brief Propagate known metadata from one instruction to a vector of others.
static void propagateMetadata(SmallVectorImpl<Value *> &To, const Instruction *From) {
  for (Value *V : To)
    if (Instruction *I = dyn_cast<Instruction>(V))
      propagateMetadata(I, From);
}

static void emitMissedWarning(Function *F, Loop *L,
                              const LoopVectorizeHints &LH) {
  emitOptimizationRemarkMissed(F->getContext(), SLV_NAME, *F, L->getStartLoc(),
                               LH.emitRemark());

  if (LH.getForce() == LoopVectorizeHints::FK_Enabled) {
    if (LH.getWidth() != 1)
      emitLoopVectorizeWarning(
          F->getContext(), *F, L->getStartLoc(),
          "failed explicitly specified loop vectorization");
    else if (LH.getInterleave() != 1)
      emitLoopInterleaveWarning(
          F->getContext(), *F, L->getStartLoc(),
          "failed explicitly specified loop interleaving");
  }
}

static void addInnerLoop(Loop &L, SmallVectorImpl<Loop *> &V) {
  if (L.empty())
    return V.push_back(&L);

  for (Loop *InnerL : L)
    addInnerLoop(*InnerL, V);
}


// Get a mask to interleave \p NumVec vectors into a wide vector.
// I.e.  <0, VF, VF*2, ..., VF*(NumVec-1), 1, VF+1, VF*2+1, ...>
// E.g. For 2 interleaved vectors, if VF is 4, the mask is:
//      <0, 4, 1, 5, 2, 6, 3, 7>
static Constant *getInterleavedMask(IRBuilder<> &Builder, unsigned VF,
                                    unsigned NumVec) {
  SmallVector<Constant *, 16> Mask;
  for (unsigned i = 0; i < VF; i++)
    for (unsigned j = 0; j < NumVec; j++)
      Mask.push_back(Builder.getInt32(j * VF + i));

  return ConstantVector::get(Mask);
}

// Get the strided mask starting from index \p Start.
// I.e.  <Start, Start + Stride, ..., Start + Stride*(VF-1)>
static Constant *getStridedMask(IRBuilder<> &Builder, unsigned Start,
                                unsigned Stride, unsigned VF) {
  SmallVector<Constant *, 16> Mask;
  for (unsigned i = 0; i < VF; i++)
    Mask.push_back(Builder.getInt32(Start + i * Stride));

  return ConstantVector::get(Mask);
}

// Get a mask of two parts: The first part consists of sequential integers
// starting from 0, The second part consists of UNDEFs.
// I.e. <0, 1, 2, ..., NumInt - 1, undef, ..., undef>
static Constant *getSequentialMask(IRBuilder<> &Builder, unsigned NumInt,
                                   unsigned NumUndef) {
  SmallVector<Constant *, 16> Mask;
  for (unsigned i = 0; i < NumInt; i++)
    Mask.push_back(Builder.getInt32(i));

  Constant *Undef = UndefValue::get(Builder.getInt32Ty());
  for (unsigned i = 0; i < NumUndef; i++)
    Mask.push_back(Undef);

  return ConstantVector::get(Mask);
}

// Concatenate two vectors with the same element type. The 2nd vector should
// not have more elements than the 1st vector. If the 2nd vector has less
// elements, extend it with UNDEFs.
static Value *ConcatenateTwoVectors(IRBuilder<> &Builder, Value *V1,
                                    Value *V2) {
  VectorType *VecTy1 = dyn_cast<VectorType>(V1->getType());
  VectorType *VecTy2 = dyn_cast<VectorType>(V2->getType());
  assert(VecTy1 && VecTy2 &&
         VecTy1->getScalarType() == VecTy2->getScalarType() &&
         "Expect two vectors with the same element type");

  unsigned NumElts1 = VecTy1->getNumElements();
  unsigned NumElts2 = VecTy2->getNumElements();
  assert(NumElts1 >= NumElts2 && "Unexpect the first vector has less elements");

  if (NumElts1 > NumElts2) {
    // Extend with UNDEFs.
    Constant *ExtMask =
        getSequentialMask(Builder, NumElts2, NumElts1 - NumElts2);
    V2 = Builder.CreateShuffleVector(V2, UndefValue::get(VecTy2), ExtMask);
  }

  Constant *Mask = getSequentialMask(Builder, NumElts1 + NumElts2, 0);
  return Builder.CreateShuffleVector(V1, V2, Mask);
}

// Concatenate vectors in the given list. All vectors have the same type.
static Value *ConcatenateVectors(IRBuilder<> &Builder,
                                 ArrayRef<Value *> InputList) {
  unsigned NumVec = InputList.size();
  assert(NumVec > 1 && "Should be at least two vectors");

  SmallVector<Value *, 8> ResList;
  ResList.append(InputList.begin(), InputList.end());
  do {
    SmallVector<Value *, 8> TmpList;
    for (unsigned i = 0; i < NumVec - 1; i += 2) {
      Value *V0 = ResList[i], *V1 = ResList[i + 1];
      assert((V0->getType() == V1->getType() || i == NumVec - 2) &&
             "Only the last vector may have a different type");

      TmpList.push_back(ConcatenateTwoVectors(Builder, V0, V1));
    }

    // Push the last vector if the total number of vectors is odd.
    if (NumVec % 2 != 0)
      TmpList.push_back(ResList[NumVec - 1]);

    ResList = TmpList;
    NumVec = ResList.size();
  } while (NumVec > 1);

  return ResList[0];
}


static Instruction *getFirstInst(Instruction *FirstInst, Value *V,
                                 Instruction *Loc) {
  if (FirstInst)
    return FirstInst;
  if (Instruction *I = dyn_cast<Instruction>(V))
    return I->getParent() == Loc->getParent() ? I : nullptr;
  return nullptr;
}


/// \brief Adds a 'fast' flag to floating point operations.
static Value *addFastMathFlag(Value *V) {
  if (isa<FPMathOperator>(V)){
    FastMathFlags Flags;
    Flags.setUnsafeAlgebra();
    cast<Instruction>(V)->setFastMathFlags(Flags);
  }
  return V;
}

////////////////////////////////////////////////////////////////////////////////
// InnerLoopVectorizer
////////////////////////////////////////////////////////////////////////////////

namespace {

  /// TODO: Correct comment. Very much outdated, even compared to the
  /// 'normal' vectorizer.

/// InnerLoopVectorizer vectorizes loops which contain only one basic
/// block to a specified vectorization factor (VF).
/// This class performs the widening of scalars into vectors, or multiple
/// scalars. This class also implements the following features:
/// * It inserts an epilogue loop for handling loops that don't have iteration
///   counts that are known to be a multiple of the vectorization factor.
/// * It handles the code generation for reduction variables.
/// * Scalarization (implementation using scalars) of un-vectorizable
///   instructions.
/// InnerLoopVectorizer does not perform any vectorization-legality
/// checks, and relies on the caller to check for the different legality
/// aspects. The InnerLoopVectorizer relies on the
/// LoopVectorizationLegality class to provide information about the induction
/// and reduction variables that were found to a given vectorization factor.
class InnerLoopVectorizer {
public:
  InnerLoopVectorizer(Loop *OrigLoop, PredicatedScalarEvolution &PSE,
                      LoopInfo *LI, DominatorTree *DT,
                      const TargetLibraryInfo *TLI,
                      const TargetTransformInfo *TTI, AssumptionCache *AC,
                      unsigned VecWidth, unsigned UnrollFactor, bool VecWidthIsFixed)
      : OrigLoop(OrigLoop), PSE(PSE), LI(LI), DT(DT), TLI(TLI), TTI(TTI), AC(AC),
        VF(VecWidth), Scalable(!VecWidthIsFixed),
        Builder(PSE.getSE()->getContext()),
        Induction(nullptr), OldInduction(nullptr), InductionStep(nullptr), PHMap(1),
        NextBodyWMap(1), BodyWMap(1), VTailWMap(1), TmpMakeIntoPHIsMap(1),
        VecBodyPostDom(nullptr), TripCount(nullptr), VectorTripCount(nullptr),
        Legal(nullptr), AddedSafetyChecks(false), LatchBranch(nullptr),
        IdxEnd(nullptr), IdxEndV(nullptr), BranchCounter(0) {}
  // Perform the actual loop widening (vectorization).
  // MinimumBitWidths maps scalar integer values to the smallest bitwidth they
  // can be validly truncated to. The cost model has assumed this truncation
  // will happen when vectorizing.
  // TODO: Don't need MinimumBitWidths if we're passing the whole cost model in.
  void vectorize(LoopVectorizationLegality *L, LoopVectorizationCostModel *C,
                 MapVector<Instruction*,uint64_t> MinimumBitWidths) {
    DEBUG(dbgs() << "SLV vectorizing loop: " << getDebugLocString(OrigLoop)
          << "\n");
    MinBWs = MinimumBitWidths;
    Legal = L;
    Costs = C;
    // Create a new empty loop. Unlink the old loop and connect the new one.
    createEmptyLoopWithPredication();
    // Widen each instruction in the old loop to a new one in the new loop.
    // Use the Legality module to find the induction and reduction variables.

    // TODO: Before this, preload BodyWMap with loop-invariant vals?
    vectorizeLoop();
  }

  // Return true if any runtime check is added.
  bool IsSafetyChecksAdded() {
    return AddedSafetyChecks;
  }

  virtual ~InnerLoopVectorizer() {}

protected:
  bool isScalable() {
    return (VF > 1) && Scalable;
  }

  /// A small list of PHINodes.
  typedef SmallVector<PHINode*, 4> PhiVector;
  /// When we unroll loops we have multiple vector values for each scalar.
  /// This data structure holds the unrolled and vectorized values that
  /// originated from one scalar instruction.
  typedef SmallVector<Value*, 2> VectorParts;

  // When we if-convert we need to create edge masks. We have to cache values
  // so that we don't end up with exponential recursion/IR.
  typedef DenseMap<std::pair<BasicBlock*, BasicBlock*>,
                   VectorParts> EdgeMaskCache;

  /// This is a helper class that holds the vectorizer state. It maps scalar
  /// instructions to vector instructions. When the code is 'unrolled' then
  /// then a single scalar value is mapped to multiple vector parts. The parts
  /// are stored in the VectorPart type.
  struct ValueMap {
    /// C'tor.  UnrollFactor controls the number of vectors ('parts') that
    /// are mapped.
    ValueMap(unsigned UnrollFactor) : UF(UnrollFactor) {}

    /// \return True if 'Key' is saved in the Value Map.
    bool has(Value *Key) const { return MapStorage.count(Key); }

    /// Initializes a new entry in the map. Sets all of the vector parts to the
    /// save value in 'Val'.
    /// \return A reference to a vector with splat values.
    VectorParts &splat(Value *Key, Value *Val) {
      VectorParts &Entry = MapStorage[Key];
      Entry.assign(UF, Val);
      return Entry;
    }

    ///\return A reference to the value that is stored at 'Key'.
    VectorParts &get(Value *Key) {
      VectorParts &Entry = MapStorage[Key];
      if (Entry.empty())
        Entry.resize(UF);
      assert(Entry.size() == UF);
      return Entry;
    }

    void clearValue(Value *Key){
      MapStorage.erase(Key);
    }

    void clear() {
      MapStorage.clear();
    }

  private:
    /// The unroll factor. Each entry in the map stores this number of vector
    /// elements.
    unsigned UF;

    /// Map storage. We use std::map and not DenseMap because insertions to a
    /// dense map invalidates its iterators.
    std::map<Value *, VectorParts> MapStorage;
  };

  /// \brief Add checks for strides that were assumed to be 1.
  ///
  /// Returns the last check instruction and the first check instruction in the
  /// pair as (first, last).
  std::pair<Instruction *, Instruction *> addStrideCheck(Instruction *Loc);

  /// Create an empty loop, using per-element predication to control termination
  void createEmptyLoopWithPredication();
  /// Create a new induction variable inside L.
  PHINode *createInductionVariable(Loop *L, Value *Start, Value *End,
                                   Value *Step, Instruction *DL);

  bool isIndvarPHIOrUpdate(Value *V, InductionDescriptor &II, bool &IsUpdate);
  bool allIndvarPHIsOrAllUpdates(Escapee *E, InductionDescriptor &II, bool &IsUpdate);

  /// Copy and widen the instructions from the old loop.
  virtual void vectorizeLoop();
  virtual void insertVectorTail(LoopBlocksDFS& DFS);
  PHINode *createTailPhiFromPhi(PHINode *PN, const Twine &Name="");
  PHINode *createTailPhiFromValues(Value *ValPH, Value *ValVB, const Twine &Name="");

  /// \brief The Loop exit block may have single value PHI nodes where the
  /// incoming value is 'Undef'. While vectorizing we only handled real values
  /// that were defined inside the loop. Here we fix the 'undef case'.
  /// See PR14725.
  void fixLCSSAPHIs();

  /// Shrinks vector element sizes based on information in "MinBWs".
  void truncateToMinimalBitwidths(ValueMap &WidenMap);

  /// A helper function that computes the predicate of the block BB, assuming
  /// that the header block of the loop is set to True. It returns the *entry*
  /// mask for the block BB.
  VectorParts createBlockInMask(BasicBlock *BB, ValueMap &WidenMap);
  /// A helper function that computes the predicate of the edge between SRC
  /// and DST.
  VectorParts createEdgeMask(BasicBlock *Src, BasicBlock *Dst,
                             ValueMap &WidenMap);

  /// A helper function to vectorize a single BB within the innermost loop.
  void vectorizeBlockInLoop(BasicBlock *BB, PhiVector *PV, ValueMap &WidenMap);

  void widenInstruction(Instruction *it, BasicBlock *BB, PhiVector *PV,
                        ValueMap &WidenMap);

  /// Vectorize a single PHINode in a block. This method handles the induction
  /// variable canonicalization. It supports both VF = 1 for unrolled loops and
  /// arbitrary length vectors.
  void widenPHIInstruction(Instruction *PN, VectorParts &Entry,
                           unsigned VF, PhiVector *PV,
                           ValueMap &WidenMap);

  /// Insert early break checks using Map as the ValueMap, and Pred
  /// as starting Predicate condition, and Induction as the induction
  /// variable to use.
  /// Returns the 'and'ed value for all conditions.
  /// Each (vectorised) condition is separately stored in 'Conditions'.
  Value *insertEarlyBreaks(ValueMap &Map, Value *Induction,
                           SmallVectorImpl<Value*> &Conditions, Value *Pred);

  // TODO: Reword.
  // Patch up the condition for a branch instruction after the block has been
  // vectorized; only used with predication for now.
  void vectorizeExits();

  /// Insert the new loop to the loop hierarchy and pass manager
  /// and update the analysis passes.
  void updateAnalysis();

  /// This instruction is un-vectorizable. Implement it as a sequence
  /// of scalars. If \p IfPredicateStore is true we need to 'hide' each
  /// scalarized instruction behind an if block predicated on the control
  /// dependence of the instruction.
  virtual void scalarizeInstruction(Instruction *Instr,
                                    ValueMap &WidenMap,
                                    bool IfPredicateStore=false);

  /// Scalarize instruction using a sub-loop within the vector body.
  virtual void scalarizeInstructionWithSubloop(Instruction *Instr,
                                               ValueMap &WidenMap,
                                               bool IfPredicateStore = false);

  /// Vectorize Load and Store instructions,
  virtual void vectorizeMemoryInstruction(Instruction *Instr, ValueMap &WidenMap);
  virtual void vectorizeArithmeticGEP(Instruction *Instr, ValueMap &WidenMap);
  virtual void vectorizeGEPInstruction(Instruction *Instr, ValueMap &WidenMap);

  /// Create a broadcast instruction. This method generates a broadcast
  /// instruction (shuffle) for loop invariant values and for the induction
  /// value. If this is the induction variable then we extend it to N, N+1, ...
  /// this is needed because each iteration in the loop corresponds to a SIMD
  /// element.
  virtual Value *getBroadcastInstrs(Value *V);

  /// This function adds (Start, Start + Step, Start + 2*Step, ...)
  /// to each vector element of Val. The sequence starts at StartIndex.
  virtual Value *getStepVector(Value *Val, int Start, Value *Step);
  virtual Value *getStepVector(Value *Val, Value* Start, Value *Step);

  /// This function adds (StartIdx, StartIdx + Step, StartIdx + 2*Step, ...)
  /// to each vector element of Val. The sequence starts at StartIndex.
  /// Step is a SCEV. In order to get StepValue it takes the existing value
  /// from SCEV or creates a new using SCEVExpander.
  virtual Value *getStepVector(Value *Val, Value *Start, const SCEV *Step);

  virtual Value *getElementCount(Type* ETy, unsigned NumElts, bool Scalable,
                                 Type* RTy = nullptr);

  Value *getExclusivePartition(Value *Pred);
  Value *getInclusivePartition(Value *Pred);

  /// When we go over instructions in the basic block we rely on previous
  /// values within the current basic block or on loop invariant values.
  /// When we widen (vectorize) values we place them in the map. If the values
  /// are not within the map, they have to be loop invariant, so we simply
  /// broadcast them into a vector.
  VectorParts &getVectorValue(Value *V, ValueMap &WidenMap);

  /// Try to vectorize the interleaved access group that \p Instr belongs to.
  void vectorizeInterleaveGroup(Instruction *Instr, ValueMap &WidenMap);

  /// Generate a shuffle sequence that will reverse the vector Vec.
  virtual Value *reverseVector(Value *Vec);

  /// Returns (and creates if needed) the original loop trip count.
  Value *getOrCreateTripCount(Loop *NewLoop);

  /// Returns (and creates if needed) the trip count of the widened loop.
  Value *getOrCreateVectorTripCount(Loop *NewLoop);

  /// Emit a bypass check to see if the trip count would overflow, or we
  /// wouldn't have enough iterations to execute one vector loop.
  void emitMinimumIterationCountCheck(Loop *L, BasicBlock *Bypass);
  /// Emit a bypass check to see if the vector trip count is nonzero.
  void emitVectorLoopEnteredCheck(Loop *L, BasicBlock *Bypass);
  /// Emit a bypass check to see if all of the SCEV assumptions we've
  /// had to make are correct.
  void emitSCEVChecks(Loop *L, BasicBlock *Bypass);
  /// Emit bypass checks to check any memory assumptions we may have made.
  void emitMemRuntimeChecks(Loop *L, BasicBlock *Bypass);

  ///\brief Perform CSE of induction variable instructions.
  void CSE(SmallVector<BasicBlock *, 4> &BBs, SmallSet<BasicBlock *, 2> &Preds);

  /// The original loop.
  Loop *OrigLoop;
  /// Scev analysis to use.
  PredicatedScalarEvolution &PSE;
  /// Loop Info.
  LoopInfo *LI;
  /// Dominator Tree.
  DominatorTree *DT;
  /// Target Library Info.
  const TargetLibraryInfo *TLI;
  /// Target Transform Info.
  const TargetTransformInfo *TTI;
  /// Assumption Cache.
  AssumptionCache *AC;
  /// Alias Analysis.
  AliasAnalysis *AA;

  /// The vectorization SIMD factor to use. Each vector will have this many
  /// vector elements.
  unsigned VF;
  bool Scalable;

protected:
  /// The builder that we use
  IRBuilder<> Builder;

  // --- Vectorization state ---
  /// The new inner loop
  Loop *SLVLoop;
  /// The vector-loop preheader.
  BasicBlock *LoopVectorPreHeader;
  /// The scalar-loop preheader.
  BasicBlock *LoopScalarPreHeader;
  /// Vector tail following vector body.
  BasicBlock *LoopVectorTail;
  ///The ExitBlock of the scalar loop.
  BasicBlock *LoopExitBlock;
  ///The vector loop body.
  SmallVector<BasicBlock *, 4> LoopVectorBody;
  ///The scalar loop body.
  BasicBlock *LoopScalarBody;
  /// A list of all bypass blocks. The first block is the entry of the loop.
  SmallVector<BasicBlock *, 4> LoopBypassBlocks;
  /// Blocks needed for performing scalable reduction across a vector
  /// @{
  BasicBlock *ReductionLoop;
  BasicBlock *ReductionLoopRet;
  /// }@
  /// The new Induction variable which was added to the new block.
  Value *Induction;
  /// PHI node only available in vector tail
  Value *PrevInduction;
  Value *InductionStartIdx;
  /// The induction variable of the old basic block.
  PHINode *OldInduction;
  /// Value of the induction var for the next loop trip
  Value *InductionStep;
  /// Holds the entry predicates for the current iteration of the vector body.
  Value *Predicate;
  MapVector<Instruction*,Value*> SpeculativePredicates;
  PHINode *TailSpeculativeLanes;
  /// Incoming predicate for vector tail, coming from either preheader
  /// or vector body.
  Value *PreHeaderOutPred;
  Value *VecBodyOutPred;
  /// Holds the extended (to the widest induction type) start index.
  Value *ExtendedIdx;
  /// Maps scalars to widened vectors.
  ValueMap PHMap;
  ValueMap NextBodyWMap;
  ValueMap BodyWMap;
  ValueMap VTailWMap;
  ValueMap TmpMakeIntoPHIsMap;
  SmallSet<Value*,10> ConditionNodes;
  /// Store instructions that should be predicated, as a pair
  ///   <StoreInst, Predicate>
  SmallVector<std::pair<StoreInst*,Value*>, 4> PredicatedStores;
  EdgeMaskCache MaskCache;

  // Loop vector body current post-dominator block.
  BasicBlock *VecBodyPostDom;
  typedef std::pair<BasicBlock *, BasicBlock *> DomEdge;
  SmallVector<DomEdge, 4> VecBodyDomEdges;

  // Conditional blocks due to if-conversion.
  SmallSet<BasicBlock *, 2> PredicatedBlocks;
  /// Trip count of the original loop.
  Value *TripCount;
  /// Trip count of the widened loop (TripCount - TripCount % (VF*UF))
  Value *VectorTripCount;

  /// Map of scalar integer values to the smallest bitwidth they can be legally
  /// represented as. The vector equivalents of these values should be truncated
  /// to this type.
  MapVector<Instruction*,uint64_t> MinBWs;
  LoopVectorizationLegality *Legal;
  LoopVectorizationCostModel *Costs;

  // Record whether runtime check is added.
  bool AddedSafetyChecks;

  /// Stores new branch for vectorized latch block so it
  /// can be patched up after vectorization
  BranchInst *LatchBranch;

  /// TODO -- rename this and InductionStep?
  /// TODO -- move both to exit info descriptor?
  Value *IdxEnd;
  Value *IdxEndV;

  /// Does the induction variable expression have nsw/nuw flags?
  bool IndVarNoWrap;

  // Set of nodes that should be made into PHIs in the original loop
  // when we hoist the early-exit condition out of the loop, but one
  // of the condition's subexpressions is reused somewhere in the loop
  // body after the condition.
  SmallSet<Value*,10> MakeTheseIntoPHIs;

  /// The BranchCounter tells the vectorizer which Escapee values to select
  /// using the current predicate.
  unsigned BranchCounter;

  /// The Green vector lanes are always executed
  Value *GreenLanes;
  /// The Yellow vector lanes are executed before the mid-body exit
  /// and are defined as the GreenLanes + 1 lane.
  Value *YellowLanes;

  /// TODO: Set to false above?
  bool HasSpeculativeLoads;

};

  // TODO: Move this struct?

  //namespace {
struct CSEDenseMapInfo {
  static bool canHandle(Instruction *I) {
    return isa<InsertElementInst>(I) || isa<ExtractElementInst>(I) ||
           isa<ShuffleVectorInst>(I) || isa<GetElementPtrInst>(I);
  }
  static inline Instruction *getEmptyKey() {
    return DenseMapInfo<Instruction *>::getEmptyKey();
  }
  static inline Instruction *getTombstoneKey() {
    return DenseMapInfo<Instruction *>::getTombstoneKey();
  }
  static unsigned getHashValue(Instruction *I) {
    assert(canHandle(I) && "Unknown instruction!");
    return hash_combine(I->getOpcode(), hash_combine_range(I->value_op_begin(),
                                                           I->value_op_end()));
  }
  static bool isEqual(Instruction *LHS, Instruction *RHS) {
    if (LHS == getEmptyKey() || RHS == getEmptyKey() ||
        LHS == getTombstoneKey() || RHS == getTombstoneKey())
      return LHS == RHS;
    return LHS->isIdenticalTo(RHS);
  }
};
  //}

//===----------------------------------------------------------------------===//
// Implementation of InnerLoopVectorizer
//===----------------------------------------------------------------------===//

Value *InnerLoopVectorizer::getBroadcastInstrs(Value *V) {
  // We need to place the broadcast of invariant variables outside the loop.
  Instruction *Instr = dyn_cast<Instruction>(V);
  bool NewInstr =
      (Instr && std::find(LoopVectorBody.begin(), LoopVectorBody.end(),
                          Instr->getParent()) != LoopVectorBody.end());
  bool Invariant = OrigLoop->isLoopInvariant(V) && !NewInstr;

  // Place the code for broadcasting invariant variables in the new preheader.
  //  IRBuilder<>::InsertPointGuard Guard(Builder);
  IRBuilder<>::InsertPoint IP = Builder.saveIP();

  // Broadcast the scalar into all locations in the vector.
  Value *Shuf = Builder.CreateVectorSplat({VF, Scalable}, V, "broadcast");

  if (Invariant)
    Builder.restoreIP(IP);

  return Shuf;
}

Value *InnerLoopVectorizer::getStepVector(Value *Val, Value *Start,
                                          const SCEV *StepSCEV) {
  const DataLayout &DL = OrigLoop->getHeader()->getModule()->getDataLayout();
  SCEVExpander Exp(*PSE.getSE(), DL, "induction");
  Value *StepValue = Exp.expandCodeFor(StepSCEV, StepSCEV->getType(),
                                       &*Builder.GetInsertPoint());
  return getStepVector(Val, Start, StepValue);
}

Value *InnerLoopVectorizer::getStepVector(Value *Val, int Start, Value *Step) {
  Type *Ty = Val->getType()->getScalarType();
  return getStepVector(Val, ConstantInt::get(Ty, Start), Step);
}

Value *InnerLoopVectorizer::getStepVector(Value *Val, Value *Start,
                                          Value *Step) {
  assert(Val->getType()->isVectorTy() && "Must be a vector");
  assert(Val->getType()->getScalarType()->isIntegerTy() &&
         "Elem must be an integer");
  assert(Step->getType() == Val->getType()->getScalarType() &&
         "Step has wrong type");

  VectorType *Ty = cast<VectorType>(Val->getType());
  Value *One = ConstantInt::get(Start->getType(), 1);

  // Create a vector of consecutive numbers from Start to Start+VF
  Value *Cv = Builder.CreateSeriesVector(Ty->getElementCount(), Start, One);

  // Add the consecutive indices to the vector value.
  assert(Cv->getType() == Val->getType() && "Invalid consecutive vec");
  Step = Builder.CreateVectorSplat(Ty->getElementCount(), Step);
  // FIXME: The newly created binary instructions should contain nsw/nuw flags,
  // which can be found from the original scalar operations.
  Step = Builder.CreateMul(Cv, Step);
  return Builder.CreateAdd(Val, Step, "induction");
}

Value *InnerLoopVectorizer::getElementCount(Type* ElemTy, unsigned NumElts,
                                            bool Scalable, Type* RetTy) {
  if (!RetTy)
    RetTy = Builder.getInt32Ty();

  Value *V = UndefValue::get(VectorType::get(ElemTy, NumElts, Scalable));
  return Builder.CreateElementCount(RetTy, V);
}

Value *InnerLoopVectorizer::getExclusivePartition(Value *Pred) {
  Value *PTrue = ConstantInt::getTrue(Pred->getType());
  return Builder.CreatePropFF(PTrue, Pred);
}

Value *InnerLoopVectorizer::getInclusivePartition(Value *Pred) {
  // TODO: Consider adding modulus of the count to ensure we never
  // wrap around. Right now this won't happen since we will only
  // use this in the tail where we cannot have a full predicate,
  // but we may make use of it elsewhere in future. A backend
  // pass should pick it up and transform into an appropriate
  // instruction anyway.
  Value *PTrue = ConstantInt::getTrue(Pred->getType());
  Value *Exclusive = Builder.CreatePropFF(PTrue, Pred);
  Value *EECnt = Builder.CreateCntVPop(Exclusive, "cntp.incpart");
  Value *OneLane = ConstantInt::getTrue(Builder.getInt1Ty());
  return Builder.CreateInsertElement(Exclusive, OneLane, EECnt);
}

InnerLoopVectorizer::VectorParts&
InnerLoopVectorizer::getVectorValue(Value *V, ValueMap& WidenMap) {
  assert(!V->getType()->isVectorTy() && "Can't widen a vector");

  // If we have a stride that is replaced by one, do it here.
  if (Legal->hasStride(V))
    V = ConstantInt::get(V->getType(), 1);

  // If we have this scalar in the map, return it.
  if (WidenMap.has(V))
    return WidenMap.get(V);

  // If this scalar is unknown, assume that it is a constant or that it is
  // loop invariant. Broadcast V and save the value for future uses.
  Value *B = getBroadcastInstrs(V);
  return WidenMap.splat(V, B);
}

Value *InnerLoopVectorizer::reverseVector(Value *Vec) {
  assert(Vec->getType()->isVectorTy() && "Invalid type");
  VectorType *Ty = cast<VectorType>(Vec->getType());

  // i32 reverse_mask[n] = { n-1, n-2...1, 0 }
  Value *NumEls = getElementCount(Ty->getElementType(), VF, Scalable);
  Value *Start = Builder.CreateSub(NumEls, Builder.getInt32(1));
  Value *Step  = ConstantInt::get(Start->getType(), -1, true);
  Value *Mask  = Builder.CreateSeriesVector({VF,Scalable}, Start, Step);

  return Builder.CreateShuffleVector(Vec, UndefValue::get(Ty), Mask, "reverse");
}

// Try to vectorize the interleave group that \p Instr belongs to.
//
// E.g. Translate following interleaved load group (factor = 3):
//   for (i = 0; i < N; i+=3) {
//     R = Pic[i];             // Member of index 0
//     G = Pic[i+1];           // Member of index 1
//     B = Pic[i+2];           // Member of index 2
//     ... // do something to R, G, B
//   }
// To:
//   %wide.vec = load <12 x i32>                       ; Read 4 tuples of R,G,B
//   %R.vec = shuffle %wide.vec, undef, <0, 3, 6, 9>   ; R elements
//   %G.vec = shuffle %wide.vec, undef, <1, 4, 7, 10>  ; G elements
//   %B.vec = shuffle %wide.vec, undef, <2, 5, 8, 11>  ; B elements
//
// Or translate following interleaved store group (factor = 3):
//   for (i = 0; i < N; i+=3) {
//     ... do something to R, G, B
//     Pic[i]   = R;           // Member of index 0
//     Pic[i+1] = G;           // Member of index 1
//     Pic[i+2] = B;           // Member of index 2
//   }
// To:
//   %R_G.vec = shuffle %R.vec, %G.vec, <0, 1, 2, ..., 7>
//   %B_U.vec = shuffle %B.vec, undef, <0, 1, 2, 3, u, u, u, u>
//   %interleaved.vec = shuffle %R_G.vec, %B_U.vec,
//        <0, 4, 8, 1, 5, 9, 2, 6, 10, 3, 7, 11>    ; Interleave R,G,B elements
//   store <12 x i32> %interleaved.vec              ; Write 4 tuples of R,G,B
void InnerLoopVectorizer::vectorizeInterleaveGroup(Instruction *Instr,
                                                   ValueMap &WidenMap) {
  const InterleaveGroup *Group = Legal->getInterleavedAccessGroup(Instr);
  assert(Group && "Fail to get an interleaved access group.");

  // Skip if current instruction is not the insert position.
  if (Instr != Group->getInsertPos())
    return;

  LoadInst *LI = dyn_cast<LoadInst>(Instr);
  StoreInst *SI = dyn_cast<StoreInst>(Instr);
  Value *Ptr = LI ? LI->getPointerOperand() : SI->getPointerOperand();

  // Prepare for the vector type of the interleaved load/store.
  Type *ScalarTy = LI ? LI->getType() : SI->getValueOperand()->getType();
  unsigned InterleaveFactor = Group->getFactor();
  Type *VecTy = VectorType::get(ScalarTy, InterleaveFactor * VF, Scalable);
  Type *PtrTy = VecTy->getPointerTo(Ptr->getType()->getPointerAddressSpace());

  // Prepare for the new pointers.
  setDebugLocFromInst(Builder, Ptr);
  VectorParts &PtrParts = getVectorValue(Ptr, WidenMap);
  SmallVector<Value *, 2> NewPtrs;
  unsigned Index = Group->getIndex(Instr);
  // Extract the pointer for current instruction from the pointer vector. A
  // reverse access uses the pointer in the last lane.
  Value *NewPtr = Builder.CreateExtractElement(PtrParts[0],
        Group->isReverse() ? Builder.getInt32(VF - 1) : Builder.getInt32(0));

  // Notice current instruction could be any index. Need to adjust the address
  // to the member of index 0.
  //
  // E.g.  a = A[i+1];     // Member of index 1 (Current instruction)
  //       b = A[i];       // Member of index 0
  // Current pointer is pointed to A[i+1], adjust it to A[i].
  //
  // E.g.  A[i+1] = a;     // Member of index 1
  //       A[i]   = b;     // Member of index 0
  //       A[i+2] = c;     // Member of index 2 (Current instruction)
  // Current pointer is pointed to A[i+2], adjust it to A[i].
  NewPtr = Builder.CreateGEP(NewPtr, Builder.getInt32(-Index));

  // Cast to the vector pointer type.
  NewPtrs.push_back(Builder.CreateBitCast(NewPtr, PtrTy));

  setDebugLocFromInst(Builder, Instr);
  Value *UndefVec = UndefValue::get(VecTy);

  // Vectorize the interleaved load group.
  if (LI) {
    Instruction *NewLoadInstr = Builder.CreateAlignedLoad(
          NewPtrs[0], Group->getAlignment(), "wide.vec");

    for (unsigned i = 0; i < InterleaveFactor; i++) {
      Instruction *Member = Group->getMember(i);

      // Skip the gaps in the group.
      if (!Member)
        continue;

      Constant *StrideMask = getStridedMask(Builder, i, InterleaveFactor, VF);
      Value *StridedVec = Builder.CreateShuffleVector(
          NewLoadInstr, UndefVec, StrideMask, "strided.vec");

      // If this member has different type, cast the result type.
      if (Member->getType() != ScalarTy) {
        VectorType *OtherVTy = VectorType::get(Member->getType(), VF,
                                               Scalable);
        StridedVec = Builder.CreateBitOrPointerCast(StridedVec, OtherVTy);
      }

      VectorParts &Entry = WidenMap.get(Member);
      Entry[0] =
        Group->isReverse() ? reverseVector(StridedVec) : StridedVec;
    }

    propagateMetadata(NewLoadInstr, Instr);
    return;
  }

  // The sub vector type for current instruction.
  VectorType *SubVT = VectorType::get(ScalarTy, VF, Scalable);

  // Vectorize the interleaved store group.
  // Collect the stored vector from each member.
  SmallVector<Value *, 4> StoredVecs;
  for (unsigned i = 0; i < InterleaveFactor; i++) {
    // Interleaved store group doesn't allow a gap, so each index has a member
    Instruction *Member = Group->getMember(i);
    assert(Member && "Fail to get a member from an interleaved store group");

    Value *StoredVec =
      getVectorValue(dyn_cast<StoreInst>(Member)->getValueOperand(), WidenMap)[0];
    if (Group->isReverse())
      StoredVec = reverseVector(StoredVec);

    // If this member has different type, cast it to an unified type.
    if (StoredVec->getType() != SubVT)
      StoredVec = Builder.CreateBitOrPointerCast(StoredVec, SubVT);

    StoredVecs.push_back(StoredVec);
  }

  // Concatenate all vectors into a wide vector.
  Value *WideVec = ConcatenateVectors(Builder, StoredVecs);

  // Interleave the elements in the wide vector.
  Constant *IMask = getInterleavedMask(Builder, VF, InterleaveFactor);
  Value *IVec = Builder.CreateShuffleVector(WideVec, UndefVec, IMask,
                                            "interleaved.vec");

  Instruction *NewStoreInstr =
    Builder.CreateAlignedStore(IVec, NewPtrs[0], Group->getAlignment());
  propagateMetadata(NewStoreInstr, Instr);
}

void InnerLoopVectorizer::vectorizeMemoryInstruction(Instruction *Instr,
                                                     ValueMap &WidenMap) {
  // Attempt to issue a wide load.
  LoadInst *LI = dyn_cast<LoadInst>(Instr);
  StoreInst *SI = dyn_cast<StoreInst>(Instr);

  assert((LI || SI) && "Invalid Load/Store instruction");

  // Try to vectorize the interleave group if this access is interleaved.
  if (Legal->isAccessInterleaved(Instr))
    return vectorizeInterleaveGroup(Instr, WidenMap);

  Type *ScalarDataTy = LI ? LI->getType() : SI->getValueOperand()->getType();
  Type *DataTy = VectorType::get(ScalarDataTy, VF, Scalable);
  Value *Ptr = LI ? LI->getPointerOperand() : SI->getPointerOperand();
  unsigned Alignment = LI ? LI->getAlignment() : SI->getAlignment();
  // An alignment of 0 means target abi alignment. We need to use the scalar's
  // target abi alignment in such a case.
  const DataLayout &DL = Instr->getModule()->getDataLayout();
  if (!Alignment)
    Alignment = DL.getABITypeAlignment(ScalarDataTy);
  unsigned AddressSpace = Ptr->getType()->getPointerAddressSpace();
  unsigned ScalarAllocatedSize = DL.getTypeAllocSize(ScalarDataTy);
  unsigned VectorElementSize = DL.getTypeStoreSize(DataTy) / VF;

  if (SI && Legal->blockNeedsPredication(SI->getParent()) &&
      !Legal->isMaskRequired(SI))
    return scalarizeInstruction(Instr, WidenMap, true);

  if (ScalarAllocatedSize != VectorElementSize)
    return scalarizeInstruction(Instr, WidenMap);

  // If the pointer is loop invariant or if it is non-consecutive,
  // scalarize the load.
  int ConsecutiveStride = Legal->isConsecutivePtr(Ptr);
  bool Reverse = ConsecutiveStride < 0;
  bool UniformLoad = LI && Legal->isUniform(Ptr);

  // TODO: Check for S/G capability instead of scalable?
  if (!isScalable() && (!ConsecutiveStride || UniformLoad))
    return scalarizeInstruction(Instr, WidenMap);

  Constant *Zero = Builder.getInt32(0);
  VectorParts &Entry = WidenMap.get(Instr);

  // TODO: Is there a bit of metadata to check for possible aliasing?
  if (UniformLoad) {
    assert(isScalable() && "non-WA Uniform loads should have been scalarized");

    // Generate a scalar load...
    Instruction *NewLI = Builder.CreateLoad(Ptr);
    propagateMetadata(NewLI, LI);

    // ... and splat it.
    Entry[0] = Builder.CreateVectorSplat({VF,Scalable}, NewLI, "uniform_load");

    return;
  }

  // Handle scatter/gather loads/stores...
  if (std::abs(ConsecutiveStride) != 1) {
    VectorParts Mask = createBlockInMask(Instr->getParent(), WidenMap);

    if (LI) {
      assert(&WidenMap != &NextBodyWMap &&
             "First faulting gather not yet supported");

      VectorParts &Ptrs = getVectorValue(Ptr, WidenMap);
      Value *P = Predicate;
      if (Legal->isMaskRequired(LI))
        P = Builder.CreateAnd(P, Mask[0]);

      auto *NewLI = Builder.CreateMaskedGather(Ptrs[0], Alignment, P);
      propagateMetadata(NewLI, LI);
      Entry[0] = NewLI;
    }

    if (SI) {
      VectorParts &Ptrs = getVectorValue(Ptr, WidenMap);
      VectorParts &Vals = getVectorValue(SI->getValueOperand(), WidenMap);
      Value *P = Predicate;
      if (Legal->isMaskRequired(SI))
        P = Builder.CreateAnd(P, Mask[0]);

      auto *NewSI = Builder.CreateMaskedScatter(Vals[0], Ptrs[0],
                                                Alignment, P);
      propagateMetadata(NewSI, SI);
    }

    return;
  } else {
    // Handle consecutive loads/stores.
    assert(ConsecutiveStride && "Consecutive load/store expected.");

    GetElementPtrInst *Gep = getGEPInstruction(Ptr);
    if (Gep && Legal->isInductionVariable(Gep->getPointerOperand())) {
      setDebugLocFromInst(Builder, Gep);
      Value *PtrOperand = Gep->getPointerOperand();
      Value *FirstBasePtr = getVectorValue(PtrOperand, WidenMap)[0];
      FirstBasePtr = Builder.CreateExtractElement(FirstBasePtr, Zero);

      // Create the new GEP with the new induction variable.
      GetElementPtrInst *Gep2 = cast<GetElementPtrInst>(Gep->clone());
      Gep2->setOperand(0, FirstBasePtr);
      Gep2->setName("gep.indvar.base");
      Ptr = Builder.Insert(Gep2);
    } else if (Gep) {
      setDebugLocFromInst(Builder, Gep);
      ScalarEvolution *SE = PSE.getSE();
      assert(SE->isLoopInvariant(SE->getSCEV(Gep->getPointerOperand()),
                                 OrigLoop) && "Base ptr must be invariant");

      // The last index does not have to be the induction. It can be
      // consecutive and be a function of the index. For example A[I+1];
      unsigned NumOperands = Gep->getNumOperands();
      unsigned InductionOperand = getGEPInductionOperand(Gep);
      // Create the new GEP with the new induction variable.
      GetElementPtrInst *Gep2 = cast<GetElementPtrInst>(Gep->clone());

      for (unsigned i = 0; i < NumOperands; ++i) {
        Value *GepOperand = Gep->getOperand(i);
        Instruction *GepOperandInst = dyn_cast<Instruction>(GepOperand);

        // Update last index or loop invariant instruction anchored in loop.
        if (i == InductionOperand ||
            (GepOperandInst && OrigLoop->contains(GepOperandInst))) {
          assert((i == InductionOperand ||
                 SE->isLoopInvariant(SE->getSCEV(GepOperandInst), OrigLoop)) &&
                 "Must be last index or loop invariant");

          VectorParts &GEPParts = getVectorValue(GepOperand, WidenMap);
          Value *Index = GEPParts[0];
          Index = Builder.CreateExtractElement(Index, Zero);
          Gep2->setOperand(i, Index);
          Gep2->setName("gep.indvar.idx");
        }
      }
      Ptr = Builder.Insert(Gep2);
    } else {
      // TODO: Ideally this should be used for all contiguous accesses.
      setDebugLocFromInst(Builder, Ptr);
      VectorParts &PtrVal = getVectorValue(Ptr, WidenMap);
      Ptr = Builder.CreateExtractElement(PtrVal[0], Zero);
    }
  }

  Type *DataPtrTy = DataTy->getPointerTo(AddressSpace);
  Value *Mask = Predicate;
  if (Legal->isMaskRequired(Instr))
    Mask = createBlockInMask(Instr->getParent(), WidenMap)[0];

  // Handle Stores:
  if (SI) {
    assert(!Legal->isUniform(SI->getPointerOperand()) &&
           "We do not allow storing to uniform addresses");
    setDebugLocFromInst(Builder, SI);
    // We don't want to update the value in the map as it might be used in
    // another expression. So don't use a reference type for "StoredVal".
    VectorParts StoredVal = getVectorValue(SI->getValueOperand(), WidenMap);

    // Calculate the index for the specific unroll-part.
    Value *VecPtr;
    if (Reverse) {
      // If the address is consecutive but reversed, then the
      // wide store needs to start at the last vector element.
      VecPtr = Builder.CreateGEP(Ptr, Builder.getInt32(1));
      VecPtr = Builder.CreateBitCast(VecPtr, DataPtrTy);
      VecPtr = Builder.CreateGEP(VecPtr, Builder.getInt32(-1));
    } else {
      VecPtr = Builder.CreateBitCast(Ptr, DataPtrTy);
      VecPtr = Builder.CreateGEP(VecPtr, Builder.getInt32(0));
    }

    Value *Data = StoredVal[0];
    if (Reverse)
      Data = reverseVector(Data);

    Instruction* NewSI;
    if (Legal->isMaskRequired(SI)) {
      Mask = Builder.CreateAnd(Mask, Predicate);

      if (Reverse)
        Mask = reverseVector(Mask);

      NewSI = Builder.CreateMaskedStore(Data, VecPtr, Alignment, Mask);
    } else {
      Value* P = Reverse ? reverseVector(Predicate) : Predicate;
      NewSI = Builder.CreateMaskedStore(Data, VecPtr, Alignment, P);
    }

    propagateMetadata(NewSI, SI);
    return;
  }

  // Handle loads.
  assert(LI && "Must have a load instruction");
  setDebugLocFromInst(Builder, LI);
  // Calculate the pointer for the specific unroll-part.
  Value *VecPtr;
  if (Reverse) {
    // If the address is consecutive but reversed, then the
    // wide load needs to start at the last vector element.
    VecPtr = Builder.CreateGEP(Ptr, Builder.getInt32(1));
    VecPtr = Builder.CreateBitCast(VecPtr, DataPtrTy);
    VecPtr = Builder.CreateGEP(VecPtr, Builder.getInt32(-1));
  } else {
    VecPtr = Builder.CreateBitCast(Ptr, DataPtrTy);
    VecPtr = Builder.CreateGEP(VecPtr, Builder.getInt32(0));
  }

  Instruction* NewLI;
  unsigned Part = 0;
  if (Legal->isMaskRequired(LI)) {
    Mask = Builder.CreateAnd(Mask, Predicate);

    if (Reverse)
      Mask = reverseVector(Mask);

    // Every speculative load in BodyMap and VTailWMap is guaranteed
    // to be non-faulting, as it cannot be a load for one of the loop
    // exit conditions.
    // TODO: Also support first faulting gather loads.
    if (Legal->isUncountedLoop() &&
        &WidenMap != &BodyWMap &&
        &WidenMap != &VTailWMap) {
      NewLI = Builder.CreateMaskedSpecLoad(VecPtr, Alignment, Mask,
                                           UndefValue::get(DataTy),
                                           "wide.masked.specload");

      auto *SpeculativeLanes = Builder.CreateExtractValue(NewLI, 1);
      SpeculativePredicates.insert(std::make_pair(LI, SpeculativeLanes));
      NewLI = cast<ExtractValueInst>(Builder.CreateExtractValue(NewLI, 0));
    } else {
      NewLI = Builder.CreateMaskedLoad(VecPtr, Alignment, Mask,
                                       UndefValue::get(DataTy),
                                       "wide.masked.load");
    }
  } else {
    Value* P = Reverse ? reverseVector(Predicate) : Predicate;
    if (Legal->isUncountedLoop() &&
        &WidenMap != &BodyWMap &&
        &WidenMap != &VTailWMap) {
      NewLI = Builder.CreateMaskedSpecLoad(VecPtr, Alignment, P,
                                           UndefValue::get(DataTy),
                                           "wide.masked.specload");

      auto *SpeculativeLanes = Builder.CreateExtractValue(NewLI, 1);
      SpeculativePredicates.insert(std::make_pair(LI, SpeculativeLanes));
      NewLI = cast<ExtractValueInst>(Builder.CreateExtractValue(NewLI, 0));
    } else {
      NewLI = Builder.CreateMaskedLoad(VecPtr, Alignment, P,
                                       UndefValue::get(DataTy),
                                       "wide.masked.load");
    }
  }

  propagateMetadata(NewLI, LI);
  Entry[Part] = Reverse ? reverseVector(NewLI) : NewLI;
}

/// Depending on the access pattern, either of three things happen with
/// the GetElementPtr instruction:
/// - GEP is loop invariant:
///     Nothing
/// - GEP is affine function of loop iteration counter:
///     GEP is replaced by a seriesvector(%ptr, %stride)
/// - GEP is not affine:
/// - GEP pointer is a vectorized GEP instruction::
///     GEP is replaced by a vector of pointers using arithmetic
void InnerLoopVectorizer::vectorizeGEPInstruction(Instruction *Instr,
                                                  ValueMap &WidenMap) {
  GetElementPtrInst *Gep = cast<GetElementPtrInst>(Instr);

  if (!isScalable()) {
    scalarizeInstruction(Instr, WidenMap);
    return;
  }

  ScalarEvolution *SE = PSE.getSE();
  // Must be uniform, handled by vectorizeMemoryInstruction()
  if (SE->isLoopInvariant(SE->getSCEV(Gep), OrigLoop))
    return;

  // Handle all non loop invariant forms that are not affine, so that
  // when used as address it can be transformed into a gather load/store,
  // or when used as pointer arithmetic, it is just vectorized into
  // arithmetic instructions.
  auto *SAR = dyn_cast<SCEVAddRecExpr>(SE->getSCEV(Gep));
  if (!SAR || !SAR->isAffine()) {
    vectorizeArithmeticGEP(Gep, WidenMap);
    return;
  }

  // Create SCEV expander for Start- and StepValue
  const DataLayout &DL = Instr->getModule()->getDataLayout();
  SCEVExpander Expander(*SE, DL, "seriesgep");

  // Expand step and start value (the latter in preheader)
  const SCEV *StepRec = SAR->getStepRecurrence(*SE);
  // TODO: Make sure of the insert point!!!
  Value *StepValue = Expander.expandCodeFor(StepRec, StepRec->getType(),
                                            &*Builder.GetInsertPoint());

  // Try to find a smaller type for StepValue
  const SCEV *BETC = SE->getMaxBackedgeTakenCount(OrigLoop);
  if (auto * MaxIters = dyn_cast<SCEVConstant>(BETC)) {
    if (auto * CI = dyn_cast<ConstantInt>(StepValue)) {
      // RequiredBits = active_bits(max_iterations * step_value)
      APInt MaxItersV = MaxIters->getValue()->getValue();
      if (CI->isNegative())
        MaxItersV = MaxItersV.sextOrSelf(CI->getValue().getBitWidth());
      else
        MaxItersV = MaxItersV.zextOrSelf(CI->getValue().getBitWidth());

      APInt MaxVal = MaxItersV * CI->getValue();

      // Try to reduce this type from i64 to something smaller
      unsigned RequiredBits = MaxVal.getActiveBits();
      unsigned StepBits = StepValue->getType()->getIntegerBitWidth();
      while (RequiredBits <= StepBits && StepBits >= 32)
        StepBits = StepBits >> 1;

      // Truncate the step value
      Type *NewStepType = IntegerType::get(
          Instr->getParent()->getContext(), StepBits << 1);
      StepValue = Builder.CreateTrunc(StepValue, NewStepType);
    }
  }

  const SCEV *StartRec = SAR->getStart();
  Value *StartValue = nullptr;
  StartValue = Expander.expandCodeFor(StartRec, Gep->getType(),
                                      LoopVectorPreHeader->getTerminator());

  Value *Base = Gep->getPointerOperand();
  Value *Tmp2 = Builder.CreateBitCast(StartValue,
      Builder.getInt8PtrTy(Base->getType()->getPointerAddressSpace()));

  // We can zero extend the incoming value, because Induction is
  // the unsigned iteration counter.
  // TODO: Is this correct? (Preheader value, might not be defined?)
  Value *Tmp = InductionStartIdx;
  Tmp = Builder.CreateZExtOrTrunc(Tmp, StepValue->getType());
  Tmp = Builder.CreateMul(StepValue, Tmp);
  Tmp = Builder.CreateSub(ConstantInt::get(StepValue->getType(), 0), Tmp);
  Tmp = Builder.CreateGEP(Tmp2, Tmp);
  StartValue = Builder.CreateBitCast(Tmp, StartValue->getType());

  // Normalize to be in #elements, not bytes
  Type *ElemTy = Instr->getType()->getPointerElementType();
  Tmp = ConstantInt::get(StepValue->getType(), DL.getTypeAllocSize(ElemTy));
  StepValue = Builder.CreateSDiv(StepValue, Tmp);

  // Get the dynamic VL
  Value *NumEls = getElementCount(Instr->getType(), VF, Scalable);
  NumEls = Builder.CreateZExtOrTrunc(NumEls, StepValue->getType());

  // Create the series vector
  VectorParts &Entry = WidenMap.get(Instr);

  // Induction is always the widest induction type in the loop,
  // but if that is not enough for evaluating the step, zero extend is
  // fine because Induction is the iteration counter, always unsigned.
  Value *IterOffset = Builder.CreateZExtOrTrunc(Induction, StepValue->getType());
  IterOffset = Builder.CreateMul(IterOffset, StepValue);
  unsigned Part = 0;
  {
    // Tmp = part * stride * VL
    Value *UnrollOffset = ConstantInt::get(NumEls->getType(), Part);
    UnrollOffset = Builder.CreateMul(StepValue, UnrollOffset);
    UnrollOffset = Builder.CreateMul(NumEls, UnrollOffset);

    // Adjust offset for unrolled iteration
    Value *Offset = Builder.CreateAdd(IterOffset, UnrollOffset);
    Offset = Builder.CreateSeriesVector({VF,Scalable}, Offset, StepValue);

    // Address = getelementptr %scalarbase, seriesvector(0, step)
    Entry[Part] = Builder.CreateGEP(StartValue, Offset);
  }

  propagateMetadata(Entry, Instr);
}

// Vectorize GEP as arithmetic instructions.
//
// This is required when a given GEP is not used for a load/store operation,
// but rather to implement pointer arithmetic. In this case, the pointer may
// be a vector of pointers (e.g. resulting from a load).
//
// This function makes a ptrtoint->arith->inttoptr transformation.
//
//      extern char * reg_names[];
//      void foo(void) {
//        for (int i = 0; i < K; i++)
//          reg_names[i]--;
//      }
//
//      %1 = getelementptr inbounds [0 x i8*]* @reg_names, i64 0, i64 %0
//      %2 = bitcast i8** %1 to <n x 8 x i8*>*
//      %wide.load = load <n x 8 x i8*>* %2, align 8, !tbaa !1
//      %3 = ptrtoint <n x 8 x i8*> %wide.load to <n x 8 x i64>
//      %4 = add <n x 8 x i64> %3, seriesvector (i64 -1, i64 0)
//      %5 = inttoptr <n x 8 x i64> %4 to <n x 8 x i8*>
//      %6 = bitcast i8** %1 to <n x 8 x i8*>*
//      store <n x 8 x i8*> %5, <n x 8 x i8*>* %6, align 8, !tbaa !1
void InnerLoopVectorizer::vectorizeArithmeticGEP(Instruction *Instr,
                                                 ValueMap &WidenMap) {
  assert(isa<GetElementPtrInst>(Instr) && "Instr is not a GEP");
  GetElementPtrInst *GEP = static_cast<GetElementPtrInst *>(Instr);

  // Used types for inttoptr/ptrtoint transform
  Type *OrigPtrType = GEP->getType();
  const DataLayout &DL = GEP->getModule()->getDataLayout();
  Type *IntPtrType = DL.getIntPtrType(GEP->getType());

  // Constant and Variable elements are kept separate to allow IRBuilder
  // to fold the constant before widening it to a vector.
  VectorParts &Base = getVectorValue(GEP->getPointerOperand(), WidenMap);
  VectorParts &Res = WidenMap.get(Instr);

  unsigned Part = 0;
  {
    // Pointer To Int (pointer operand)
    Res[Part] = Builder.CreatePtrToInt(
        Base[Part], VectorType::get(IntPtrType, VF, Scalable));

    // Collect constants and split up the GEP expression into an arithmetic one.
    Value *Cst = ConstantInt::get(IntPtrType, 0, false);
    gep_type_iterator GTI = gep_type_begin(*GEP);
    for (unsigned I = 1, E = GEP->getNumOperands(); I != E; ++I, ++GTI) {
      // V is still scalar
      Value *V = GEP->getOperand(I);

      if (isa<SequentialType>(*GTI)) {
        // First transform index to pointer-type
        if (V->getType() != IntPtrType)
          V = Builder.CreateIntCast(V, IntPtrType, true, "idxprom");

        Value *TypeAllocSize = ConstantInt::get(
            V->getType(), DL.getTypeAllocSize(GTI.getIndexedType()), true);
        // Only widen non-constant offsets
        if (isa<Constant>(V))
          V = Builder.CreateMul(V, TypeAllocSize);
        else
          V = Builder.CreateMul(getVectorValue(V, WidenMap)[Part],
                                getVectorValue(TypeAllocSize, WidenMap)[Part]);
      } else {
        // Struct type, get field offset in bytes. Result is always a constant.
        assert(isa<StructType>(*GTI) && "Indexing a non-composite type?");
        assert(isa<ConstantInt>(V) && "Field offset must be constant");

        ConstantInt *CI = static_cast<ConstantInt *>(V);
        unsigned ByteOffset =
            DL.getStructLayout(static_cast<StructType *>(*GTI))
               ->getElementOffset(CI->getLimitedValue());
        V = ConstantInt::get(IntPtrType, ByteOffset, false);
      }

      if (isa<Constant>(V) && !V->getType()->isVectorTy())
        Cst = Builder.CreateAdd(Cst, V);
      else
        Res[Part] = Builder.CreateAdd(Res[Part], V);
    }

    // Add constant part and create final conversion to original type
    Res[Part] = Builder.CreateAdd(Res[Part], getVectorValue(Cst, WidenMap)[Part]);
    Res[Part] = Builder.CreateIntToPtr(
        Res[Part], VectorType::get(OrigPtrType, VF, Scalable));
  }
}

void
InnerLoopVectorizer::scalarizeInstructionWithSubloop(Instruction *Instr,
                                                     ValueMap &WidenMap,
                                                     bool IfPredicateStore) {
  assert(!IfPredicateStore &&
         "Can't handle scalarizing sub-loop with ifcvt store");
  // Holds vector parameters or scalars, in case of uniform vals.
  SmallVector<VectorParts, 4> Params;

  setDebugLocFromInst(Builder, Instr);

  // Find all of the vectorized parameters.
  for (unsigned op = 0, e = Instr->getNumOperands(); op != e; ++op) {
    Value *SrcOp = Instr->getOperand(op);

    // If we are accessing the old induction variable, use the new one.
    if (SrcOp == OldInduction) {
      Params.push_back(getVectorValue(SrcOp, WidenMap));
      continue;
    }

    // Try using previously calculated values.
    Instruction *SrcInst = dyn_cast<Instruction>(SrcOp);

    // If the src is an instruction that appeared earlier in the basic block
    // then it should already be vectorized.
    if (SrcInst && OrigLoop->contains(SrcInst)) {
      assert(WidenMap.has(SrcInst) && "Source operand is unavailable");
      // The parameter is a vector value from earlier.
      Params.push_back(WidenMap.get(SrcInst));
    } else {
      // The parameter is a scalar from outside the loop. Maybe even a constant.
      VectorParts Scalars;
      Scalars.append(1, SrcOp);
      Params.push_back(Scalars);
    }
  }

  assert(Params.size() == Instr->getNumOperands() &&
         "Invalid number of operands");

  // Does this instruction return a value ?
  bool IsVoidRetTy = Instr->getType()->isVoidTy();

  Value *UndefVec =
      IsVoidRetTy ? nullptr
                  : UndefValue::get(VectorType::get(Instr->getType(), VF,
                                                    isScalable() ? 0 : 1));

  Instruction *InsertPt = &*Builder.GetInsertPoint();
  BasicBlock *IfBlock = Builder.GetInsertBlock();

  VectorParts Cond;
  Loop *VectorLp = LI->getLoopFor(IfBlock);

  Type *IdxType = Legal->getWidestInductionType();
  VectorParts &VecResults = WidenMap.splat(Instr, UndefVec);

  BasicBlock *CurrentBlock = IfBlock;
  // For each unroll 'part':
  unsigned Part = 0;
  {
    // Generate a scalar sub-loop.
    BasicBlock *ScalarBlock =
        CurrentBlock->splitBasicBlock(InsertPt, "subloop");
    LoopVectorBody.push_back(ScalarBlock);
    VectorLp->addBasicBlockToLoop(ScalarBlock, *LI);
    Builder.SetInsertPoint(ScalarBlock);
    BasicBlock *ResumeBlock =
        ScalarBlock->splitBasicBlock(&ScalarBlock->front(), "subloop.resume");
    LoopVectorBody.push_back(ResumeBlock);
    VectorLp->addBasicBlockToLoop(ResumeBlock, *LI);
    // Remove newly created uncond br.
    ScalarBlock->getTerminator()->eraseFromParent();

    PHINode *ScalarIdx = Builder.CreatePHI(IdxType, 2);
    ScalarIdx->setName("scalar.idx");
    ScalarIdx->addIncoming(ConstantInt::get(IdxType, 0), CurrentBlock);

    // Create a new entry in the WidenMap and initialize it to Undef or Null.
    // The undef is wrapped in a phi since we need to insert into it on every
    // iteration of the subloop.
    PHINode *UndefPN = Builder.CreatePHI(UndefVec->getType(), 2);
    UndefPN->setName("loopvec");
    UndefPN->addIncoming(UndefVec, CurrentBlock);

    Instruction *ClonedInst = Instr->clone();
    if (!IsVoidRetTy)
      ClonedInst->setName(Instr->getName() + ".cloned");

    // For each operand in the original instruction:
    for (unsigned ParamIdx = 0; ParamIdx < Params.size(); ParamIdx++) {
      Value *Opnd = Params[ParamIdx][Part];
      Type *OpndVecType = dyn_cast<VectorType>(Opnd->getType());
      // We have a vector operand, so extract the element.
      if (OpndVecType)
        Opnd = Builder.CreateExtractElement(Opnd, ScalarIdx);
      // Replace the operand of the cloned instruction with the scalar.
      ClonedInst->setOperand(ParamIdx, Opnd);
    }

    Builder.Insert(ClonedInst);
    if (!IsVoidRetTy) {
      auto VecInsert =
          Builder.CreateInsertElement(UndefPN, ClonedInst, ScalarIdx);
      VecResults[Part] = VecInsert;
      UndefPN->addIncoming(VecInsert, ScalarBlock);
    }

    Value *NextScalIdx =
        Builder.CreateAdd(ScalarIdx, ConstantInt::get(IdxType, 1));
    ScalarIdx->addIncoming(NextScalIdx, ScalarBlock);
    Value *Cmp =
        Builder.CreateICmp(ICmpInst::ICMP_ULT, NextScalIdx,
                           getElementCount(IdxType, VF, Scalable, IdxType));

    Builder.CreateCondBr(Cmp, ScalarBlock, ResumeBlock);
    CurrentBlock = ResumeBlock;

    // Record the current dominator information for the vector body blocks.
    // TODO: If we need to support if-cvtd blocks then this will need to be
    // adapted.
    VecBodyDomEdges.push_back(DomEdge(VecBodyPostDom, ScalarBlock));
    VecBodyDomEdges.push_back(DomEdge(ScalarBlock, ResumeBlock));
    VecBodyPostDom = ResumeBlock;
  }
  Builder.SetInsertPoint(InsertPt);
}

void InnerLoopVectorizer::scalarizeInstruction(Instruction *Instr,
                                               ValueMap &WidenMap,
                                               bool IfPredicateStore) {
  assert(!Instr->getType()->isAggregateType() && "Can't handle vectors");
  if (isScalable()) {
    assert(!IfPredicateStore &&
           "Can't handle WA predicating store scalarization");
    scalarizeInstructionWithSubloop(Instr, WidenMap, IfPredicateStore);
    return;
  }

  // Holds vector parameters or scalars, in case of uniform vals.
  SmallVector<VectorParts, 4> Params;

  setDebugLocFromInst(Builder, Instr);

  // Find all of the vectorized parameters.
  for (unsigned op = 0, e = Instr->getNumOperands(); op != e; ++op) {
    Value *SrcOp = Instr->getOperand(op);

    // If we are accessing the old induction variable, use the new one.
    if (SrcOp == OldInduction) {
      Params.push_back(getVectorValue(SrcOp, WidenMap));
      continue;
    }

    // Try using previously calculated values.
    Instruction *SrcInst = dyn_cast<Instruction>(SrcOp);

    // If the src is an instruction that appeared earlier in the basic block,
    // then it should already be vectorized.
    if (SrcInst && OrigLoop->contains(SrcInst)) {
      assert(WidenMap.has(SrcInst) && "Source operand is unavailable");
      // The parameter is a vector value from earlier.
      Params.push_back(WidenMap.get(SrcInst));
    } else {
      // The parameter is a scalar from outside the loop. Maybe even a constant.
      VectorParts Scalars;
      Scalars.append(1, SrcOp);
      Params.push_back(Scalars);
    }
  }

  assert(Params.size() == Instr->getNumOperands() &&
         "Invalid number of operands");

  // Does this instruction return a value ?
  bool IsVoidRetTy = Instr->getType()->isVoidTy();

  Value *UndefVec = IsVoidRetTy ? nullptr :
    UndefValue::get(VectorType::get(Instr->getType(), VF));
  // Create a new entry in the WidenMap and initialize it to Undef or Null.
  VectorParts &VecResults = WidenMap.splat(Instr, UndefVec);

  VectorParts Cond;
  if (IfPredicateStore) {
    assert(Instr->getParent()->getSinglePredecessor() &&
           "Only support single predecessor blocks");
    Cond = createEdgeMask(Instr->getParent()->getSinglePredecessor(),
                          Instr->getParent(), WidenMap);
  }

  // For each vector unroll 'part':
  unsigned Part = 0;
  {
    // For each scalar that we create:
    for (unsigned Width = 0; Width < VF; ++Width) {

      // Start if-block.
      Value *Cmp = nullptr;
      if (IfPredicateStore) {
        Cmp = Builder.CreateExtractElement(Cond[Part], Builder.getInt32(Width));
        Cmp = Builder.CreateICmp(ICmpInst::ICMP_EQ, Cmp, ConstantInt::get(Cmp->getType(), 1));
      }

      Instruction *Cloned = Instr->clone();
      if (!IsVoidRetTy)
        Cloned->setName(Instr->getName() + ".cloned");
      // Replace the operands of the cloned instructions with extracted scalars.
      for (unsigned op = 0, e = Instr->getNumOperands(); op != e; ++op) {
        Value *Op = Params[op][Part];
        // Param is a vector. Need to extract the right lane.
        if (Op->getType()->isVectorTy())
          Op = Builder.CreateExtractElement(Op, Builder.getInt32(Width));
        Cloned->setOperand(op, Op);
      }

      // Place the cloned scalar in the new loop.
      Builder.Insert(Cloned);

      // If the original scalar returns a value we need to place it in a vector
      // so that future users will be able to use it.
      if (!IsVoidRetTy)
        VecResults[Part] = Builder.CreateInsertElement(VecResults[Part], Cloned,
                                                       Builder.getInt32(Width));
      // End if-block.
      if (IfPredicateStore)
        PredicatedStores.push_back(std::make_pair(cast<StoreInst>(Cloned),
                                                  Cmp));
    }
  }
}

std::pair<Instruction *, Instruction *>
InnerLoopVectorizer::addStrideCheck(Instruction *Loc) {
  Instruction *tnullptr = nullptr;
  if (!Legal->mustCheckStrides())
    return std::pair<Instruction *, Instruction *>(tnullptr, tnullptr);

  IRBuilder<> ChkBuilder(Loc);

  // Emit checks.
  Value *Check = nullptr;
  Instruction *FirstInst = nullptr;
  for (SmallPtrSet<Value *, 8>::iterator SI = Legal->strides_begin(),
                                         SE = Legal->strides_end();
       SI != SE; ++SI) {
    Value *Ptr = stripIntegerCast(*SI);
    Value *C = ChkBuilder.CreateICmpNE(Ptr, ConstantInt::get(Ptr->getType(), 1),
                                       "stride.chk");
    // Store the first instruction we create.
    FirstInst = getFirstInst(FirstInst, C, Loc);
    if (Check)
      Check = ChkBuilder.CreateOr(Check, C);
    else
      Check = C;
  }

  // We have to do this trickery because the IRBuilder might fold the check to a
  // constant expression in which case there is no Instruction anchored in a
  // the block.
  LLVMContext &Ctx = Loc->getContext();
  Instruction *TheCheck =
      BinaryOperator::CreateAnd(Check, ConstantInt::getTrue(Ctx));
  ChkBuilder.Insert(TheCheck, "stride.not.one");
  FirstInst = getFirstInst(FirstInst, TheCheck, Loc);

  return std::make_pair(FirstInst, TheCheck);
}

PHINode *InnerLoopVectorizer::createInductionVariable(Loop *L, Value *Start,
                                                      Value *End, Value *Step,
                                                      Instruction *DL) {
  BasicBlock *Header = L->getHeader();
  BasicBlock *Latch = L->getLoopLatch();
  // As we're just creating this loop, it's possible no latch exists
  // yet. If so, use the header as this will be a single block loop.
  if (!Latch)
    Latch = Header;

  IRBuilder<> Builder(&*Header->getFirstInsertionPt());
  setDebugLocFromInst(Builder, getDebugLocFromInstOrOperands(OldInduction));

  auto *PredTy = VectorType::get(Builder.getInt1Ty(), VF, Scalable);
  auto *AllActive = ConstantInt::getTrue(PredTy);

  auto *Induction = Builder.CreatePHI(Start->getType(), 2, "index");
  Predicate = Builder.CreatePHI(PredTy, 2, "predicate");

  Builder.SetInsertPoint(Latch->getTerminator());

  // Create i+1 and fill the PHINode.
  Value *Next = Builder.CreateAdd(Induction, Step, "index.next");
  Induction->addIncoming(Start, L->getLoopPreheader());
  Induction->addIncoming(Next, Latch);

  // Even though all lanes are active some code paths require a predicate.
  dyn_cast<PHINode>(Predicate)->addIncoming(AllActive, L->getLoopPreheader());
  dyn_cast<PHINode>(Predicate)->addIncoming(AllActive, Latch);

  // Create the compare.
  Value *ICmp = Builder.CreateICmpEQ(Next, End);
  Builder.CreateCondBr(ICmp, L->getExitBlock(), Header);

  // Now we have two terminators. Remove the old one from the block.
  Latch->getTerminator()->eraseFromParent();

  return Induction;
}

Value *InnerLoopVectorizer::getOrCreateTripCount(Loop *L) {
  if (TripCount)
    return TripCount;

  IRBuilder<> Builder(L->getLoopPreheader()->getTerminator());
  // Find the loop boundaries.
  ScalarEvolution *SE = PSE.getSE();
  const SCEV *BackedgeTakenCount = SE->getBackedgeTakenCount(OrigLoop);
  assert(BackedgeTakenCount != SE->getCouldNotCompute() && "Invalid loop count");

  Type *IdxTy = Legal->getWidestInductionType();
  
  // The exit count might have the type of i64 while the phi is i32. This can
  // happen if we have an induction variable that is sign extended before the
  // compare. The only way that we get a backedge taken count is that the
  // induction variable was signed and as such will not overflow. In such a case
  // truncation is legal.
  if (BackedgeTakenCount->getType()->getPrimitiveSizeInBits() >
      IdxTy->getPrimitiveSizeInBits())
    BackedgeTakenCount = SE->getTruncateOrNoop(BackedgeTakenCount, IdxTy);
  BackedgeTakenCount = SE->getNoopOrZeroExtend(BackedgeTakenCount, IdxTy);
  
  // Get the total trip count from the count by adding 1.
  const SCEV *ExitCount = SE->getAddExpr(
      BackedgeTakenCount, SE->getOne(BackedgeTakenCount->getType()));

  const DataLayout &DL = L->getHeader()->getModule()->getDataLayout();

  // Expand the trip count and place the new instructions in the preheader.
  // Notice that the pre-header does not change, only the loop body.
  SCEVExpander Exp(*SE, DL, "induction");

  // Count holds the overall loop count (N).
  TripCount = Exp.expandCodeFor(ExitCount, ExitCount->getType(),
                                L->getLoopPreheader()->getTerminator());

  if (TripCount->getType()->isPointerTy())
    TripCount =
      CastInst::CreatePointerCast(TripCount, IdxTy,
                                  "exitcount.ptrcnt.to.int",
                                  L->getLoopPreheader()->getTerminator());

  return TripCount;
}

Value *InnerLoopVectorizer::getOrCreateVectorTripCount(Loop *L) {
  if (VectorTripCount)
    return VectorTripCount;
  
  Value *TC = getOrCreateTripCount(L);
  IRBuilder<> Builder(L->getLoopPreheader()->getTerminator());
  
  // Now we need to generate the expression for N - (N % VF), which is
  // the part that the vectorized body will execute.
  // The loop step is equal to the vectorization factor (num of SIMD elements)
  // times the unroll factor (num of SIMD instructions).
  Value *R = Builder.CreateURem(TC, InductionStep, "n.mod.vf");
  VectorTripCount = Builder.CreateSub(TC, R, "n.vec");

  return VectorTripCount;
}

void InnerLoopVectorizer::emitMinimumIterationCountCheck(Loop *L,
                                                         BasicBlock *Bypass) {
  Value *Count = getOrCreateTripCount(L);
  BasicBlock *BB = L->getLoopPreheader();
  IRBuilder<> Builder(BB->getTerminator());

  // Generate code to check that the loop's trip count that we computed by
  // adding one to the backedge-taken count will not overflow.
  Value *CheckMinIters = Builder.CreateICmpULT(Count, InductionStep,
                                               "min.iters.check");
  
  BasicBlock *NewBB = BB->splitBasicBlock(BB->getTerminator(),
                                          "min.iters.checked");
  if (L->getParentLoop())
    L->getParentLoop()->addBasicBlockToLoop(NewBB, *LI);
  ReplaceInstWithInst(BB->getTerminator(),
                      BranchInst::Create(Bypass, NewBB, CheckMinIters));
  LoopBypassBlocks.push_back(BB);
}

void InnerLoopVectorizer::emitVectorLoopEnteredCheck(Loop *L,
                                                     BasicBlock *Bypass) {
  Value *TC = getOrCreateVectorTripCount(L);
  BasicBlock *BB = L->getLoopPreheader();
  IRBuilder<> Builder(BB->getTerminator());
  
  // Now, compare the new count to zero. If it is zero skip the vector loop and
  // jump to the scalar loop.
  Value *Cmp = Builder.CreateICmpEQ(TC, Constant::getNullValue(TC->getType()),
                                    "cmp.zero");

  // Generate code to check that the loop's trip count that we computed by
  // adding one to the backedge-taken count will not overflow.
  BasicBlock *NewBB = BB->splitBasicBlock(BB->getTerminator(),
                                          "vector.ph");
  if (L->getParentLoop())
    L->getParentLoop()->addBasicBlockToLoop(NewBB, *LI);
  ReplaceInstWithInst(BB->getTerminator(),
                      BranchInst::Create(Bypass, NewBB, Cmp));
  LoopBypassBlocks.push_back(BB);
}

void InnerLoopVectorizer::emitSCEVChecks(Loop *L, BasicBlock *Bypass) {
  BasicBlock *BB = L->getLoopPreheader();

  // Generate the code to check that the SCEV assumptions that we made.
  // We want the new basic block to start at the first instruction in a
  // sequence of instructions that form a check.
  SCEVExpander Exp(*PSE.getSE(), Bypass->getModule()->getDataLayout(), "scev.check");
  Value *SCEVCheck = Exp.expandCodeForPredicate(&PSE.getUnionPredicate(),
                                                BB->getTerminator());

  if (auto *C = dyn_cast<ConstantInt>(SCEVCheck))
    if (C->isZero())
      return;

  // Create a new block containing the stride check.
  BB->setName("vector.scevcheck");
  auto *NewBB = BB->splitBasicBlock(BB->getTerminator(), "vector.ph");
  if (L->getParentLoop())
    L->getParentLoop()->addBasicBlockToLoop(NewBB, *LI);
  ReplaceInstWithInst(BB->getTerminator(),
                      BranchInst::Create(Bypass, NewBB, SCEVCheck));
  LoopBypassBlocks.push_back(BB);
  AddedSafetyChecks = true;
}

// TODO: Are all these checks required if we have FF/NF/predication?
void InnerLoopVectorizer::emitMemRuntimeChecks(Loop *L,
                                               BasicBlock *Bypass) {
  BasicBlock *BB = L->getLoopPreheader();

  // Generate the code that checks in runtime if arrays overlap. We put the
  // checks into a separate block to make the more common case of few elements
  // faster.
  Instruction *FirstCheckInst;
  Instruction *MemRuntimeCheck;
  std::tie(FirstCheckInst, MemRuntimeCheck) =
      Legal->getLAI()->addRuntimeChecks(BB->getTerminator());
  if (!MemRuntimeCheck)
    return;

  // Create a new block containing the memory check.
  BB->setName("vector.memcheck");
  auto *NewBB = BB->splitBasicBlock(BB->getTerminator(), "vector.ph");
  if (L->getParentLoop())
    L->getParentLoop()->addBasicBlockToLoop(NewBB, *LI);
  ReplaceInstWithInst(BB->getTerminator(),
                      BranchInst::Create(Bypass, NewBB, MemRuntimeCheck));
  LoopBypassBlocks.push_back(BB);
  AddedSafetyChecks = true;
}

// TODO: Pointer chase pre-vec scalar loop?
// TODO: Different 'empty' loop structures based on loop type?
//       Plain EE, ptr chase, multi-backedge? Or just the
//       single creator func, but calling off to appropriate
//       helper funcs based on type?
void InnerLoopVectorizer::createEmptyLoopWithPredication() {
  /*
   In this function we generate a new loop. The new loop will contain
   the vectorized instructions while the old loop will continue to run the
   scalar remainder.

      v
     [ ] <-- Back-edge taken count overflow check.
    /   \
   |    [ ]  <-- vector loop bypass (may consist of multiple blocks).
   |    / \
   |   [ ] \  <-- vector pre header.
   |    | \ |
   | />[ ] ||
   | |_[ ] ||  <-- vector loop.
   |    |  ||
   |   [ ]</|  <-- middle-block.
   |    |   |
   |   [ ]  |  <-- vector tail.
   |    |   |
   | />[ ]  |  <-- scalable reduction loop.
   | |_[ ]  |
   |    |   |
   |   [ ]  |  <-- return point from scalable reduction loop.
   |    |   |
   |<---/   |
   |       [ ] <-- scalar preheader.
   |        |
   |       [ ]<\
   |       [ ]_|  <-- old scalar loop to handle remainder.
   |        |
   |<-------/
   v
  [ ] <-- exit block.
  ...
  */

  BasicBlock *OldBasicBlock = OrigLoop->getHeader();
  BasicBlock *BypassBlock = OrigLoop->getLoopPreheader();

  ScalarEvolution *SE = PSE.getSE();
  const SCEV *ExitCount = nullptr;
  auto &Exit = (*(Legal->getLoopExits()))[0];
  // If the latch condition is counted, we can do some special stuff
  if (Exit.ExitingBlock == OrigLoop->getLoopLatch() && Exit.Kind == EK_Counted)
    ExitCount = SE->getExitCount(OrigLoop, Exit.ExitingBlock);
  BasicBlock *ExitBlock = Exit.ExitBlock;

  assert(BypassBlock && "Invalid loop structure");
  assert(ExitBlock && "Must have an exit block");

  // Some loops have a single integer induction variable, while other loops
  // don't. One example is c++ iterators that often have multiple pointer
  // induction variables. In the code below we also support a case where we
  // don't have a single induction variable.
  // TODO: Move types to InnerLoopVectorizer?
  OldInduction = Legal->getInduction();
  Type *IdxTy = Legal->getWidestInductionType();
  Type *PredTy = Builder.getInt1Ty();
  Type *PredVecTy = VectorType::get(PredTy, VF, Scalable);

  // Find the loop boundaries.
  assert(ExitCount != SE->getCouldNotCompute() && "Invalid loop count");

  const SCEV *BackedgeTakeCount = nullptr;
  if (ExitCount && ExitCount != SE->getCouldNotCompute()) {
    // The exit count might have the type of i64 while the phi is i32. This can
    // happen if we have an induction variable that is sign extended before the
    // compare. The only way that we get a backedge taken count is that the
    // induction variable was signed and as such will not overflow. In such a case
    // truncation is legal.
    if (ExitCount->getType()->getPrimitiveSizeInBits() >
        IdxTy->getPrimitiveSizeInBits())
      ExitCount = SE->getTruncateOrNoop(ExitCount, IdxTy);

    BackedgeTakeCount = SE->getNoopOrZeroExtend(ExitCount, IdxTy);
    // Get the total trip count from the count by adding 1.
    ExitCount = SE->getAddExpr(BackedgeTakeCount,
                               SE->getConstant(BackedgeTakeCount->getType(), 1));
  }

  const DataLayout &DL = OldBasicBlock->getModule()->getDataLayout();

  // Extract the nsw/nuw flags from the induction variable expression if
  // possible; loops without an integer induction variable won't be able
  // to set these flags, but if the loop predicate is constructed from
  // constant values we will usually be able to optimize later anyway.
  if (OldInduction) {
    const SCEVNAryExpr *IVSCEV = dyn_cast<SCEVNAryExpr>(SE->getSCEV(OldInduction));
    IndVarNoWrap = IVSCEV && (IVSCEV->getNoWrapFlags() & SCEV::FlagNW);
  }

  // Split the single block loop into the two loop structure described above.
  LoopVectorPreHeader =
    BypassBlock->splitBasicBlock(BypassBlock->getTerminator(), "vector.ph");
  BasicBlock *VecBody =
    LoopVectorPreHeader->splitBasicBlock(LoopVectorPreHeader->getTerminator(),
                                         "vector.body.unpred");
  BasicBlock *VectorTail =
    VecBody->splitBasicBlock(VecBody->getTerminator(), "vector.tail");
  BasicBlock *ScalarPH =
    VectorTail->splitBasicBlock(VectorTail->getTerminator(), "scalar.ph");
  BasicBlock *ReductionLoopLocal =
    VectorTail->splitBasicBlock(VectorTail->getTerminator(),
                                      "reduction.loop");
  BasicBlock *ReductionLoopRetLocal =
    ReductionLoopLocal->splitBasicBlock(ReductionLoopLocal->getTerminator(),
                                        "reduction.loop.ret");

  // Create and register the new vector loop.
  SLVLoop = new Loop();
  Loop *ParentLoop = OrigLoop->getParentLoop();

  // Insert the new loop into the loop nest and register the new basic blocks
  // before calling any utilities such as SCEV that require valid LoopInfo.
  bool HasReductionLoop = Legal->hasScalarizedReduction() && isScalable();

  if (ParentLoop) {
    ParentLoop->addChildLoop(SLVLoop);
    ParentLoop->addBasicBlockToLoop(ScalarPH, *LI);
    ParentLoop->addBasicBlockToLoop(LoopVectorPreHeader, *LI);
    ParentLoop->addBasicBlockToLoop(VectorTail, *LI);

    if(!HasReductionLoop)
      ParentLoop->addBasicBlockToLoop(ReductionLoopLocal, *LI);

    ParentLoop->addBasicBlockToLoop(ReductionLoopRetLocal, *LI);
  } else {
    LI->addTopLevelLoop(SLVLoop);
  }
  SLVLoop->addBasicBlockToLoop(VecBody, *LI);

  // ***************************************************************************
  // Start of BypassBlock (NOTE: may contain multiple blocks)
  // ***************************************************************************

  // Expand the trip count and place the new instructions in the preheader.
  // Notice that the pre-header does not change, only the loop body.
  SCEVExpander Exp(*SE, DL, "induction");

  // We need to test whether the backedge-taken count is uint##_max. Adding one
  // to it will cause overflow and an incorrect loop trip count in the vector
  // body. In case of overflow we want to directly jump to the scalar remainder
  // loop.
  Instruction *CheckBCOverflow = nullptr;
  if (BackedgeTakeCount) {
    Value *BackedgeCount =
      Exp.expandCodeFor(BackedgeTakeCount, BackedgeTakeCount->getType(),
                        BypassBlock->getTerminator());
    if (BackedgeCount->getType()->isPointerTy())
      BackedgeCount = CastInst::CreatePointerCast(BackedgeCount, IdxTy,
                                                  "backedge.ptrcnt.to.int",
                                                  BypassBlock->getTerminator());
    CheckBCOverflow =
      CmpInst::Create(Instruction::ICmp, CmpInst::ICMP_EQ, BackedgeCount,
                      Constant::getAllOnesValue(BackedgeCount->getType()),
                      "backedge.overflow", BypassBlock->getTerminator());
  }

  // The loop index does not have to start at Zero. Find the original start
  // value from the induction PHI node. If we don't have an induction variable
  // then we know that it starts at zero.
  Builder.SetInsertPoint(BypassBlock->getTerminator());
  Value *StartIdx = ExtendedIdx = OldInduction ?
    Builder.CreateZExt(OldInduction->getIncomingValueForBlock(ScalarPH),
                       IdxTy) :
    ConstantInt::get(IdxTy, 0);

  // We need an instruction to anchor the first bypass check on.
  Instruction *BypassAnchor = BinaryOperator::CreateAdd(
    StartIdx, ConstantInt::get(IdxTy, 0), "bypass.anchor",
    BypassBlock->getTerminator());

  // Count holds the overall loop count (N).
  Value *Count =  nullptr;
  if (ExitCount) {
    Count = Exp.expandCodeFor(ExitCount, ExitCount->getType(),
                              BypassBlock->getTerminator());
  }

  LoopBypassBlocks.push_back(BypassBlock);


  // Update LoopInfo analysis to include the loop used by reduction variables.
  if (HasReductionLoop) {
    Loop *ReductionLp = new Loop();

    if (ParentLoop)
      ParentLoop->addChildLoop(ReductionLp);
    else
      LI->addTopLevelLoop(ReductionLp);

    ReductionLp->addBasicBlockToLoop(ReductionLoopLocal, *LI);
  }

  // This is the IR builder that we use to add all of the logic for bypassing
  // the new vector loop.
  IRBuilder<> BypassBuilder(BypassBlock->getTerminator());
  setDebugLocFromInst(BypassBuilder,
                      getDebugLocFromInstOrOperands(OldInduction));

  // The loop step is equal to the vectorization factor (num of SIMD elements)
  // times the unroll factor (num of SIMD instructions).
  if (isScalable()) {
    Value *TV = UndefValue::get(VectorType::get(IdxTy, VF, Scalable));
    InductionStep = BypassBuilder.CreateElementCount(IdxTy, TV);
  } else {
    InductionStep = ConstantInt::get(IdxTy, VF);
  }

  // We may need to extend the index in case there is a type mismatch.
  // We know that the count starts at zero and does not overflow.
  IdxEnd = nullptr;
  if (Count)
    if (Count->getType() != IdxTy) {
    // The exit count can be of pointer type. Convert it to the correct
    // integer type.
    if (ExitCount->getType()->isPointerTy())
      Count = BypassBuilder.CreatePointerCast(Count, IdxTy, "ptrcnt.to.int");
    else
      Count = BypassBuilder.CreateZExtOrTrunc(Count, IdxTy, "cnt.cast");

    // Add the start index to the loop count to get the new end index.
    IdxEnd = BypassBuilder.CreateAdd(Count, StartIdx, "end.idx");
  }

  Value *Cmp = nullptr;
  BasicBlock *LastBypassBlock = BypassBlock;

  // Generate code to check that the loops trip count that we computed by adding
  // one to the backedge-taken count will not overflow.
  if (CheckBCOverflow) {
    auto PastOverflowCheck = std::next(BasicBlock::iterator(BypassAnchor));
    BasicBlock *CheckBlock =
      LastBypassBlock->splitBasicBlock(PastOverflowCheck, "overflow.checked");
    DT->addNewBlock(CheckBlock, LastBypassBlock);
    if (ParentLoop)
      ParentLoop->addBasicBlockToLoop(CheckBlock, *LI);
    LoopBypassBlocks.push_back(CheckBlock);

    Instruction *OldTerm = LastBypassBlock->getTerminator();
    BranchInst::Create(ScalarPH, CheckBlock, CheckBCOverflow, OldTerm);
    OldTerm->eraseFromParent();

    Cmp = CheckBCOverflow;
    LastBypassBlock = CheckBlock;
  }

  // Generate the code to check that the strides we assumed to be one are really
  // one. We want the new basic block to start at the first instruction in a
  // sequence of instructions that form a check.
  Instruction *StrideCheck;
  Instruction *FirstCheckInst;
  std::tie(FirstCheckInst, StrideCheck) =
    addStrideCheck(LastBypassBlock->getTerminator());
  if (StrideCheck) {
    AddedSafetyChecks = true;
    // Create a new block containing the stride check.
    BasicBlock *CheckBlock =
      LastBypassBlock->splitBasicBlock(FirstCheckInst, "vector.stridecheck");
    DT->addNewBlock(CheckBlock, LastBypassBlock);
    if (ParentLoop)
      ParentLoop->addBasicBlockToLoop(CheckBlock, *LI);
    LoopBypassBlocks.push_back(CheckBlock);

    // Replace the branch into the memory check block with a conditional branch
    // for the "few elements case".
    Instruction *OldTerm = LastBypassBlock->getTerminator();
    if (Cmp)
      BranchInst::Create(ScalarPH, CheckBlock, Cmp, OldTerm);
    else
      BranchInst::Create(CheckBlock, OldTerm);
    OldTerm->eraseFromParent();

    Cmp = StrideCheck;
    LastBypassBlock = CheckBlock;
  }

  // Generate the code that checks in runtime if arrays overlap. We put the
  // checks into a separate block to make the more common case of few elements
  // faster.
  Instruction *MemRuntimeCheck;
  std::tie(FirstCheckInst, MemRuntimeCheck) =
    Legal->getLAI()->addRuntimeChecks(LastBypassBlock->getTerminator());
  if (MemRuntimeCheck) {
    AddedSafetyChecks = true;
    // Create a new block containing the memory check.
    BasicBlock *CheckBlock =
      LastBypassBlock->splitBasicBlock(FirstCheckInst, "vector.memcheck");
    DT->addNewBlock(CheckBlock, LastBypassBlock);
    if (ParentLoop)
      ParentLoop->addBasicBlockToLoop(CheckBlock, *LI);
    LoopBypassBlocks.push_back(CheckBlock);

    // Replace the branch into the memory check block with a conditional branch
    // for the "few elements case".
    Instruction *OldTerm = LastBypassBlock->getTerminator();
    if (Cmp)
      BranchInst::Create(ScalarPH, CheckBlock, Cmp, OldTerm);
    else
      BranchInst::Create(CheckBlock, OldTerm);
    OldTerm->eraseFromParent();

    Cmp = MemRuntimeCheck;
    LastBypassBlock = CheckBlock;
  }

  if (Cmp) {
    Instruction *OldTerm = LastBypassBlock->getTerminator();
    BranchInst::Create(ScalarPH, LoopVectorPreHeader, Cmp, OldTerm);
    OldTerm->eraseFromParent();
  }

  // BLARF.  Move this.  Needed for vectorizeGEPInstruction within an uncounted
  // loop pre-vec-loadcmp check.

  //TODO: Grabbed from below. (Start of Vecbody)
  // Use Builder to create the loop instructions (Phi, Br, Cmp) inside the loop.
  Builder.SetInsertPoint(VecBody->getFirstNonPHI());
  setDebugLocFromInst(Builder, getDebugLocFromInstOrOperands(OldInduction));
  // Generate the induction variable.
  Induction = Builder.CreatePHI(IdxTy, 2, "index");

  // These Phis have two incoming values, but right now we only add the
  // one coming from the preheader. The other (from the loop latch block)
  // will be added in 'vectorizeExits', after everything else has been
  // vectorized. This allows predicates from first-faulting loads or other
  // instructions to be added in before finalizing the phi.
  cast<PHINode>(Induction)->addIncoming(StartIdx, LoopVectorPreHeader);
  InductionStartIdx = StartIdx;
  // End of reshuffled vecbody
  // TODO: Use Builder insert guard RAII within if scope?

  // ***************************************************************************
  // End of BypassBlock (NOTE: may contain multiple blocks)
  // ***************************************************************************

  // ***************************************************************************
  // Start of vector.ph
  // ***************************************************************************

  // Set builder insertion points
  Builder.SetInsertPoint(LoopVectorPreHeader->getTerminator());
  setDebugLocFromInst(Builder, getDebugLocFromInstOrOperands(OldInduction));

  // Set to false, then check.
  HasSpeculativeLoads = false;

  // Collect all nodes (instructions) used in each of the conditions
  ConditionNodes.clear();
  for (auto &Exit : Legal->exits())
    ConditionNodes.insert(Exit.Nodes.begin(), Exit.Nodes.end());

  // If a sub-expression of a condition is reused in the loop
  // (after the early exit condition), then we need to create a
  // PHI node to get the value either from the preheader or from
  // the vector loop body. The same also holds for the vector tail.
  for (auto &Exit : Legal->exits()) {
    // For each sub expression of condition
    for (Value *V : Exit.Nodes) {
      // It only makes sense for instructions
      if (!isa<Instruction>(V))
        continue;

      // TODO: Better way of doing this?
      if (isa<LoadInst>(V) && !OrigLoop->isLoopInvariant(V))
        HasSpeculativeLoads = true;

      // Induction + Reduction vars are exempt
      if (auto *VP = dyn_cast<PHINode>(V)) {
        if (Legal->getInductionVars()->count(VP))
          continue;
        if (Legal->getReductionVars()->count(VP))
          continue;
      }

      // Induction var updates are also exempt
      bool IsIndUpdate = false;
      for (auto *User : V->users()) {
        if (auto *VP = dyn_cast<PHINode>(User)) {
          if (Legal->getInductionVars()->count(VP)) {
            IsIndUpdate = true;
            break;
          }
        }
      }

      if (IsIndUpdate)
        continue;

      // Test if subexpression is used in the loop.
      for (auto *User : V->users()) {
        if (ConditionNodes.count(User))
          continue;
        // There is always one branch that uses V
        if (isa<BranchInst>(User))
          continue;
        // If this user is in the loop, but not part of the
        // condition, we need to create the PHI for this Value.
        if (auto *UI = dyn_cast<Instruction>(User))
          if (OrigLoop->contains(UI))
            MakeTheseIntoPHIs.insert(V);
      }
    }
  }

  // If we have speculative loads, we need to determine whether a psuedo-fault
  // occcurred and potentially continue running in the scalar loop.
  if (HasSpeculativeLoads)
    TailSpeculativeLanes = PHINode::Create(PredVecTy, 2,
                                           "active.speculative.lanes",
                                           VectorTail->getFirstNonPHI());

  // Calculate early exit conditions
  SmallVector<Value*,5> Conds;
  Value *PTrue = ConstantInt::getTrue(PredVecTy);
  PreHeaderOutPred = insertEarlyBreaks(PHMap, StartIdx, Conds, PTrue);

  // Check if it needs to skip over body to vector tail
  Value *Done = Builder.CreateTest(TestInst::ALL_TRUE, PreHeaderOutPred,
                                   "fullvectorbody");
  Builder.CreateCondBr(Done, VecBody, VectorTail);

  // Cleanup the unconditional branch to vector body.
  Instruction *Term = LoopVectorPreHeader->getTerminator();
  Term->eraseFromParent();

  // ***************************************************************************
  // End of vector.ph
  // ***************************************************************************

  // ***************************************************************************
  // Start of vector.tail (part 1)
  // ***************************************************************************
  Builder.SetInsertPoint(VectorTail->getFirstNonPHI());

  // For each exit condition, make a PHI node that either gets the
  // calculated value from either the loop, or from the preheader
  for (auto *Cond : Conds) {
    // Create a PHI node and fill in preheader (other values we do in
    // vectorizeExits(), similar to Induction PHI).
    Value *VCond = PHMap.get(Cond)[0];
    auto *VCondPHI = Builder.CreatePHI(VCond->getType(), 2);
    VCondPHI->addIncoming(VCond, LoopVectorPreHeader);

    // Store vectorized (condition) PHIs in the vector-tail map
    VectorParts &VectorParts = VTailWMap.get(Cond);
    VectorParts[0] = VCondPHI;
  }

  // ***************************************************************************
  // End of vector.tail
  // ***************************************************************************

  // ***************************************************************************
  // Start of vector.body
  // ***************************************************************************
  Builder.SetInsertPoint(VecBody->getFirstNonPHI());
  setDebugLocFromInst(Builder, getDebugLocFromInstOrOperands(OldInduction));

  // We don't yet have a condition for the branch, since it may depend on
  // instructions within the loop (beyond just the trip count, if any).
  // As above, this will be added in 'vectorizeExits'.
  LatchBranch = Builder.CreateCondBr(UndefValue::get(Builder.getInt1Ty()),
                                     VecBody, VectorTail);
  // Now we have two terminators. Remove the old one from the block.
  VecBody->getTerminator()->eraseFromParent();

  // ***************************************************************************
  // End of vector.body
  // ***************************************************************************

  // ***************************************************************************
  // Start of reduction.loop.ret
  // ***************************************************************************

  // The vector body processes all elements so after the reduction we are done.
  Instruction *OldTerm = ReductionLoopRetLocal->getTerminator();
  // TODO: When HasSpeculativeLoads is false, we should only plant a branch to
  // the exitblock since we won't need the scalar loop to recover from a
  // pseudofault. However, until our DomTree is fixed up properly, we resort
  // to always planting this conditional branch and just hardcoding a 'true'
  // for the condition if we don't need the scalar loop.
  BranchInst::Create(ExitBlock, ScalarPH,
                     UndefValue::get(Builder.getInt1Ty()), OldTerm);
  OldTerm->eraseFromParent();

  // ***************************************************************************
  // End of reduction.loop.ret
  // ***************************************************************************

  // Get ready to start creating new instructions into the vectorized body.
  Builder.SetInsertPoint(&*VecBody->getFirstInsertionPt());

  // Save the state.
  LoopScalarPreHeader = ScalarPH;
  LoopVectorTail = VectorTail;
  LoopExitBlock = ExitBlock;
  LoopVectorBody.push_back(VecBody);
  VecBodyPostDom = VecBody;
  LoopScalarBody = OldBasicBlock;
  ReductionLoop = ReductionLoopLocal;
  ReductionLoopRet = ReductionLoopRetLocal;

  LoopVectorizeHints Hints(SLVLoop, true);
  // TODO: Make sure normal vectorizer doesn't nuke us by setting this for unrolled?
  Hints.setAlreadyVectorized();

  // Predicate for vector body starts out with a PTRUE
  Predicate = ConstantInt::getTrue(PredVecTy);

  // Set insertion point for unpredicated vector body
  Builder.SetInsertPoint(&*VecBody->getFirstInsertionPt());
}

///\brief Perform cse of induction variable instructions.
void InnerLoopVectorizer::CSE(SmallVector<BasicBlock *, 4> &BBs,
                              SmallSet<BasicBlock *, 2> &PredBlocks) {
  // Perform simple cse.
  SmallDenseMap<Instruction *, Instruction *, 4, CSEDenseMapInfo> CSEMap;
  for (unsigned i = 0, e = BBs.size(); i != e; ++i) {
    BasicBlock *BB = BBs[i];
    for (BasicBlock::iterator I = BB->begin(), E = BB->end(); I != E;) {
      Instruction *In = &*I++;

      if (!CSEDenseMapInfo::canHandle(In))
        continue;

      // Check if we can replace this instruction with any of the
      // visited instructions.
      if (Instruction *V = CSEMap.lookup(In)) {
        In->replaceAllUsesWith(V);
        In->eraseFromParent();
        continue;
      }
      // Ignore instructions in conditional blocks. We create "if (pred) a[i] =
      // ...;" blocks for predicated stores. Every second block is a predicated
      // block.
      if (PredBlocks.count(BBs[i]))
        continue;

      CSEMap[In] = In;
    }
  }
}


void InnerLoopVectorizer::truncateToMinimalBitwidths(ValueMap &WidenMap) {
  // For every instruction `I` in MinBWs, truncate the operands, create a
  // truncated version of `I` and reextend its result. InstCombine runs
  // later and will remove any ext/trunc pairs.
  //
  for (auto &KV : MinBWs) {
    VectorParts &Parts = WidenMap.get(KV.first);
    for (Value *&I : Parts) {
      if (I->use_empty())
        continue;

      // Not every value in the widenmap is an instruction
      if (!isa<Instruction>(I))
        continue;

      auto *OriginalTy = dyn_cast<VectorType>(I->getType());
      Type *ScalarTruncatedTy = IntegerType::get(OriginalTy->getContext(),
                                                 KV.second);
      Type *TruncatedTy = VectorType::get(ScalarTruncatedTy,
                                          OriginalTy->getElementCount());
      if (TruncatedTy == OriginalTy)
        continue;

      IRBuilder<> B(cast<Instruction>(I));
      auto ShrinkOperand = [&](Value *V) -> Value* {
        if (auto *ZI = dyn_cast<ZExtInst>(V))
          if (ZI->getSrcTy() == TruncatedTy)
            return ZI->getOperand(0);
        return B.CreateZExtOrTrunc(V, TruncatedTy);
      };

      // The actual instruction modification depends on the instruction type,
      // unfortunately.
      Value *NewI = nullptr;
      if (BinaryOperator *BO = dyn_cast<BinaryOperator>(I)) {
        NewI = B.CreateBinOp(BO->getOpcode(),
                             ShrinkOperand(BO->getOperand(0)),
                             ShrinkOperand(BO->getOperand(1)));
        cast<BinaryOperator>(NewI)->copyIRFlags(I);
      } else if (ICmpInst *CI = dyn_cast<ICmpInst>(I)) {
        NewI = B.CreateICmp(CI->getPredicate(),
                            ShrinkOperand(CI->getOperand(0)),
                            ShrinkOperand(CI->getOperand(1)));
      } else if (SelectInst *SI = dyn_cast<SelectInst>(I)) {
        NewI = B.CreateSelect(SI->getCondition(),
                              ShrinkOperand(SI->getTrueValue()),
                              ShrinkOperand(SI->getFalseValue()));
      } else if (CastInst *CI = dyn_cast<CastInst>(I)) {
        switch (CI->getOpcode()) {
        default: llvm_unreachable("Unhandled cast!");
        case Instruction::Trunc:
          NewI = ShrinkOperand(CI->getOperand(0));
          break;
        case Instruction::SExt:
          NewI = B.CreateSExtOrTrunc(CI->getOperand(0),
                                     smallestIntegerVectorType(OriginalTy,
                                                               TruncatedTy));
          break;
        case Instruction::ZExt:
          NewI = B.CreateZExtOrTrunc(CI->getOperand(0),
                                     smallestIntegerVectorType(OriginalTy,
                                                               TruncatedTy));
          break;
        }
      } else if (ShuffleVectorInst *SI = dyn_cast<ShuffleVectorInst>(I)) {
        auto VTy0 = cast<VectorType>(SI->getOperand(0)->getType());
        auto Elements0 = VTy0->getElementCount();
        auto *O0 =
          B.CreateZExtOrTrunc(SI->getOperand(0),
                              VectorType::get(ScalarTruncatedTy, Elements0));
        auto VTy1 = cast<VectorType>(SI->getOperand(1)->getType());
        auto Elements1 = VTy1->getElementCount();
        auto *O1 =
          B.CreateZExtOrTrunc(SI->getOperand(1),
                              VectorType::get(ScalarTruncatedTy, Elements1));

        NewI = B.CreateShuffleVector(O0, O1, SI->getMask());
      } else if (isa<LoadInst>(I) || isa<CallInst>(I)) {
        // Don't do anything with the operands, just extend the result.
        continue;
      } else {
        llvm_unreachable("Unhandled instruction type!");
      }

      // Lastly, extend the result.
      NewI->takeName(cast<Instruction>(I));
      Value *Res = B.CreateZExtOrTrunc(NewI, OriginalTy);
      I->replaceAllUsesWith(Res);
      cast<Instruction>(I)->eraseFromParent();
      I = Res;
    }
  }

  // We'll have created a bunch of ZExts that are now parentless. Clean up.
  for (auto &KV : MinBWs) {
    VectorParts &Parts = WidenMap.get(KV.first);
    for (Value *&I : Parts) {
      ZExtInst *Inst = dyn_cast<ZExtInst>(I);
      if (Inst && Inst->use_empty()) {
        Value *NewI = Inst->getOperand(0);
        Inst->eraseFromParent();
        I = NewI;
      }
    }
  }
}


PHINode *InnerLoopVectorizer::createTailPhiFromPhi(PHINode *PN,
                                                   const Twine &Name) {
  // Get incoming values from PH and Vector Body
  BasicBlock *VecBody = LoopVectorBody.back();
  Value *ValPH = PN->getIncomingValueForBlock(LoopVectorPreHeader);
  Value *ValVB = PN->getIncomingValueForBlock(VecBody);

  // Create Tail PHI
  return createTailPhiFromValues(ValPH, ValVB, Name);
}

PHINode *InnerLoopVectorizer::createTailPhiFromValues(
                        Value *ValPH, Value *ValVB, const Twine &Name) {
  BasicBlock *VecBody = LoopVectorBody.back();

  // Store the Insertion Point
  auto IP = Builder.saveIP();
  Builder.SetInsertPoint(LoopVectorTail->getFirstNonPHI());

  // Create the new PHI in vector tail
  auto *Res = Builder.CreatePHI(ValPH->getType(), 2, Name);
  Res->addIncoming(ValPH, LoopVectorPreHeader);
  Res->addIncoming(ValVB, VecBody);

  // Restore Insertion Point
  Builder.restoreIP(IP);

  return Res;
}

// Returns whether V is an Induction PHI or an Induction PHI update value.
bool InnerLoopVectorizer::isIndvarPHIOrUpdate(Value *V,
                               InductionDescriptor &II, bool &IsUpdate) {
  if (!isa<Instruction>(V))
    return false;

  if (auto *PHI = dyn_cast<PHINode>(V)) {
    IsUpdate = false;
    II = Legal->getInductionVars()->lookup(PHI);
    return II.getKind() != InductionDescriptor::IK_NoInduction;
  }

  // Check if this is an Indvar update by looking if any of its users
  // is an induction PHI and the result comes from this loop.
  auto *VI = cast<Instruction>(V);
  for (Value *User : VI->users()) {
    auto *PHI = dyn_cast<PHINode>(User);
    if (!PHI || !OrigLoop->contains(PHI))
      continue;

    II = Legal->getInductionVars()->lookup(PHI);
    if (II.getKind() != InductionDescriptor::IK_NoInduction) {
      IsUpdate = true;
      return true;
    }
  }

  return false;
}

// Returns whether all values are the same and are either an Induction PHI
// or an Induction PHI update value.
bool InnerLoopVectorizer::allIndvarPHIsOrAllUpdates(Escapee *E,
                                    InductionDescriptor &II, bool &IsUpdate) {
  Value *PrevVal = nullptr;
  for (auto *V : E->getValues()) {
    if (PrevVal != nullptr && PrevVal != V)
      return false;

    if (!isIndvarPHIOrUpdate(V, II, IsUpdate))
      return false;

    PrevVal = V;
  }

  return true;
}

// TODO: We previously bailed out here if we weren't an uncounted
// loop; however, twolf had a loop which should be vectorizeable
// with the regular vectorizer, only the induction variable was
// stored outside the loop. It should be possible to tell that
// the indvar must be the max value and store that. For now,
// though, we assume that any loops being vectorized by the slv
// have something interesting in them and therefore require a tail.
void InnerLoopVectorizer::insertVectorTail(LoopBlocksDFS &DFS) {
  // Create a PHI for the final predicate
  auto *Pg = createTailPhiFromValues(PreHeaderOutPred, VecBodyOutPred,
                                     "vtail.pg");

  // Create a PHI for the Induction variable (note that other induction
  // variables use the scalar induction var to create a seriesvector)
  Induction = createTailPhiFromPhi(cast<PHINode>(Induction), "vtail.ind");

  // Create PHIs for each induction escapee's 'last' value from the
  // vector body. For induction variables, it can be 'undef' from vector
  // preheader, since we're guaranteed at least one iteration will be
  // executed, this is only for case that this iteration contains
  // no active lanes. For reductions, the value has been created
  // above with a 'select' with its identity value.
  for (auto E : Legal->getEF()->getEscapees()) {
    VectorParts &Parts = VTailWMap.get(E.first);

    if (E.second->isReduction()) {
      Value *LastVal = E.second->getValue(E.second->getNumValues()-1);

      // Get the PHI node that describes this reduction,
      // could be obtained by finding the PHI that uses LastVal
      PHINode *RdxPhi = nullptr;
      PHINode *PHLastVal = dyn_cast<PHINode>(LastVal);

      // The last value can already be the reduction PHI, otherwise
      // search the users
      if (PHLastVal && Legal->getReductionVars()->count(PHLastVal))
        RdxPhi = PHLastVal;
      else {
        for (auto *U : LastVal->users()) {
          auto *RdxPhi2 = dyn_cast<PHINode>(U);
          if (!RdxPhi2 || !Legal->getReductionVars()->count(RdxPhi2))
            continue;
          RdxPhi = RdxPhi2;
        }
      }

      assert (RdxPhi && "Escapee not a valid Reduction Escapee");

      // From the (vectorised) PHI, get the Incoming edge from PreHeader
      PHINode *VRdxPhi = cast<PHINode>(getVectorValue(RdxPhi, BodyWMap)[0]);
      Value *ValPH = VRdxPhi->getIncomingValueForBlock(LoopVectorPreHeader);

      // The Last Value will be the one from the sorted list
      Value *VLastVal = getVectorValue(LastVal, BodyWMap)[0];

      // Create a PHI node in the vector tail
      Value *VPHi = createTailPhiFromValues(ValPH, VLastVal, "rdx.vtail");
      VTailWMap.get(RdxPhi)[0] = Parts[0] = VPHi;

      continue;
    }

    // Inductions need to start with the 'last' value from previous
    // full iteration.
    Value *LastVal = E.second->getValue(E.second->getNumValues()-1);

    // If LastVal is part of the condition, we can reuse it in
    // this iteration.
    if (ConditionNodes.count(LastVal)) {
      VectorParts &Parts2 = VTailWMap.get(LastVal);
      Value *A = getVectorValue(LastVal, PHMap)[0];
      Value *B = getVectorValue(LastVal, NextBodyWMap)[0];
      Parts2[0] = createTailPhiFromValues(A, B, "reuse");
    }

    LastVal = getVectorValue(LastVal, BodyWMap)[0];
    Parts[0] = UndefValue::get(LastVal->getType());
  }

  // Save IP
  auto IP = Builder.saveIP();
  Builder.SetInsertPoint(LoopVectorTail->getFirstNonPHI());

  // Find predicates for reductions and indvar extraction
  GreenLanes = getExclusivePartition(Pg);
  YellowLanes = getInclusivePartition(Pg);

  // We start with Yellow Lanes...
  Predicate = YellowLanes;


  // TODO: I think we want to merge this with the extraction below, but not all
  // indvars are escapees -- can we just iterate over all and use additional
  // logic for escapees?
  // TODO: Move to scalar preheader?
  Value *FFIncrVal = Builder.CreateCntVPop(GreenLanes, "speculative.increment");
  // TODO: ZExtOrTrunc when we use an unsigned indvar?
  FFIncrVal = Builder.CreateSExtOrTrunc(FFIncrVal, Induction->getType());
  Value *FFInductionVal = Builder.CreateAdd(Induction, FFIncrVal,
                                            "speculative.indval");

  // Provide the correct primary indvar value to the scalar loop in case we had
  // a pseudo-fault we need to recover from.
  LoopVectorizationLegality::InductionList::iterator I, E;
  // TODO: Convenience methods...
  //  for (auto &IndVar : Legal->getInductionVars())
  LoopVectorizationLegality::InductionList * List = Legal->getInductionVars();
  for (I = List->begin(), E = List->end(); I != E; ++I) {
    PHINode *OrigPhi = I->first;
    InductionDescriptor II = I->second;

    PHINode *ResumeVal = PHINode::Create(OrigPhi->getType(), 3,
                                         "speculative.resume.val",
                                         LoopScalarPreHeader->getFirstNonPHI());

    Value *EndVal;
    // TODO: Share with bcresumeval logic from createEmptyLoopWithPredication?
    // Replace, maybe, since we don't form this with known exit iterations.
    if (OrigPhi == OldInduction) {
      EndVal = FFInductionVal;
    } else {
      EndVal = Builder.CreateSExtOrTrunc(FFInductionVal,
                                         II.getStep()->getType(),
                                         "speculative.cast.endval");
      const DataLayout &DL = OrigPhi->getModule()->getDataLayout();
      EndVal = II.transform(Builder, EndVal, PSE.getSE(), DL);
      EndVal->setName("speculative.ind.end");
    }

    ResumeVal->addIncoming(EndVal, ReductionLoopRet);

    for (auto *BB : LoopBypassBlocks)
      for (auto *Succ : successors(BB))
        if (Succ == LoopScalarPreHeader)
          ResumeVal->addIncoming(II.getStartValue(), BB);

    auto BIdx = OrigPhi->getBasicBlockIndex(LoopScalarPreHeader);
    OrigPhi->setIncomingValue(BIdx, ResumeVal);
  }


  // TODO: How to block vectorization of things which shouldn't be in the tail?
  // Comparing map pointers is ugly; consider a single map pointer but switching
  // it at various points, and using a phase variable to determine how to handle
  // things?
  // Generate the vector tail instructions
  PhiVector Dummy;
  MaskCache.clear();
  for (LoopBlocksDFS::RPOIterator bb = DFS.beginRPO(),
       be = DFS.endRPO(); bb != be; ++bb)
    vectorizeBlockInLoop(*bb, &Dummy, VTailWMap);
  MaskCache.clear();

  Value *GrnCount = Builder.CreateCntVPop(GreenLanes, "grn.cnt");

  for (auto E : Legal->getEF()->getEscapees()) {
    // Reductions are handled separately
    if (E.second->isReduction())
      continue;

    auto Phi = dyn_cast<PHINode>(E.first);

    // Either extract an element from the vector value itself,
    // or optimise the extraction of purely induction vars
    // by calculating it as:
    //  II.transform(#scalar_induction + #active_grn_lanes)
    Value *Res;
    bool IsUpdate = false;
    InductionDescriptor II;
    if (allIndvarPHIsOrAllUpdates(E.second, II, IsUpdate)) {
      Type *StartTy = II.getStartValue()->getType();
      Value *One = ConstantInt::get(GrnCount->getType(), 1);

      // Number of active lanes (possibly +1 if its an update)
      Value *EltCnt = IsUpdate ? Builder.CreateAdd(GrnCount, One) : GrnCount;
      EltCnt = Builder.CreateZExtOrTrunc(EltCnt, StartTy);
      Value *Ind = (II.getKind() == InductionDescriptor::IK_IntInduction) ?
                Builder.CreateZExtOrTrunc(Induction, StartTy) : Induction;

      // Add scalar induction var + handled lanes
      Res = Builder.CreateAdd(Ind, EltCnt);

      const DataLayout &DL = Phi->getModule()->getDataLayout();
      // Transform into induction variable
      Res = II.transform(Builder, Res, PSE.getSE(), DL);

      // Possibly trunc
      if (Phi->getType()->isIntegerTy())
        Res = Builder.CreateZExtOrTrunc(Res, Phi->getType());
    } else {
      Value *VPhi = getVectorValue(Phi, VTailWMap)[0];
      Res = Builder.CreateExtractElement(VPhi, GrnCount);
    }

    Phi->addIncoming(Res, ReductionLoopRet);
  }

  //////////////////////////////////////////////////////////////////////////////
  //                      Speculative Recovery Branch                         //
  //////////////////////////////////////////////////////////////////////////////
  //
  // There are three possibilities for loop state in the vector tail:
  //
  // 1. All work completed in the vector body
  //
  // 2. Some work remaining, but we have reached a valid exit condition
  //
  // 3. Some work remaining, but a speculative load faulted before an
  //    exit condition was reached.
  //
  // For option 1, Pg will be all false, and we can just test for that when
  // determining whether we should skip the scalar loop.
  //
  // Options 2 and 3 require a bit more work. We have a phi which provides
  // us with the active speculative lanes from either the preheader or the
  // body, and we have the partitioned general predicate Pg for the tail.
  //
  // If we negate Pg, the first active lane is the one which exited. 'And'ing
  // that with the active speculative lanes tells us whether or not the exiting
  // lane was active or if the speculative load faulted before we reached any
  // valid exit condition. If all lanes are false there was no overlap, so
  // recovery via the scalar loop is required.
  //
  //
  // We expect hardware implementations to provide best-effort speculative loads
  // so any fault should be a real fault instead of a pseudo fault, and if an
  // exit condition was not reached then the program *should* fault at that
  // address. If the hardware implementation doesn't implement all boundary
  // cases, then it can just recover slowly via the scalar loop.
  Value *FaultCond = nullptr;
  if (HasSpeculativeLoads) {
    Builder.SetInsertPoint(LoopVectorTail->getTerminator());
    Value *InactiveLanes = Builder.CreateNot(Pg, "inactive.lanes");
    Value *OverlappedLanes = Builder.CreateAnd(InactiveLanes,
                                               TailSpeculativeLanes,
                                               "speculative.overlapped");
    Value *CondBeforeFault = Builder.CreateTest(TestInst::ANY_TRUE,
                                                OverlappedLanes,
                                                "cond.before.fault");
    Value *NoActive = Builder.CreateTest(TestInst::ALL_FALSE, Pg,
                                         "no.active.lanes");
    FaultCond = Builder.CreateOr(CondBeforeFault, NoActive,
                                 "skip.scalar.cond");
  } else
    // TODO: Remove branch modifications for non-speculative case once
    // the DomTree is sorted out.
    FaultCond = ConstantInt::getTrue(Builder.getInt1Ty());

  BranchInst *FallbackBr = cast<BranchInst>(ReductionLoopRet->getTerminator());
  FallbackBr->setCondition(FaultCond);

  // Restore Insertion point
  Builder.restoreIP(IP);
}


void InnerLoopVectorizer::vectorizeLoop() {
  // Only print 'function-name (loop-bb-name)'
  DEBUG(dbgs() << "SLV: Transforming " <<
        OrigLoop->getHeader()->getParent()->getName() <<
        "\t(" << OrigLoop->getHeader()->getName() << ")" << "\n");

  //===------------------------------------------------===//
  //
  // Notice: any optimization or new instruction that go
  // into the code below should be also be implemented in
  // the cost-model.
  //
  //===------------------------------------------------===//
  Constant *Zero = Builder.getInt32(0);

  // In order to support reduction variables we need to be able to vectorize
  // Phi nodes. Phi nodes have cycles, so we need to vectorize them in two
  // stages. First, we create a new vector PHI node with no incoming edges.
  // We use this value when we vectorize all of the instructions that use the
  // PHI. Next, after all of the instructions in the block are complete we
  // add the new incoming edges to the PHI. At this point all of the
  // instructions in the basic block are vectorized, so we can use them to
  // construct the PHI.
  PhiVector RdxPHIsToFix;
  PhiVector Dummy;

  // Scan the loop in a topological order to ensure that defs are vectorized
  // before users.
  LoopBlocksDFS DFS(OrigLoop);
  DFS.perform(LI);

  // Create PHIs for each condition subexpression that needs to become a PHI
  auto IP = Builder.saveIP();
  for (auto *V : MakeTheseIntoPHIs) {
    // Set insert point to preheader, if the value is constant,
    // it should be expanded in the preheader.
    Builder.SetInsertPoint(LoopVectorPreHeader->getTerminator());
    Value *PHValue = PHMap.get(V)[0];

    // Create two PHIs, one in body...
    Builder.SetInsertPoint(LoopVectorBody.front()->getFirstNonPHI());
    PHINode *BodyPhi = Builder.CreatePHI(PHValue->getType(), 2);
    BodyPhi->addIncoming(PHValue, LoopVectorPreHeader);
    BodyWMap.get(V)[0] = BodyPhi;

    // ... and one in vtail
    Builder.SetInsertPoint(LoopVectorTail->getFirstNonPHI());
    PHINode *TailPhi = Builder.CreatePHI(PHValue->getType(), 2);
    TailPhi->addIncoming(PHValue, LoopVectorPreHeader);
    VTailWMap.get(V)[0] = TailPhi;
  }
  Builder.restoreIP(IP);

  // Vectorize all of the blocks in the original loop.
  Builder.SetInsertPoint(&*(LoopVectorBody[0]->getFirstInsertionPt()));
  for (LoopBlocksDFS::RPOIterator bb = DFS.beginRPO(),
       be = DFS.endRPO(); bb != be; ++bb)
    vectorizeBlockInLoop(*bb, &RdxPHIsToFix, BodyWMap);
  MaskCache.clear();

  // vectorize exit by creating the next predicate,
  // next induction value and a test for all conditions.
  vectorizeExits();

  // Patch up PHIs from vector body
  BasicBlock *LastBB = LoopVectorBody.back();
  for (auto *V : MakeTheseIntoPHIs) {
    Value *PHValue = NextBodyWMap.get(V)[0];

    // Create two PHIs, one in body, one in vtail
    auto *BodyPhi = dyn_cast<PHINode>(BodyWMap.get(V)[0]);
    BodyPhi->addIncoming(PHValue, LastBB);

    auto *TailPhi = dyn_cast<PHINode>(VTailWMap.get(V)[0]);
    TailPhi->addIncoming(PHValue, LastBB);
  }

  // Find the reduction identity variable. Zero for addition, or, xor,
  // one for multiplication, -1 for And.
  for (auto &Reduction : *Legal->getReductionVars()) {
    auto IP = Builder.saveIP();
    Builder.SetInsertPoint(LoopVectorPreHeader->getTerminator());

    PHINode *PN = Reduction.first;
    RecurrenceDescriptor RdxDesc = Reduction.second;
    RecurrenceDescriptor::RecurrenceKind RK = RdxDesc.getRecurrenceKind();
    TrackingVH<Value> ReductionStartValue = RdxDesc.getRecurrenceStartValue();

    // Reductions do not have to start at zero. They can start with
    // any loop invariant values.
    VectorParts &VecRdxPhi = BodyWMap.get(PN);
    BasicBlock *Latch = OrigLoop->getLoopLatch();
    Value *LoopVal = PN->getIncomingValueForBlock(Latch);
    VectorParts &Val = getVectorValue(LoopVal, BodyWMap);

    // Create the VectorStart value
    Value *Identity, *VectorStart;
    if (RK == RecurrenceDescriptor::RK_IntegerMinMax ||
        RK == RecurrenceDescriptor::RK_FloatMinMax) {
      // MinMax reduction have the start value as their identify.
      if (VF == 1) {
        VectorStart = Identity = ReductionStartValue;
      } else {
        VectorStart = Identity =
            Builder.CreateVectorSplat({VF, Scalable},
                                      RdxDesc.getRecurrenceStartValue(),
                                      "minmax.ident");
      }
    } else {
      // Handle other reduction kinds:
      Constant *Iden = RecurrenceDescriptor::getRecurrenceIdentity(
          RK, VecRdxPhi[0]->getType()->getScalarType());
      if (VF == 1) {
        Identity = Iden;
        // This vector is the Identity vector where the first element is the
        // incoming scalar reduction.
        VectorStart = ReductionStartValue;
      } else {
        Identity = ConstantVector::getSplat({VF, Scalable}, Iden);

        // This vector is the Identity vector where the first element is the
        // incoming scalar reduction.
        VectorStart =
            Builder.CreateInsertElement(Identity, ReductionStartValue, Zero);
      }
    }

    // Fix the vector-loop phi.

    // Only add the reduction start value to the first unroll part.
    cast<PHINode>(VecRdxPhi[0])->addIncoming(VectorStart,
                                             LoopVectorPreHeader);
    cast<PHINode>(VecRdxPhi[0])->addIncoming(Val[0],
                                             LoopVectorBody.back());

    Builder.restoreIP(IP);
  }

  // Insert the vector tail and all PHI node edges from preheader/vector body
  insertVectorTail(DFS);

  // Insert truncates and extends for any truncated instructions as hints to
  // InstCombine.
  if (VF > 1) {
  //FIXME: Enabling this gives a segv with bzip2.
  //truncateToMinimalBitwidths(PHMap);
  //truncateToMinimalBitwidths(BodyWMap);
  //truncateToMinimalBitwidths(NextBodyWMap);
  //truncateToMinimalBitwidths(VTailWMap);
  }
  // At this point every instruction in the original loop is widened to
  // a vector form. We are almost done. Now, we need to fix the PHI nodes
  // that we vectorized. The PHI nodes are currently empty because we did
  // not want to introduce cycles. Notice that the remaining PHI nodes
  // that we need to fix are reduction variables.

  // Create the 'reduced' values for each of the induction vars.
  // The reduced values are the vector values that we scalarize and combine
  // after the loop is finished.
  for (auto *RdxPhi : RdxPHIsToFix) {
    assert(RdxPhi && "Unable to recover vectorized PHI");

    // Find the reduction variable descriptor.
    assert(Legal->getReductionVars()->count(RdxPhi) &&
           "Unable to find the reduction variable");
    RecurrenceDescriptor RdxDesc = (*Legal->getReductionVars())[RdxPhi];

    RecurrenceDescriptor::RecurrenceKind RK = RdxDesc.getRecurrenceKind();
    TrackingVH<Value> ReductionStartValue = RdxDesc.getRecurrenceStartValue();
    // TODO: Actually make this function aware of multiple exit vals.
    Instruction *LoopExitInst = RdxDesc.getLoopExitInstrs()->back();
    RecurrenceDescriptor::MinMaxRecurrenceKind MinMaxKind =
        RdxDesc.getMinMaxRecurrenceKind();
    setDebugLocFromInst(Builder, ReductionStartValue);

    // We need to generate a reduction vector from the incoming scalar.
    // To do so, we need to generate the 'identity' vector and override
    // one of the elements with the incoming scalar reduction. We need
    // to do it in the vector-loop preheader.
    Builder.SetInsertPoint(LoopVectorPreHeader->getTerminator());

    // This is the vector-clone of the value that leaves the loop.
    VectorParts &VectorExit = getVectorValue(LoopExitInst, BodyWMap);
    Type *VecTy = VectorExit[0]->getType();

    // Before each round, move the insertion point right between
    // the PHIs and the values we are going to write.
    // This allows us to write both PHINodes and the extractelement
    // instructions.
    Builder.SetInsertPoint(&*LoopVectorTail->getTerminator());

    // Get the last reduction value from the vector tail, rather
    // than the vector body.
    VectorParts RdxParts = getVectorValue(LoopExitInst, VTailWMap);
    setDebugLocFromInst(Builder, LoopExitInst);

    // If the vector reduction can be performed in a smaller type, we truncate
    // then extend the loop exit value to enable InstCombine to evaluate the
    // entire expression in the smaller type.
    if (VF > 1 && RdxPhi->getType() != RdxDesc.getRecurrenceType()) {
      Type *RdxVecTy = VectorType::get(RdxDesc.getRecurrenceType(), VF,
                                       Scalable);
      Builder.SetInsertPoint(LoopVectorBody.back()->getTerminator());
      unsigned part = 0;
      {
        Value *Trunc = Builder.CreateTrunc(RdxParts[part], RdxVecTy);
        Value *Extnd = RdxDesc.isSigned() ? Builder.CreateSExt(Trunc, VecTy)
                                          : Builder.CreateZExt(Trunc, VecTy);
        for (Value::user_iterator UI = RdxParts[part]->user_begin();
             UI != RdxParts[part]->user_end();)
          if (*UI != Trunc) {
            (*UI++)->replaceUsesOfWith(RdxParts[part], Extnd);
            RdxParts[part] = Extnd;
          } else {
            ++UI;
          }
      }
      Builder.SetInsertPoint(&*ReductionLoop->getFirstInsertionPt());
      RdxParts[0] = Builder.CreateTrunc(RdxParts[0], RdxVecTy);
    }

    // Reduce all of the unrolled parts into a single vector.
    Value *ReducedPartRdx = RdxParts[0];
    unsigned Op = RecurrenceDescriptor::getRecurrenceBinOp(RK);
    setDebugLocFromInst(Builder, ReducedPartRdx);
    /* TODO: Remove? Only deals with unrolled code, which we won't use...
    for (unsigned part = 1; part < UF; ++part) {
      if (Op != Instruction::ICmp && Op != Instruction::FCmp)
        // Floating point operations had to be 'fast' to enable the reduction.
        ReducedPartRdx = addFastMathFlag(
            Builder.CreateBinOp((Instruction::BinaryOps)Op, RdxParts[part],
                                ReducedPartRdx, "bin.rdx"));
      else
        ReducedPartRdx = RecurrenceDescriptor::createMinMaxOp(
            Builder, MinMaxKind, ReducedPartRdx, RdxParts[part]);
    }
    */

    if ((VF > 1) && !isScalable()) {
      // VF is a power of 2 so we can emit the reduction using log2(VF) shuffles
      // and vector ops, reducing the set of values being computed by half each
      // round.
      assert(isPowerOf2_32(VF) &&
             "Reduction emission only supported for pow2 vectors!");
      Value *TmpVec = ReducedPartRdx;
      SmallVector<Constant*, 32> ShuffleMask(VF, nullptr);
      for (unsigned i = VF; i != 1; i >>= 1) {
        // Move the upper half of the vector to the lower half.
        for (unsigned j = 0; j != i/2; ++j)
          ShuffleMask[j] = Builder.getInt32(i/2 + j);

        // Fill the rest of the mask with undef.
        std::fill(&ShuffleMask[i/2], ShuffleMask.end(),
                  UndefValue::get(Builder.getInt32Ty()));

        Value *Shuf =
        Builder.CreateShuffleVector(TmpVec,
                                    UndefValue::get(TmpVec->getType()),
                                    ConstantVector::get(ShuffleMask),
                                    "rdx.shuf");

        if (Op != Instruction::ICmp && Op != Instruction::FCmp) {
          // Floating point operations had to be 'fast' to enable the reduction.
          TmpVec = addFastMathFlag(Builder.CreateBinOp(
              (Instruction::BinaryOps)Op, TmpVec, Shuf, "bin.rdx"));
        }
        else
          TmpVec = RecurrenceDescriptor::createMinMaxOp(Builder, MinMaxKind,
                                                        TmpVec, Shuf);
      }

      // The result is in the first element of the vector.
      ReducedPartRdx = Builder.CreateExtractElement(TmpVec,
                                                    Builder.getInt32(0));
    }

    // Compute vector reduction for scalable vectors
    if ((VF > 1) && isScalable()) {
      bool NoNaN = Legal->hasNoNaNAttr();

      // Before scalarizing, check if the target has an intrinsic to do the job.
      if (!DisableReductionIntrinsics &&
          TTI->canReduceInVector(RdxDesc, NoNaN)) {
        ReducedPartRdx =
          TTI->getReductionIntrinsic(Builder, RdxDesc, NoNaN, ReducedPartRdx);
        assert(ReducedPartRdx != nullptr);
      } else {
        Constant *Zero = Builder.getInt32(0);
        Value *StartAcc = Builder.CreateExtractElement(ReducedPartRdx, Zero);
        Value *NumEls = getElementCount(Builder.getInt32Ty(), VF, Scalable);

        // *********************************************************************
        // Start of reduction loop
        // *********************************************************************

        Builder.SetInsertPoint(ReductionLoop->getFirstNonPHI());
        PHINode *Idx = Builder.CreatePHI(Builder.getInt32Ty(), 2, "rdx.idx");
        PHINode *Acc = Builder.CreatePHI(StartAcc->getType(), 2, "rdx.acc");

        // ReducedPartRdx[Idx]
        Value *Lane = Builder.CreateExtractElement(ReducedPartRdx, Idx);

        // Acc = Acc <op> ReducedPartRdx[Idx]
        Value *NextAcc;
        if (Op != Instruction::ICmp && Op != Instruction::FCmp)
          NextAcc = Builder.CreateBinOp((Instruction::BinaryOps)Op, Acc, Lane);
        else
          NextAcc = RdxDesc.createMinMaxOp(Builder,
                                           RdxDesc.getMinMaxRecurrenceKind(),
                                           Acc, Lane);

        Acc->addIncoming(StartAcc, LoopVectorTail);
        Acc->addIncoming(NextAcc, ReductionLoop);

        Value *NextIdx = Builder.CreateAdd(Idx, Builder.getInt32(1));
        Idx->addIncoming(Builder.getInt32(1), LoopVectorTail);
        Idx->addIncoming(NextIdx, ReductionLoop);

        Value *LoopCond  = Builder.CreateICmpULT(NextIdx, NumEls);
        Instruction *OldTerm = ReductionLoop->getTerminator();
        BranchInst::Create(ReductionLoop, ReductionLoopRet, LoopCond, OldTerm);
        OldTerm->eraseFromParent();

        // *********************************************************************
        // End of reduction loop
        // *********************************************************************

        ReducedPartRdx = NextAcc;
      }
    }


    if (VF > 1) {
      // If the reduction can be performed in a smaller type, we need to extend
      // the reduction to the wider type before we branch to the original loop.
      if (RdxPhi->getType() != RdxDesc.getRecurrenceType())
        ReducedPartRdx =
            RdxDesc.isSigned()
                ? Builder.CreateSExt(ReducedPartRdx, RdxPhi->getType())
                : Builder.CreateZExt(ReducedPartRdx, RdxPhi->getType());
    }

    // Create a phi node that merges control-flow from the backedge-taken check
    // block and the middle block.
    PHINode *BCBlockPhi = PHINode::Create(RdxPhi->getType(), 2, "bc.merge.rdx",
                                          LoopScalarPreHeader->getTerminator());
    BCBlockPhi->addIncoming(ReducedPartRdx, ReductionLoopRet);
    for (auto *BB : LoopBypassBlocks)
      for (auto *Succ : successors(BB))
        if (Succ == LoopScalarPreHeader)
          BCBlockPhi->addIncoming(ReductionStartValue, BB);

    // If there were stores of the reduction value to a uniform memory address
    // inside the loop, create the final store here.
    if (StoreInst *SI = RdxDesc.IntermediateStore) {
      StoreInst *NewSI = Builder.CreateStore(ReducedPartRdx,
                                             SI->getPointerOperand());
      propagateMetadata(NewSI, SI);
      // If the reduction value is used in other places,
      // then let the code below create PHI's for that.
    }

    // Now, we need to fix the users of the reduction variable
    // inside and outside of the scalar remainder loop.
    // We know that the loop is in LCSSA form. We need to update the
    // PHI nodes in the exit blocks.
    for (BasicBlock::iterator LEI = LoopExitBlock->begin(),
         LEE = LoopExitBlock->end(); LEI != LEE; ++LEI) {
      PHINode *LCSSAPhi = dyn_cast<PHINode>(LEI);
      if (!LCSSAPhi) break;

      // All PHINodes need to have a single entry edge, or two if
      // we already fixed them.
      assert(LCSSAPhi->getNumIncomingValues() < 3 && "Invalid LCSSA PHI");

      // We found our reduction value exit-PHI. Update it with the
      // incoming bypass edge.
      for (Value *Incoming : LCSSAPhi->incoming_values()) {
        if (Incoming == LoopExitInst) {
          // Add an edge coming from the bypass.
          LCSSAPhi->addIncoming(ReducedPartRdx, ReductionLoopRet);
          break;
        }
      }
    }// end of the LCSSA phi scan.

    // Fix the scalar loop reduction variable with the incoming reduction sum
    // from the vector body and from the backedge value.
    int IncomingEdgeBlockIdx =
        RdxPhi->getBasicBlockIndex(OrigLoop->getLoopLatch());
    assert(IncomingEdgeBlockIdx >= 0 && "Invalid block index");
    // Pick the other block.
    int SelfEdgeBlockIdx = (IncomingEdgeBlockIdx ? 0 : 1);
    RdxPhi->setIncomingValue(SelfEdgeBlockIdx, BCBlockPhi);
    RdxPhi->setIncomingValue(IncomingEdgeBlockIdx, LoopExitInst);
  }// end of for each redux variable.

  fixLCSSAPHIs();

  // Make sure DomTree is updated.
  updateAnalysis();

  // Predicate any stores.
  for (auto KV : PredicatedStores) {
    BasicBlock::iterator I(KV.first);
    auto *BB = SplitBlock(I->getParent(), &*std::next(I), DT, LI);
    auto *T = SplitBlockAndInsertIfThen(KV.second, &*I, /*Unreachable=*/false,
                                        /*BranchWeights=*/nullptr, DT);
    I->moveBefore(T);
    I->getParent()->setName("pred.store.if");
    BB->setName("pred.store.continue");
  }
  DEBUG(DT->verifyDomTree());
  // Remove redundant induction instructions.
  CSE(LoopVectorBody, PredicatedBlocks);
  DEBUG(verifyFunction(*(ReductionLoop->getParent()), &dbgs()));
}

void InnerLoopVectorizer::fixLCSSAPHIs() {
  for (BasicBlock::iterator LEI = LoopExitBlock->begin(),
       LEE = LoopExitBlock->end(); LEI != LEE; ++LEI) {
    PHINode *LCSSAPhi = dyn_cast<PHINode>(LEI);
    if (!LCSSAPhi) break;
    if (LCSSAPhi->getNumIncomingValues() == 1)
      LCSSAPhi->addIncoming(UndefValue::get(LCSSAPhi->getType()),
                            ReductionLoopRet);
  }
}

InnerLoopVectorizer::VectorParts
InnerLoopVectorizer::createEdgeMask(BasicBlock *Src, BasicBlock *Dst,
                                    ValueMap &WidenMap) {
  assert(std::find(pred_begin(Dst), pred_end(Dst), Src) != pred_end(Dst) &&
         "Invalid edge");

  // Look for cached value.
  std::pair<BasicBlock*, BasicBlock*> Edge(Src, Dst);
  EdgeMaskCache::iterator ECEntryIt = MaskCache.find(Edge);
  if (ECEntryIt != MaskCache.end())
    return ECEntryIt->second;

  VectorParts SrcMask = createBlockInMask(Src, WidenMap);

  // The terminator has to be a branch inst!
  BranchInst *BI = dyn_cast<BranchInst>(Src->getTerminator());
  assert(BI && "Unexpected terminator found");

  if (BI->isConditional()) {
    VectorParts EdgeMask = getVectorValue(BI->getCondition(), WidenMap);

    if (BI->getSuccessor(0) != Dst)
      EdgeMask[0] = Builder.CreateNot(EdgeMask[0]);

    EdgeMask[0] = Builder.CreateAnd(EdgeMask[0], SrcMask[0]);

    MaskCache[Edge] = EdgeMask;
    return EdgeMask;
  }

  MaskCache[Edge] = SrcMask;
  return SrcMask;
}

InnerLoopVectorizer::VectorParts
InnerLoopVectorizer::createBlockInMask(BasicBlock *BB, ValueMap &WidenMap) {
  assert(OrigLoop->contains(BB) && "Block is not a part of a loop");

  // Loop incoming mask is all-one.
  if (OrigLoop->getHeader() == BB) {
    Value *C = ConstantInt::get(IntegerType::getInt1Ty(BB->getContext()), 1);
    return getVectorValue(C, WidenMap);
  }

  // This is the block mask. We OR all incoming edges, and with zero.
  Value *Zero = ConstantInt::get(IntegerType::getInt1Ty(BB->getContext()), 0);
  VectorParts BlockMask = getVectorValue(Zero, WidenMap);

  // For each pred:
  for (pred_iterator it = pred_begin(BB), e = pred_end(BB); it != e; ++it) {
    VectorParts EM = createEdgeMask(*it, BB, WidenMap);
    BlockMask[0] = Builder.CreateOr(BlockMask[0], EM[0]);
  }

  return BlockMask;
}

// TODO: No need to pass 'Entry'?
void InnerLoopVectorizer::widenPHIInstruction(Instruction *PN,
                                              InnerLoopVectorizer::VectorParts &Entry,
                                              unsigned VF, PhiVector *PV,
                                              ValueMap &WidenMap) {
  PHINode* P = cast<PHINode>(PN);
  // Handle reduction variables:
  if (Legal->getReductionVars()->count(P)) {
    // This is phase one of vectorizing PHIs.
    Type *VecTy = (VF == 1) ? PN->getType() :
      VectorType::get(PN->getType(), VF, Scalable);
    Entry[0] = PHINode::Create(
       VecTy, 2, "vec.phi", &*LoopVectorBody.back()->getFirstInsertionPt());
    PV->push_back(P);
    return;
  }

  setDebugLocFromInst(Builder, P);
  // Check for PHI nodes that are lowered to vector selects.
  if (P->getParent() != OrigLoop->getHeader()) {
    // We know that all PHIs in non-header blocks are converted into
    // selects, so we don't have to worry about the insertion order and we
    // can just use the builder.
    // At this point we generate the predication tree. There may be
    // duplications since this is a simple recursive scan, but future
    // optimizations will clean it up.

    unsigned NumIncoming = P->getNumIncomingValues();

    // Generate a sequence of selects of the form:
    // SELECT(Mask3, In3,
    //      SELECT(Mask2, In2,
    //                   ( ...)))
    for (unsigned In = 0; In < NumIncoming; In++) {
      VectorParts Cond = createEdgeMask(P->getIncomingBlock(In),
                                        P->getParent(), WidenMap);
      VectorParts &In0 = getVectorValue(P->getIncomingValue(In), WidenMap);

      unsigned part = 0;
      {
        // We might have single edge PHIs (blocks) - use an identity
        // 'select' for the first PHI operand.
        if (In == 0)
          Entry[part] = Builder.CreateSelect(Cond[part], In0[part],
                                             In0[part]);
        else
          // Select between the current value and the previous incoming edge
          // based on the incoming mask.
          Entry[part] = Builder.CreateSelect(Cond[part], In0[part],
                                             Entry[part], "predphi");
      }
    }
    return;
  }

  // This PHINode must be an induction variable.
  // Make sure that we know about it.
  assert(Legal->getInductionVars()->count(P) &&
         "Not an induction variable");

  InductionDescriptor II = Legal->getInductionVars()->lookup(P);

  // FIXME: The newly created binary instructions should contain nsw/nuw flags,
  // which can be found from the original scalar operations.
  switch (II.getKind()) {
    case InductionDescriptor::IK_NoInduction:
      llvm_unreachable("Unknown induction");
    case InductionDescriptor::IK_IntInduction: {
      Type *PhiTy = P->getType();
      assert(PhiTy == II.getStartValue()->getType() && "Types must match");
      // Handle other induction variables that are now based on the
      // canonical one.
      Value *V = Induction;
      if (P != OldInduction) {
        V = Builder.CreateSExtOrTrunc(Induction, PhiTy);
        const DataLayout &DL = P->getModule()->getDataLayout();
        V = II.transform(Builder, V, PSE.getSE(), DL);
        V->setName("offset.idx");
      }
      Value *Broadcasted = getBroadcastInstrs(V);
      Value *NumEls = getElementCount(PhiTy, VF, Scalable, PhiTy);
      // After broadcasting the induction variable we need to make the vector
      // consecutive by adding 0, 1, 2, etc.
      Value *Part = ConstantInt::get(PhiTy, 0);
      Value *StartIdx = Builder.CreateMul(NumEls, Part);
      Entry[0] = getStepVector(Broadcasted, StartIdx, II.getStep());
      return;
    }
    case InductionDescriptor::IK_PtrInduction: {
      // Handle the pointer induction variable case.
      assert(P->getType()->isPointerTy() && "Unexpected type.");
      // This is the normalized GEP that starts counting at zero.
      Value *PtrInd = Induction;
      PtrInd = Builder.CreateSExtOrTrunc(PtrInd, II.getStep()->getType());

      if (!isScalable()) {
        // This is the vector of results. Notice that we don't generate
        // vector geps because scalar geps result in better code.
        unsigned part = 0;
        {
          /*
          if (VF == 1) {
            int EltIndex = part;
            Constant *Idx = ConstantInt::get(PtrInd->getType(),EltIndex);
            Value *GlobalIdx = Builder.CreateAdd(PtrInd, Idx);
            Value *SclrGep = II.transform(Builder, GlobalIdx);
            SclrGep->setName("next.gep");
            Entry[part] = SclrGep;
            continue;
          }
          */

          Value *VecVal = UndefValue::get(VectorType::get(P->getType(), VF));
          for (unsigned int i = 0; i < VF; ++i) {
            int EltIndex = i + part * VF;
            Constant *Idx = ConstantInt::get(PtrInd->getType(),EltIndex);
            Value *GlobalIdx = Builder.CreateAdd(PtrInd, Idx);
            const DataLayout &DL = P->getModule()->getDataLayout();
            Value *SclrGep = II.transform(Builder, GlobalIdx, PSE.getSE(), DL);
            SclrGep->setName("next.gep");
            VecVal = Builder.CreateInsertElement(VecVal, SclrGep,
                                                 Builder.getInt32(i),
                                                 "insert.gep");
          }
          Entry[part] = VecVal;
        }
      } else {
        Type *PhiTy = PtrInd->getType();
        Value *NumEls = getElementCount(P->getType(), VF, Scalable, PhiTy);

        Value *StepValue;
        ScalarEvolution *SE = PSE.getSE();
        const DataLayout &DL = PN->getModule()->getDataLayout();
        SCEVExpander Expander(*SE, DL, "seriesgep");
        if (Legal->getInductionVars()->count(P)) {
          const SCEV *Step = Legal->getInductionVars()->lookup(P).getStep();
          StepValue = Expander.expandCodeFor(Step, Step->getType(),
                                             &*Builder.GetInsertPoint());
        } else {
          auto *SAR = dyn_cast<SCEVAddRecExpr>(PSE.getSE()->getSCEV(PN));
          assert(SAR && SAR->isAffine() && "Pointer induction not loop affine");

          // Create SCEV expander for Start- and StepValue
          const DataLayout &DL = PN->getModule()->getDataLayout();
          SCEVExpander Expander(*PSE.getSE(), DL, "seriesgep");

          // Expand step and start value (the latter in preheader)
          const SCEV *StepRec = SAR->getStepRecurrence(*PSE.getSE());
          StepValue = Expander.expandCodeFor(StepRec, StepRec->getType(),
                                             &*Builder.GetInsertPoint());
          // Normalize step to be in #elements, not bytes
          Type *ElemTy = PN->getType()->getPointerElementType();
          Value *Tmp = ConstantInt::get(StepValue->getType(),
                                        DL.getTypeAllocSize(ElemTy));
          StepValue = Builder.CreateSDiv(StepValue, Tmp);
        }

        unsigned part = 0;
        {
          Value *Part = ConstantInt::get(PhiTy, part);
          Value *Idx = Builder.CreateMul(NumEls, Part);
          Value *GlobalIdx = Builder.CreateAdd(PtrInd, Idx);
          Value *SclrGep = II.transform(Builder, GlobalIdx, SE, DL);
          SclrGep->setName("next.gep");
          Value *Offs = Builder.CreateSeriesVector({VF,Scalable},
              ConstantInt::get(StepValue->getType(), 0), StepValue);
          Entry[part] = Builder.CreateGEP(SclrGep, Offs);
          Entry[part]->setName("vector.gep");
        }
      }
      return;
    }
  }
}

/// Insert early break checks using 'Map' as the ValueMap.
/// Returns the 'and'ed value for all conditions.
/// Each handled (scalar) condition is separately stored in 'Conditions'.
Value *InnerLoopVectorizer::insertEarlyBreaks(
              ValueMap &Map, Value *NextInd, SmallVectorImpl<Value*> &Conditions, Value *Pred) {
  // Save Induction
  Value *SavedInd = Induction;
  Induction = NextInd;

  // Save Predicate for this function alone
  Value *CP = Predicate;
  Predicate = Pred;

  // Reset the set of speculative predicates
  SpeculativePredicates.clear();

  // Insert all break conditions
  Value *PredV = Predicate;
  for (auto &Exit : Legal->exits()) {
    // In the vector body, generate the predicates
    // for each of the early exits.
    PhiVector TmpPV;
    for (Value *V : Exit.Nodes) {
      if (OrigLoop->isLoopInvariant(V)) {
        assert(getVectorValue(V, Map)[0] != nullptr &&
               "Couldn't widen LI value");
        continue;
      }

      // TODO: If we know 'I' uses the result of a speculative load (can
      // be looked up in SpeculativePredicates) and may cause side-effects
      // on illegal data (e.g. exception on fdiv) then we need to use:
      //  (Predicate & SpeculativePredicate)
      // to select the input operands and/or as predicate for the
      // operation, because the input may be garbage (i.e. undefined if
      // speculatively loaded lanes previously faulted).
      // Note that we do not yet have any support to do a predicated
      // operation other than loads/stores, so we'll have to default to
      // using selects.

      // If I is not an instruction, Legality checking has a bug.
      Instruction *I = cast<Instruction>(V);
      widenInstruction(I, I->getParent(), &TmpPV, Map);
    }

    // We now combine each predicate into a final 'exit' predicate.
    BranchInst *Br = cast<BranchInst>(Exit.ExitingBlock->getTerminator());
    Value *VCond = Map.get(Br->getCondition())[0];

    // Store the vectorized condition for later use
    Conditions.push_back(Br->getCondition());

    // AND together results
    if (Br->getSuccessor(0) == Exit.ExitBlock)
      VCond = Builder.CreateNot(VCond);
    PredV = Builder.CreateAnd(PredV, VCond);

    // Any condition expression that follows next must also
    // use the right predicate (if they need any), e.g.
    //  for(..; i<N; ++){
    //    if (a[i] < K) break;
    //    if (b[i] < K) break;  <- Load b[i] under predicate a[i] < K.
    Predicate = PredV;
  }

  // If any of the conditions contained a speculative load,
  // AND the resulting predicate mask with all speculatively loaded lanes.
  if (!SpeculativePredicates.empty()) {
    Value *SpeculativePredicate = ConstantInt::getTrue(Predicate->getType());
    for (auto &KV : SpeculativePredicates)
      SpeculativePredicate = Builder.CreateAnd(SpeculativePredicate, KV.second);

    PredV = Builder.CreateAnd(PredV, SpeculativePredicate);

    // Provide the vector tail with speculative fault data so that we can
    // recover via the scalar loop if required.
    TailSpeculativeLanes->addIncoming(SpeculativePredicate,
                                      &Map == &PHMap ? LoopVectorPreHeader :
                                      LoopVectorBody.back());
  }

  // Restore Predicate
  Predicate = CP;

  // Restore Induction
  Induction = SavedInd;

  return PredV;
}

void InnerLoopVectorizer::vectorizeExits() {

  BasicBlock *LastBB = LoopVectorBody.back();
  // TODO: Shouldn't need to create new step + compare, just work with
  // existing compare? does propff do what we want? better to expose
  // partitioning instrs directly?

  // For now, we've just copied the original createEmptyLoopWithPredication
  // logic of generating a predicate solely from the (known) trip count.

  // When using predication the number of elements processed per iteration
  // becomes a runtime quantity.  However, index.next is calculated making the
  // assumption that a whole vector's worth of elements are processed, which
  // today is true for all but the last iteration.  This means index.next can
  // potentially be larger than that within the original loop, which prevents
  // the propagation of the original's wrapping knowldge.
  //
  // Instead we use scalar evolution to determine the wrapping behaviour of the
  // vector loop's index.next so later passes can optimise our control flow.
  // TODO: Certain loops will force the requirement that index.next be accurate
  // when exiting the loop, at which point an 'active element count' will be
  // used.  However, it seems inefficient to force this requirement for loops
  // that don't need it.

  bool NSW = true;
  bool NUW = true;
  if (IdxEnd) {
    ScalarEvolution *SE = PSE.getSE();
    int BitWidth = cast<IntegerType>(IdxEnd->getType())->getBitWidth();
    const SCEV *IdxEndSCEV = SE->getSCEV(IdxEnd);

    const SCEV *InductionStepSCEV = SE->getSCEV(InductionStep);
    const SCEV *StepCountSCEV = SE->getConstant(InductionStepSCEV->getType(), 1);
    const SCEV *IndIncrSCEV = SE->getMulExpr(InductionStepSCEV, StepCountSCEV);

    const SCEV *MaxSIntSCEV = SE->getConstant(APInt::getSignedMaxValue(BitWidth));
    const SCEV *MaxUIntSCEV = SE->getConstant(APInt::getMaxValue(BitWidth));

    const SCEV *SLimit = SE->getMinusSCEV(MaxSIntSCEV, IndIncrSCEV);
    const SCEV *ULimit = SE->getMinusSCEV(MaxUIntSCEV, IndIncrSCEV);
    NSW = SE->isKnownPredicate(ICmpInst::ICMP_SLE, IdxEndSCEV, SLimit);
    NUW = SE->isKnownPredicate(ICmpInst::ICMP_ULE, IdxEndSCEV, ULimit);
  }

  Value *NextIdx = Builder.CreateAdd(Induction, InductionStep, "index.next",
                                     NUW, NSW);
  Value *NextPred = ConstantInt::getTrue(Predicate->getType());

  // Insert all break conditions (with the updated Induction value
  // for the next iteration)
  SmallVector<Value*,5> Conds;
  NextPred = insertEarlyBreaks(NextBodyWMap, NextIdx, Conds, NextPred);

  // For each exit condition, patch the PHI node that either gets the
  // calculated value from ..
  for (auto *Cond : Conds) {
    Value *VCond = NextBodyWMap.get(Cond)[0];
    auto *VCondPHI = dyn_cast<PHINode>(VTailWMap.get(Cond)[0]);
    VCondPHI->addIncoming(VCond, LastBB);
  }

  // Set predicate for next iteration (in vector body, this is always PTRUE)
  VecBodyOutPred = NextPred;

  // We're not done in the unpredicated vector body if we have
  // a full vector iteration to handle. If there is a break condition
  // somewhere in the next predicate, we need to move to vector tail.
  Value *Done = Builder.CreateTest(TestInst::ALL_TRUE, NextPred, "has.exit");
  cast<PHINode>(Induction)->addIncoming(NextIdx, LoopVectorBody.back());
  LatchBranch->setCondition(Done);
}

void InnerLoopVectorizer::vectorizeBlockInLoop(BasicBlock *BB, PhiVector *PV,
                                               ValueMap &WidenMap) {
  // For each instruction in the old loop.
  for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e; ++it)
    widenInstruction(&*it, BB, PV, WidenMap);
}

void InnerLoopVectorizer::widenInstruction(Instruction *it, BasicBlock *BB,
                                           PhiVector *PV, ValueMap &WidenMap) {
    VectorParts &Entry = WidenMap.get(it);

    // TODO: Update comment to unpred body + pred tail
    // The instruction may already have an entry in the map if we're in an
    // uncounted loop -- the safe nodes for early exits are calculated at
    // the start of the block.
    if (Entry[0] != nullptr)
      return;

    switch (it->getOpcode()) {
    case Instruction::Br: {
      // Vector tail requires selects for each escapee value.
      if (&WidenMap != &VTailWMap)
        break;

      // Break if unconditional branch or when there are no escapees.
      // TODO: Surely getEscapees.size() == 0? or .empty if available?
      auto *CurrentBranch = dyn_cast<BranchInst>(it);
      if (CurrentBranch->isUnconditional() ||
          Legal->getEF()->getEscapees().begin() ==
          Legal->getEF()->getEscapees().end())
        break;

      // Test if this branch is an exit branch (if not, it will be used
      // for regular predication).
      if (!OrigLoop->isLoopExiting(CurrentBranch->getParent()))
        break;

      // Select values for each of the Escapees
      for (auto E : Legal->getEF()->getEscapees()) {
        Instruction *MergeNode = E.first;
        Escapee *Esc = E.second;

        // Induction
        Value *EscVal = Esc->getValue(BranchCounter);

        // Merge = Select (predicate, new_value, old_value)
        VectorParts &Parts = WidenMap.get(MergeNode);
        Value *NewVal = getVectorValue(EscVal, WidenMap)[0];
        Value *MergeVal = Builder.CreateSelect(Predicate, NewVal, Parts[0]);
        Parts[0] = MergeVal;

        // Also update the original value, which may be
        // reused in e.g. the reduction.
        VectorParts &Parts2 = WidenMap.get(EscVal);
        Parts2[0] = MergeVal;
      }

      // Get the vectorized condition for this branch
      Value *Condition =
          WidenMap.get(CurrentBranch->getCondition())[0];

      if (OrigLoop->contains(CurrentBranch->getSuccessor(0))) {
        Condition = Builder.CreateNot(Condition);
      }

      // Update the predicate accordingly for the next instructions:
      //
      //    Pg = (condition ^ Pg) & Pg
      //
      // where Pg starts off as the yellow lanes. The 'xor' removes the
      // lane from the predicate when the condition is true in that iteration.
      //
      // For example:
      //  while(C0) {               while(true) {
      //    S1;                       if (C0) break;
      //    if (C1) break;            S1;
      //    S2;              <=>      if (C1) break;
      //    if (C2) break;            S2;
      //    S3;                       if (C2) break;
      //  }                           S3;
      //                            }
      // i:  0, 1, 2, 3, 4, 5, 6, 7
      // C0: 0, 0, 0, 0, 0, 0, 1, 0
      // C1: 0, 0, 0, 1, 0, 0, 0, 0
      // C2: 0, 0, 0, 0, 0, 0, 0, 1
      //
      // C0 & C1 & C2:
      //     0, 0, 0, 1, 0, 0, 1, 1
      //
      // green lanes:
      //     1, 1, 1, 0, 0, 0, 0, 0
      //
      // yellow lanes:
      //     1, 1, 1, 1, 0, 0, 0, 0
      //
      // active lanes for S1:
      //     1, 1, 1, 1, 0, 0, 0, 0
      //
      // active lanes for S2 and S3:
      //     1, 1, 1, 0, 0, 0, 0, 0
      // because C1 causes the first break and S2/S3 follow after C1.
      Value *NewPredicate = Builder.CreateXor(Condition, Predicate);
      Predicate = Builder.CreateAnd(NewPredicate, Predicate);

      // Update for next branch
      BranchCounter++;

      break;
    }
    case Instruction::PHI: {
      // Vectorize PHINodes.
      widenPHIInstruction(it, Entry, VF, PV, WidenMap);
      break;
    }// End of PHI.

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
      // Just widen binops.
      BinaryOperator *BinOp = dyn_cast<BinaryOperator>(it);
      setDebugLocFromInst(Builder, BinOp);
      VectorParts &A = getVectorValue(it->getOperand(0), WidenMap);
      VectorParts &B = getVectorValue(it->getOperand(1), WidenMap);

      // Use this vector value for all users of the original instruction.
      Value *V = Builder.CreateBinOp(BinOp->getOpcode(), A[0], B[0]);

      if (BinaryOperator *VecOp = dyn_cast<BinaryOperator>(V))
        VecOp->copyIRFlags(BinOp);

      Entry[0] = V;

      propagateMetadata(Entry, it);
      break;
    }
    case Instruction::Select: {
      // Widen selects.
      // If the selector is loop invariant we can create a select
      // instruction with a scalar condition. Otherwise, use vector-select.
      auto *SE = PSE.getSE();
      bool InvariantCond = SE->isLoopInvariant(SE->getSCEV(it->getOperand(0)),
                                               OrigLoop);
      setDebugLocFromInst(Builder, it);

      // The condition can be loop invariant  but still defined inside the
      // loop. This means that we can't just use the original 'cond' value.
      // We have to take the 'vectorized' value and pick the first lane.
      // Instcombine will make this a no-op.
      VectorParts &Cond = getVectorValue(it->getOperand(0), WidenMap);
      VectorParts &Op0  = getVectorValue(it->getOperand(1), WidenMap);
      VectorParts &Op1  = getVectorValue(it->getOperand(2), WidenMap);

      Value *ScalarCond = (VF == 1) ? Cond[0] :
        Builder.CreateExtractElement(Cond[0], Builder.getInt32(0));

      Entry[0] = Builder.CreateSelect(InvariantCond ? ScalarCond : Cond[0],
                                      Op0[0], Op1[0]);

      propagateMetadata(Entry, it);
      break;
    }

    case Instruction::ICmp:
    case Instruction::FCmp: {
      // Widen compares. Generate vector compares.
      bool FCmp = (it->getOpcode() == Instruction::FCmp);
      CmpInst *Cmp = dyn_cast<CmpInst>(it);
      setDebugLocFromInst(Builder, it);
      VectorParts &A = getVectorValue(it->getOperand(0), WidenMap);
      VectorParts &B = getVectorValue(it->getOperand(1), WidenMap);
      unsigned Part = 0;
      {
        Value *C = nullptr;
        if (FCmp) {
          C = Builder.CreateFCmp(Cmp->getPredicate(), A[Part], B[Part]);
          cast<FCmpInst>(C)->copyFastMathFlags(it);
        } else {
          C = Builder.CreateICmp(Cmp->getPredicate(), A[Part], B[Part]);
        }
        Entry[Part] = C;
      }

      propagateMetadata(Entry, it);
      break;
    }

    case Instruction::Store:
    case Instruction::Load:
      vectorizeMemoryInstruction(it, WidenMap);
        break;
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
      CastInst *CI = dyn_cast<CastInst>(it);
      setDebugLocFromInst(Builder, it);
      /// Optimize the special case where the source is the induction
      /// variable. Notice that we can only optimize the 'trunc' case
      /// because: a. FP conversions lose precision, b. sext/zext may wrap,
      /// c. other casts depend on pointer size.
      if (CI->getOperand(0) == OldInduction &&
          it->getOpcode() == Instruction::Trunc) {
        Value *ScalarCast = Builder.CreateCast(CI->getOpcode(), Induction,
                                               CI->getType());
        Value *Broadcasted = getBroadcastInstrs(ScalarCast);
        InductionDescriptor II = Legal->getInductionVars()->lookup(OldInduction);
        ScalarEvolution *SE = PSE.getSE();
        const DataLayout &DL = OldInduction->getModule()->getDataLayout();
        SCEVExpander Expander(*SE, DL, "seriesgep");
        const SCEV *StepSCEV = II.getStep();
        Value *StepValue =
            Expander.expandCodeFor(StepSCEV, StepSCEV->getType(),
                                   &*Builder.GetInsertPoint());
        Value *Step = Builder.CreateSExtOrTrunc(StepValue, CI->getType());

        Type* ElemTy = Broadcasted->getType()->getScalarType();
        Value* NumEls = getElementCount(ElemTy, VF, Scalable, ElemTy);
        Value *Start = Builder.CreateMul(NumEls,
                                         ConstantInt::get(ElemTy, 0));
        Entry[0] = getStepVector(Broadcasted, Start, Step);

        propagateMetadata(Entry, it);
        break;
      }
      /// Vectorize casts.
      Type *DestTy = (VF == 1) ? CI->getType()
                               : VectorType::get(CI->getType(), VF, Scalable);

      VectorParts &A = getVectorValue(it->getOperand(0), WidenMap);
      Entry[0] = Builder.CreateCast(CI->getOpcode(), A[0], DestTy);
      propagateMetadata(Entry, it);
      break;
    }

    case Instruction::Call: {
      // Ignore dbg intrinsics.
      if (isa<DbgInfoIntrinsic>(it))
        break;
      setDebugLocFromInst(Builder, it);

      Module *M = BB->getParent()->getParent();
      CallInst *CI = cast<CallInst>(it);

      StringRef FnName = CI->getCalledFunction()->getName();
      Function *F = CI->getCalledFunction();
      Type *RetTy = ToVectorTy(CI->getType(), VF);
      SmallVector<Type *, 4> Tys;
      for (unsigned i = 0, ie = CI->getNumArgOperands(); i != ie; ++i)
        Tys.push_back(ToVectorTy(CI->getArgOperand(i)->getType(), VF));

      Intrinsic::ID ID = getVectorIntrinsicIDForCall(CI, TLI);
      if (ID &&
          (ID == Intrinsic::assume || ID == Intrinsic::lifetime_end ||
           ID == Intrinsic::lifetime_start)) {
        if (isScalable() &&
            OrigLoop->isLoopInvariant(it->getOperand(0)) &&
            OrigLoop->isLoopInvariant(it->getOperand(1)))
          Builder.Insert(it->clone());
        else
          scalarizeInstruction(it, WidenMap);
        break;
      }
      // The flag shows whether we use Intrinsic or a usual Call for vectorized
      // version of the instruction.
      // Is it beneficial to perform intrinsic call compared to lib call?
      bool NeedToScalarize;
      unsigned CallCost = Costs->getVectorCallCost(CI, VF, *TTI, TLI,
                                                   NeedToScalarize);
      bool UseVectorIntrinsic =
          ID && Costs->getVectorIntrinsicCost(CI, VF, *TTI, TLI) <= CallCost;
      if (!UseVectorIntrinsic && NeedToScalarize) {
        scalarizeInstruction(it, WidenMap);
        break;
      }

      unsigned Part = 0;
      {
        SmallVector<Value *, 4> Args;
        for (unsigned i = 0, ie = CI->getNumArgOperands(); i != ie; ++i) {
          Value *Arg = CI->getArgOperand(i);
          // Some intrinsics have a scalar argument - don't replace it with a
          // vector.
          if (!UseVectorIntrinsic || !hasVectorInstrinsicScalarOpd(ID, i)) {
            VectorParts &VectorArg = getVectorValue(CI->getArgOperand(i), WidenMap);
            Arg = VectorArg[Part];
          }
          Args.push_back(Arg);
        }

        Function *VectorF;
        if (UseVectorIntrinsic) {
          // Use vector version of the intrinsic.
          Type *TysForDecl[] = {CI->getType()};
          if (VF > 1)
            TysForDecl[0] = VectorType::get(CI->getType()->getScalarType(),
                                            VF, Scalable);
          VectorF = Intrinsic::getDeclaration(M, ID, TysForDecl);
        } else {
          // Use vector version of the library call.
          StringRef VFnName = TLI->getVectorizedFunction(FnName, VF);
          assert(!VFnName.empty() && "Vector function name is empty.");
          VectorF = M->getFunction(VFnName);
          if (!VectorF) {
            // Generate a declaration
            FunctionType *FTy = FunctionType::get(RetTy, Tys, false);
            VectorF =
                Function::Create(FTy, Function::ExternalLinkage, VFnName, M);
            VectorF->copyAttributesFrom(F);
          }
        }
        assert(VectorF && "Can't create vector function.");
        Entry[Part] = Builder.CreateCall(VectorF, Args);
      }

      propagateMetadata(Entry, it);
      break;
    }

    case Instruction::GetElementPtr:
      vectorizeGEPInstruction(it, WidenMap);
      break;

    default:
      // All other instructions are unsupported. Scalarize them.
      scalarizeInstruction(it, WidenMap);
      break;
    }// end of switch.

    VectorParts &VE = WidenMap.get(it);
    if (AnnotateWidenedInstrs && VE[0] != nullptr) {
      std::string ScalarInst;
      raw_string_ostream OS(ScalarInst);
      OS << *it;
      Metadata *MDs[] = { MDString::get(it->getContext(), ScalarInst) };
      MDNode *MDN = MDNode::get(it->getContext(), MDs);
      if (Instruction *I = dyn_cast<Instruction>(VE[0]))
        I->setMetadata("llvm.widened_scalar_inst", MDN);
    }
}

void InnerLoopVectorizer::updateAnalysis() {
  // Forget the original basic block.
  PSE.getSE()->forgetLoop(OrigLoop);

  // Update the dominator tree information.
  assert(DT->properlyDominates(LoopBypassBlocks.front(), LoopExitBlock) &&
         "Entry does not dominate exit.");

  DT->addNewBlock(LoopVectorPreHeader, LoopBypassBlocks.back());

  // Add dominator for first vector body block.
  DT->addNewBlock(LoopVectorBody[0], LoopVectorPreHeader);
  for (const auto &Edge : VecBodyDomEdges)
    DT->addNewBlock(Edge.second, Edge.first);

  DT->addNewBlock(LoopVectorTail, LoopVectorPreHeader);
  DT->addNewBlock(ReductionLoop, LoopVectorTail);
  DT->addNewBlock(ReductionLoopRet, ReductionLoop);

  // Bit hacky :(
  // TODO: Is there a better way of describing structure like this?
  // Maybe we record some info earlier instead of walking over the
  // blocks...
  bool BypassPredecessor = false;
  for (BasicBlock *BB : LoopBypassBlocks)
    for (BasicBlock *Succ : BB->getTerminator()->successors())
      if (!BypassPredecessor && Succ == LoopScalarPreHeader) {
        BypassPredecessor = true;
        DT->addNewBlock(LoopScalarPreHeader, BB);
        DT->changeImmediateDominator(LoopExitBlock, BB);
      }

  if (!BypassPredecessor) {
    DT->addNewBlock(LoopScalarPreHeader, ReductionLoopRet);
    DT->changeImmediateDominator(LoopExitBlock, ReductionLoopRet);
  }
  DT->changeImmediateDominator(LoopScalarBody, LoopScalarPreHeader);


  // TODO: Reinstate some of this (conditionally) once we can detect
  // where we can elide speculative loads.
  //
//  DT->changeImmediateDominator(LoopExitBlock, LoopBypassBlocks[0]);
//
//  bool RemoveOrigLoop = true;
//  TerminatorInst *Term = LoopBypassBlocks[0]->getTerminator();
//  for (unsigned I=0; I < Term->getNumSuccessors(); ++I) {
//    if (Term->getSuccessor(I) == LoopScalarPreHeader) {
//      RemoveOrigLoop = false;
//      break;
//    }
//  }
//
//  if (RemoveOrigLoop) {
//    SmallVector<BasicBlock*,10> Desc;
//    DT->getDescendants(LoopScalarPreHeader, Desc);
//    for (auto BBI = Desc.rbegin(), BBE = Desc.rend(); BBI != BBE; ++BBI)
//      DT->eraseNode(*BBI);
//    DT->changeImmediateDominator(LoopExitBlock, ReductionLoopRet);
//
//    // For each escapee merge node, remove all values coming
//    // in from the original loop so that DCE can pick it up.
//    MapVector<BasicBlock*,SmallSet<BasicBlock*,3>> RemoveBlocks;
//    for (auto E : Legal->getEF()->getEscapees()) {
//      PHINode *MergeNode = cast<PHINode>(E.first);
//
//      for (unsigned BBI = 0; BBI < MergeNode->getNumIncomingValues(); ++BBI) {
//        auto *BB = MergeNode->getIncomingBlock(BBI);
//        if (OrigLoop->contains(BB))
//          RemoveBlocks[MergeNode->getParent()].insert(BB);
//      }
//    }
//
//    for (auto &KV : RemoveBlocks)
//      for (auto *BB : KV.second)
//        KV.first->removePredecessor(BB);
//
//    // Also remove the loop from the LoopInfo structure
//    Loop *ParentLoop = OrigLoop->getParentLoop();
//    if (ParentLoop) {
//      for (Loop::iterator I = ParentLoop->begin(),
//                          E = ParentLoop->end(); I != E; ++I) {
//        if (*I == OrigLoop) {
//          ParentLoop->removeChildLoop(I);
//          break;
//        }
//      }
//    } else
//      LI->markAsRemoved(OrigLoop);
//
//  }

  // TODO: Wrap this in DEBUG() again once stable
  DT->verifyDomTree();

  // TODO: Assert isLCSSAForm?
  // Code Grabbed from isLCSSAForm, enforce for now. Remove once
  // stable, and possibly assert isLCSSAForm in DEBUG()
  for (auto *BB : SLVLoop->getBlocks()) {
    for (BasicBlock::iterator I = BB->begin(), E = BB->end(); I != E;++I)
      for (Use &U : I->uses()) {
        Instruction *UI = cast<Instruction>(U.getUser());
        BasicBlock *UserBB = UI->getParent();
        if (PHINode *P = dyn_cast<PHINode>(UI))
          UserBB = P->getIncomingBlock(U);

        // Check the current block, as a fast-path, before checking whether
        // the use is anywhere in the loop.  Most values are used in the same
        // block they are defined in.  Also, blocks not reachable from the
        // entry are special; uses in them don't need to go through PHIs.
        if (UserBB != BB &&
            !SLVLoop->contains(UserBB) &&
            DT->isReachableFromEntry(UserBB))
          assert(0);
      }
  }
}

////////////////////////////////////////////////////////////////////////////////
// SearchLoopsVectorize
////////////////////////////////////////////////////////////////////////////////

/// The SearchLoopVectorize Pass.
struct SearchLoopVectorize : public FunctionPass {
  /// Pass identification, replacement for typeid
  static char ID;

  // TODO: Decide what to do with unrolling. Disabling completely for now, since
  // the normal vectorizer should have performed any unroll-only optimizations.
  explicit SearchLoopVectorize(bool NoUnrolling = false, bool AlwaysVectorize = true)
    : FunctionPass(ID),
      DisableUnrolling(true),
      AlwaysVectorize(AlwaysVectorize) {
    initializeSearchLoopVectorizePass(*PassRegistry::getPassRegistry());
  }

  ScalarEvolution *SE;
  LoopInfo *LI;
  TargetTransformInfo *TTI;
  DominatorTree *DT;
  PostDominatorTree *PDT;
  BlockFrequencyInfo *BFI;
  TargetLibraryInfo *TLI;
  DemandedBits *DB;
  AliasAnalysis *AA;
  AssumptionCache *AC;
  LoopAccessAnalysis *LAA;
  LoopVectorizationAnalysis *LVA;
  bool DisableUnrolling;
  bool AlwaysVectorize;

  BlockFrequency ColdEntryFreq;

  bool runOnFunction(Function &F) override {
    SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
    LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
    TTI = &getAnalysis<TargetTransformInfoWrapperPass>().getTTI(F);
    DT  = &getAnalysis<DominatorTreeWrapperPass>().getDomTree();
    PDT = &getAnalysis<PostDominatorTreeWrapperPass>().getPostDomTree();
    BFI = &getAnalysis<BlockFrequencyInfoWrapperPass>().getBFI();
    auto *TLIP = getAnalysisIfAvailable<TargetLibraryInfoWrapperPass>();
    TLI = TLIP ? &TLIP->getTLI() : nullptr;
    AA = &getAnalysis<AAResultsWrapperPass>().getAAResults();
    AC = &getAnalysis<AssumptionCacheTracker>().getAssumptionCache(F);
    LAA = &getAnalysis<LoopAccessAnalysis>();
    LVA = &getAnalysis<LoopVectorizationAnalysis>();
    DB = &getAnalysis<DemandedBitsWrapperPass>().getDemandedBits();

    // Compute some weights outside of the loop over the loops. Compute this
    // using a BranchProbability to re-use its scaling math.
    const BranchProbability ColdProb(1, 5); // 20%
    ColdEntryFreq = BlockFrequency(BFI->getEntryFreq()) * ColdProb;

    // TODO: Check for predication features or abandon.
    // Don't attempt if
    // 1. the target claims to have no vector registers, and
    // 2. interleaving won't help ILP.
    //
    // The second condition is necessary because, even if the target has no
    // vector registers, loop vectorization may still enable scalar
    // interleaving.
    if (!TTI->getNumberOfRegisters(true) && TTI->getMaxInterleaveFactor(1) < 2)
      return false;

    assert((FuncsWhiteList.empty() || FuncsBlackList.empty()) &&
           "Can't have both a whitelist and blacklist active simultaneously");

    // Bail out if we've manually specified we shouldn't vectorize loops in
    // this function... won't help with inlined functions directly.
    if (std::find(FuncsBlackList.begin(),
                  FuncsBlackList.end(), F.getName()) != FuncsBlackList.end())
      return false;

    if ((!FuncsWhiteList.empty()) &&
        (std::find(FuncsWhiteList.begin(),
                   FuncsWhiteList.end(), F.getName()) == FuncsWhiteList.end()))
      return false;

    DEBUG(dbgs() << "SLV: Running on function '"<< F.getName() << "'\n");

    // Build up a worklist of inner-loops to vectorize. This is necessary as
    // the act of vectorizing or partially unrolling a loop creates new loops
    // and can invalidate iterators across the loops.
    SmallVector<Loop *, 8> Worklist;

    for (Loop *L : *LI)
      addInnerLoop(*L, Worklist);

    SearchLoopsAnalyzed += Worklist.size();

    // Now walk the identified inner loops.

    // TODO: Get a list of vectorizable loops from LVA, only tranform them.
    bool Changed = false;
    while (!Worklist.empty())
      Changed |= processLoop(Worklist.pop_back_val());

    //    if (Changed)
    //      F.dump();

    // TODO: Remove this once stable, just enforce via unit tests
    verifyFunction(F);

    // Process each loop nest in the function.
    return Changed;
  }

  static void AddRuntimeUnrollDisableMetaData(Loop *L) {
    SmallVector<Metadata *, 4> MDs;
    // Reserve first location for self reference to the LoopID metadata node.
    MDs.push_back(nullptr);
    bool IsUnrollMetadata = false;
    MDNode *LoopID = L->getLoopID();
    if (LoopID) {
      // First find existing loop unrolling disable metadata.
      for (unsigned i = 1, ie = LoopID->getNumOperands(); i < ie; ++i) {
        MDNode *MD = dyn_cast<MDNode>(LoopID->getOperand(i));
        if (MD) {
          const MDString *S = dyn_cast<MDString>(MD->getOperand(0));
          IsUnrollMetadata =
              S && S->getString().startswith("llvm.loop.unroll.disable");
        }
        MDs.push_back(LoopID->getOperand(i));
      }
    }

    if (!IsUnrollMetadata) {
      // Add runtime unroll disable metadata.
      LLVMContext &Context = L->getHeader()->getContext();
      SmallVector<Metadata *, 1> DisableOperands;
      DisableOperands.push_back(
          MDString::get(Context, "llvm.loop.unroll.runtime.disable"));
      MDNode *DisableNode = MDNode::get(Context, DisableOperands);
      MDs.push_back(DisableNode);
      MDNode *NewLoopID = MDNode::get(Context, MDs);
      // Set operand 0 to refer to the loop id itself.
      NewLoopID->replaceOperandWith(0, NewLoopID);
      L->setLoopID(NewLoopID);
    }
  }

  bool processLoop(Loop *L) {
    assert(L->empty() && "Only process inner loops.");

#ifndef NDEBUG
    const std::string DebugLocStr = getDebugLocString(L);
#endif /* NDEBUG */

    DEBUG(dbgs() << "\nSLV: Checking a loop in \""
                 << L->getHeader()->getParent()->getName() << "\" from "
                 << DebugLocStr << "\n");
    DEBUG(dbgs() << "SLV: HeaderBBName: " << L->getHeader()->getName() << "\n");

    LoopVectorizeHints Hints(L, DisableUnrolling);

    DEBUG(dbgs() << "SLV: Loop hints:"
                 << " force="
                 << (Hints.getForce() == LoopVectorizeHints::FK_Disabled
                         ? "disabled"
                         : (Hints.getForce() == LoopVectorizeHints::FK_Enabled
                                ? "enabled"
                                : "?")) << " width=" << Hints.getWidth()
                 << " unroll=" << Hints.getInterleave() << "\n");

    // Function containing loop
    Function *F = L->getHeader()->getParent();

    // Looking at the diagnostic output is the only way to determine if a loop
    // was vectorized (other than looking at the IR or machine code), so it
    // is important to generate an optimization remark for each loop. Most of
    // these messages are generated by emitOptimizationRemarkAnalysis. Remarks
    // generated by emitOptimizationRemark and emitOptimizationRemarkMissed are
    // less verbose reporting vectorized loops and unvectorized loops that may
    // benefit from vectorization, respectively.

    if (!Hints.allowVectorization(F, L, AlwaysVectorize)) {
      DEBUG(dbgs() << "SLV: Loop hints prevent vectorization.\n");
      return false;
    }

    // Check the loop for a trip count threshold:
    // do not vectorize loops with a tiny trip count.
    const unsigned TC = SE->getSmallConstantTripCount(L);
    if (TC > 0u && TC < TinyTripCountVectorThreshold) {
      DEBUG(dbgs() << "SLV: Found a loop with a very small trip count. "
                   << "This loop is not worth vectorizing.");
      if (Hints.getForce() == LoopVectorizeHints::FK_Enabled)
        DEBUG(dbgs() << " But vectorizing was explicitly forced.\n");
      else {
        DEBUG(dbgs() << "\n");
        emitAnalysisDiag(F, L, Hints, VectorizationReport()
                                          << "vectorization is not beneficial "
                                             "and is not explicitly forced");
        return false;
      }
    }

    PredicatedScalarEvolution PSE(*SE, *L);

    // Check if it is legal to vectorize the loop.
    LoopVectorizationRequirements Requirements;
    LoopVectorizationLegality LVL(L, PSE, DT, LI, PDT, TLI, AA, F, TTI, LAA,
                                  &Requirements, &Hints);

    if (!LVL.canVectorize()) {
      DEBUG(dbgs() << "SLV: Not vectorizing: Cannot prove legality.\n");
      emitMissedWarning(F, L, Hints);
      return false;
    }

    // Use the cost model.
    LoopVectorizationCostModel CM(L, PSE, LI, &LVL, *TTI, TLI, DB, AC, F,
                                  &Hints);
    CM.collectValuesToIgnore();

    // Check the function attributes to find out if this function should be
    // optimized for size.
    bool OptForSize = Hints.getForce() != LoopVectorizeHints::FK_Enabled &&
                      F->optForSize();

    // Compute the weighted frequency of this loop being executed and see if it
    // is less than 20% of the function entry baseline frequency. Note that we
    // always have a canonical loop here because we think we *can* vectorize.
    // FIXME: This is hidden behind a flag due to pervasive problems with
    // exactly what block frequency models.
    if (LoopVectorizeWithBlockFrequency) {
      BlockFrequency LoopEntryFreq = BFI->getBlockFreq(L->getLoopPreheader());
      if (Hints.getForce() != LoopVectorizeHints::FK_Enabled &&
          LoopEntryFreq < ColdEntryFreq)
        OptForSize = true;
    }

    // Check the function attributes to see if implicit floats are allowed.
    // FIXME: This check doesn't seem possibly correct -- what if the loop is
    // an integer loop and the vector instructions selected are purely integer
    // vector instructions?
    if (F->hasFnAttribute(Attribute::NoImplicitFloat)) {
      DEBUG(dbgs() << "SLV: Can't vectorize when the NoImplicitFloat"
            "attribute is used.\n");
      emitAnalysisDiag(
          F, L, Hints,
          VectorizationReport()
              << "loop not vectorized due to NoImplicitFloat attribute");
      emitMissedWarning(F, L, Hints);
      return false;
    }

    // Select the optimal vectorization factor.
    const VectorizationFactor VF = CM.selectVectorizationFactor(OptForSize);

    // Select the interleave count.
    unsigned IC = CM.selectInterleaveCount(OptForSize, VF, VF.Cost);

    // Get user interleave count.
    unsigned UserIC = Hints.getInterleave();

    // Identify the diagnostic messages that should be produced.
    std::string VecDiagMsg, IntDiagMsg;
    bool VectorizeLoop = true, InterleaveLoop = true;

    if (Requirements.doesNotMeet(F, L, Hints)) {
      DEBUG(dbgs() << "SLV: Not vectorizing: loop did not meet vectorization "
                      "requirements.\n");
      emitMissedWarning(F, L, Hints);
      return false;
    }

    if (VF.Width == 1) {
      DEBUG(dbgs() << "SLV: Vectorization is possible but not beneficial.\n");
      VecDiagMsg =
          "the cost-model indicates that vectorization is not beneficial";
      VectorizeLoop = false;
    }

    if (IC == 1 && UserIC <= 1) {
      // Tell the user interleaving is not beneficial.
      DEBUG(dbgs() << "SLV: Interleaving is not beneficial.\n");
      IntDiagMsg =
          "the cost-model indicates that interleaving is not beneficial";
      InterleaveLoop = false;
      if (UserIC == 1)
        IntDiagMsg +=
            " and is explicitly disabled or interleave count is set to 1";
    } else if (IC > 1 && UserIC == 1) {
      // Tell the user interleaving is beneficial, but it explicitly disabled.
      DEBUG(dbgs()
            << "SLV: Interleaving is beneficial but is explicitly disabled.");
      IntDiagMsg = "the cost-model indicates that interleaving is beneficial "
                   "but is explicitly disabled or interleave count is set to 1";
      InterleaveLoop = false;
    }

    if (!VectorizeLoop && InterleaveLoop && LVL.hasMaskedOperations()) {
      DEBUG(dbgs()
            << "SLV: Interleaving is beneficial but loop contain masked access");
      IntDiagMsg = "interleaving not possible because of masked accesses";
      InterleaveLoop = false;
    }

    // Override IC if user provided an interleave count.
    IC = UserIC > 0 ? UserIC : IC;

    // Emit diagnostic messages, if any.
    const char *VAPassName = Hints.vectorizeAnalysisPassName();
    if (!VectorizeLoop && !InterleaveLoop) {
      // Do not vectorize or interleaving the loop.
      emitOptimizationRemarkAnalysis(F->getContext(), VAPassName, *F,
                                     L->getStartLoc(), VecDiagMsg);
      emitOptimizationRemarkAnalysis(F->getContext(), SLV_NAME, *F,
                                     L->getStartLoc(), IntDiagMsg);
      return false;
    } else if (!VectorizeLoop && InterleaveLoop) {
      DEBUG(dbgs() << "SLV: Interleave Count is " << IC << '\n');
      emitOptimizationRemarkAnalysis(F->getContext(), VAPassName, *F,
                                     L->getStartLoc(), VecDiagMsg);
    } else if (VectorizeLoop && !InterleaveLoop) {
      DEBUG(dbgs() << "SLV: Found a vectorizable loop (" << VF.Width << ") in "
                   << DebugLocStr << '\n');
      emitOptimizationRemarkAnalysis(F->getContext(), SLV_NAME, *F,
                                     L->getStartLoc(), IntDiagMsg);
    } else if (VectorizeLoop && InterleaveLoop) {
      DEBUG(dbgs() << "SLV: Found a vectorizable loop (" << VF.Width << ") in "
                   << DebugLocStr << '\n');
      DEBUG(dbgs() << "SLV: Interleave Count is " << IC << '\n');
    }

    // Should never get here unless we're vectorizing, unroll-only is in
    // 'normal' loop vectorizer.
    assert(VectorizeLoop);

    // If we decided that it is *legal* to vectorize the loop then do it.
    InnerLoopVectorizer LB(L, PSE, LI, DT, TLI, TTI, AC, VF.Width, 1, VF.isFixed);
    LB.vectorize(&LVL, &CM, CM.MinBWs);
    ++SearchLoopsVectorized;

    // Add metadata to disable runtime unrolling scalar loop when there's no
    // runtime check about strides and memory. Because at this situation,
    // scalar loop is rarely used not worthy to be unrolled.
    // TODO: FF/NF/Predicates?
    if (!LB.IsSafetyChecksAdded())
      AddRuntimeUnrollDisableMetaData(L);

    // Report the vectorization decision.
    emitOptimizationRemark(F->getContext(), SLV_NAME, *F, L->getStartLoc(),
                           Twine("vectorized loop in function: ") +
                           F->getName() + Twine(" (vectorization width: ") +
                           Twine(VF.Width) + ", interleaved count: " +
                           Twine(IC) + ")");

    // Mark the loop as already vectorized to avoid vectorizing again.
    Hints.setAlreadyVectorized();

    DEBUG(verifyFunction(*L->getHeader()->getParent()));
    return true;
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<AssumptionCacheTracker>();
    AU.addRequiredID(LoopSimplifyID);
    AU.addRequiredID(LCSSAID);
    AU.addRequired<BlockFrequencyInfoWrapperPass>();
    AU.addRequired<DominatorTreeWrapperPass>();
    AU.addRequired<PostDominatorTreeWrapperPass>();
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<TargetTransformInfoWrapperPass>();
    AU.addRequired<AAResultsWrapperPass>();
    AU.addRequired<LoopAccessAnalysis>();
    AU.addRequired<LoopVectorizationAnalysis>();
    AU.addRequired<DemandedBitsWrapperPass>();
    AU.addPreserved<LoopInfoWrapperPass>();
    AU.addPreserved<DominatorTreeWrapperPass>();
    AU.addPreserved<BasicAAWrapperPass>();
    AU.addPreserved<AAResultsWrapperPass>();
    AU.addPreserved<GlobalsAAWrapperPass>();
  }

};

} // end anonymous namespace

char SearchLoopVectorize::ID = 0;
static const char slv_name[] = "Search Loop Vectorization";
INITIALIZE_PASS_BEGIN(SearchLoopVectorize, SLV_NAME, slv_name, false, false)
INITIALIZE_PASS_DEPENDENCY(TargetTransformInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(BasicAAWrapperPass)
INITIALIZE_PASS_DEPENDENCY(AAResultsWrapperPass)
INITIALIZE_PASS_DEPENDENCY(GlobalsAAWrapperPass)
INITIALIZE_PASS_DEPENDENCY(AssumptionCacheTracker)
INITIALIZE_PASS_DEPENDENCY(BlockFrequencyInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(DominatorTreeWrapperPass)
INITIALIZE_PASS_DEPENDENCY(PostDominatorTreeWrapperPass)
INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LCSSA)
INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopSimplify)
INITIALIZE_PASS_DEPENDENCY(LoopAccessAnalysis)
INITIALIZE_PASS_DEPENDENCY(LoopVectorizationAnalysis)
INITIALIZE_PASS_DEPENDENCY(DemandedBitsWrapperPass)
INITIALIZE_PASS_END(SearchLoopVectorize, SLV_NAME, slv_name, false, false)

namespace llvm {
  Pass *createSearchLoopVectorizePass(bool NoUnrolling, bool AlwaysVectorize) {
    return new SearchLoopVectorize(NoUnrolling, AlwaysVectorize);
  }
}
