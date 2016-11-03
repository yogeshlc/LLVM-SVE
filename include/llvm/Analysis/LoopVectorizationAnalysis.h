//===- llvm/Analysis/LoopVectorizationAnalysis.h ----------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines the interface to determine whether or not a loop can
// be safely vectorized
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_ANALYSIS_LOOPVECTORIZATIONANALYSIS_H
#define LLVM_ANALYSIS_LOOPVECTORIZATIONANALYSIS_H

// TODO: Can we remove some of these and move more functions to the .cpp file?
#include "llvm/ADT/MapVector.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Analysis/CodeMetrics.h"
#include "llvm/Analysis/LoopAccessAnalysis.h"
#include "llvm/Analysis/LoopIterator.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/Pass.h"
//#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/LoopUtils.h"

namespace llvm {

class Value;
class DataLayout;
class ScalarEvolution;
class Loop;
class SCEV;

/// Information about vectorization costs
struct VectorizationFactor {
  unsigned Width; // Vector width with best cost
  unsigned Cost; // Cost of the loop with that width
  bool isFixed; // Is the width an absolute value or a scale.
};

/// Type of exit
enum LoopExitKind {
  EK_Unknown,                ///< Basic case for lookups of unmapped exits
  EK_None,                   ///< Block does not exit loop.
  EK_Counted,                ///< Loop exit with defined trip count (comparison
                             ///   between induction and a loop-invariant value)
  EK_LoadCompare             ///< Loop exit due to a comparison between a
                             ///   loaded value and a loop-invariant value
};

// Forward declarations
class LoopVectorizationLegality;
class LoopVectorizationCostModel;
class LoopVectorizationRequirements;
class LoopVectorizeHints;


class AssumptionCache;
struct DemandedBits;
class InductionDescriptor;
class LoopAccessReport;
class RecurrenceDescriptor;
class TargetLibraryInfo;
class TargetTransformInfo;

  // TODO: Move.
/// Maximum vectorization interleave count.
static const unsigned MaxInterleaveFactor = 16;


/// Helpers. TODO: Move? non-staticize?
/// A helper function for converting Scalar types to vector types.
/// If the incoming type is void, we return void. If the VF is 1, we return
/// the scalar type.
inline Type* ToVectorTy(Type *Scalar, unsigned VF) {
  if (Scalar->isVoidTy() || VF == 1)
    return Scalar;
  return VectorType::get(Scalar, VF);
}
inline Type* ToVectorTy(Type *Scalar, VectorizationFactor VF) {
  if (Scalar->isVoidTy() || VF.Width == 1)
    return Scalar;
  return VectorType::get(Scalar, VF.Width, !VF.isFixed);
}

inline Type *smallestIntegerVectorType(Type *T1, Type *T2) {
  IntegerType *I1 = cast<IntegerType>(T1->getVectorElementType());
  IntegerType *I2 = cast<IntegerType>(T2->getVectorElementType());
  return I1->getBitWidth() < I2->getBitWidth() ? T1 : T2;
}
inline Type *largestIntegerVectorType(Type *T1, Type *T2) {
  IntegerType *I1 = cast<IntegerType>(T1->getVectorElementType());
  IntegerType *I2 = cast<IntegerType>(T2->getVectorElementType());
  return I1->getBitWidth() > I2->getBitWidth() ? T1 : T2;
}

/// A helper function that returns GEP instruction and knows to skip a
/// 'bitcast'. The 'bitcast' may be skipped if the source and the destination
/// pointee types of the 'bitcast' have the same size.
/// For example:
///   bitcast double** %var to i64* - can be skipped
///   bitcast double** %var to i8*  - can not
static GetElementPtrInst *getGEPInstruction(Value *Ptr) {

  if (isa<GetElementPtrInst>(Ptr))
    return cast<GetElementPtrInst>(Ptr);

  if (isa<BitCastInst>(Ptr) &&
      isa<GetElementPtrInst>(cast<BitCastInst>(Ptr)->getOperand(0))) {
    Type *BitcastTy = Ptr->getType();
    Type *GEPTy = cast<BitCastInst>(Ptr)->getSrcTy();
    if (!isa<PointerType>(BitcastTy) || !isa<PointerType>(GEPTy))
      return nullptr;
    Type *Pointee1Ty = cast<PointerType>(BitcastTy)->getPointerElementType();
    Type *Pointee2Ty = cast<PointerType>(GEPTy)->getPointerElementType();
    const DataLayout &DL = cast<BitCastInst>(Ptr)->getModule()->getDataLayout();
    if (DL.getTypeSizeInBits(Pointee1Ty) == DL.getTypeSizeInBits(Pointee2Ty))
      return cast<GetElementPtrInst>(cast<BitCastInst>(Ptr)->getOperand(0));
  }
  return nullptr;
}



/// \brief This modifies LoopAccessReport to initialize message with
/// loop-vectorizer-specific part.
class VectorizationReport : public LoopAccessReport {
public:
  VectorizationReport(Instruction *I = nullptr)
      : LoopAccessReport("loop not vectorized: ", I) {}

  /// \brief This allows promotion of the loop-access analysis report into the
  /// loop-vectorizer report.  It modifies the message to add the
  /// loop-vectorizer-specific part of the message.
  explicit VectorizationReport(const LoopAccessReport &R)
      : LoopAccessReport(Twine("loop not vectorized: ") + R.str(),
                         R.getInstr()) {}
};

/// LoopVectorizationCostModel - estimates the expected speedups due to
/// vectorization.
/// In many cases vectorization is not profitable. This can happen because of
/// a number of reasons. In this class we mainly attempt to predict the
/// expected speedup/slowdowns due to the supported instruction set. We use the
/// TargetTransformInfo to query the different backends for the cost of
/// different operations.
class LoopVectorizationCostModel {
public:
  LoopVectorizationCostModel(Loop *L, PredicatedScalarEvolution &PSE,
                             LoopInfo *LI, LoopVectorizationLegality *Legal,
                             const TargetTransformInfo &TTI,
                             const TargetLibraryInfo *TLI, DemandedBits *DB,
                             AssumptionCache *AC, const Function *F,
                             const LoopVectorizeHints *Hints)
      : TheLoop(L), PSE(PSE), LI(LI), Legal(Legal), TTI(TTI), TLI(TLI), DB(DB),
        AC(AC), TheFunction(F), Hints(Hints) {}

  /// \return The most profitable vectorization factor and the cost of that VF.
  /// This method checks every power of two up to VF. If UserVF is not ZERO
  /// then this vectorization factor will be selected if vectorization is
  /// possible.
  VectorizationFactor selectVectorizationFactor(bool OptForSize);

  /// \return The size (in bits) of the smallest and widest types in the code
  /// that needs to be vectorized. We ignore values that remain scalar such as
  /// 64 bit loop indices.
  std::pair<unsigned, unsigned> getSmallestAndWidestTypes();

  /// \return The desired interleave count.
  /// If interleave count has been specified by metadata it will be returned.
  /// Otherwise, the interleave count is computed and returned. VF and LoopCost
  /// are the selected vectorization factor and the cost of the selected VF.
  unsigned selectInterleaveCount(bool OptForSize, VectorizationFactor VF,
                                 unsigned LoopCost);

  /// \return The most profitable unroll factor.
  /// This method finds the best unroll-factor based on register pressure and
  /// other parameters. VF and LoopCost are the selected vectorization factor
  /// and the cost of the selected VF.
  unsigned computeInterleaveCount(bool OptForSize, VectorizationFactor VF,
                                  unsigned LoopCost);

  /// \brief A struct that represents some properties of the register usage
  /// of a loop.
  struct RegisterUsage {
    /// Holds the number of loop invariant values that are used in the loop.
    unsigned LoopInvariantRegs;
    /// Holds the maximum number of concurrent live intervals in the loop.
    unsigned MaxLocalUsers;
    /// Holds the number of instructions in the loop.
    unsigned NumInstructions;
  };

  /// \return Returns information about the register usages of the loop for the
  /// given vectorization factors.
  SmallVector<RegisterUsage, 8>
  calculateRegisterUsage(const SmallVector<unsigned, 8> &VFs);

  /// Estimate the overhead of scalarizing a value. Insert and Extract are set
  /// if the result needs to be inserted and/or extracted from vectors.
  unsigned getScalarizationOverhead(Type *Ty, bool Insert, bool Extract,
                                    const TargetTransformInfo &TTI);

  // Estimate cost of a call instruction CI if it were vectorized with factor VF.
  // Return the cost of the instruction, including scalarization overhead if it's
  // needed. The flag NeedToScalarize shows if the call needs to be scalarized -
  // i.e. either vector version isn't available, or is too expensive.
  unsigned getVectorCallCost(CallInst *CI, unsigned VF,
                             const TargetTransformInfo &TTI,
                             const TargetLibraryInfo *TLI,
                             bool &NeedToScalarize);

  // Estimate cost of an intrinsic call instruction CI if it were vectorized with
  // factor VF.  Return the cost of the instruction, including scalarization
  // overhead if it's needed.
  unsigned getVectorIntrinsicCost(CallInst *CI, unsigned VF,
                                  const TargetTransformInfo &TTI,
                                  const TargetLibraryInfo *TLI);

  /// Collect values we want to ignore in the cost model.
  void collectValuesToIgnore();

private:
  /// Returns the expected execution cost. The unit of the cost does
  /// not matter because we use the 'cost' units to compare different
  /// vector widths. The cost that is returned is *not* normalized by
  /// the factor width.
  unsigned expectedCost(VectorizationFactor VF);

  /// Returns the execution time cost of an instruction for a given vector
  /// width. Vector width of one means scalar.
  unsigned getInstructionCost(Instruction *I, VectorizationFactor VF);

  /// Returns whether the instruction is a load or store and will be a emitted
  /// as a vector operation.
  bool isConsecutiveLoadOrStore(Instruction *I);

  /// Report an analysis message to assist the user in diagnosing loops that are
  /// not vectorized.  These are handled as LoopAccessReport rather than
  /// VectorizationReport because the << operator of VectorizationReport returns
  /// LoopAccessReport.
  void emitAnalysis(const LoopAccessReport &Message) const;

public:
  /// Map of scalar integer values to the smallest bitwidth they can be legally
  /// represented as. The vector equivalents of these values should be truncated
  /// to this type.
  MapVector<Instruction *, uint64_t> MinBWs;

  /// The loop that we evaluate.
  Loop *TheLoop;
  /// Scev analysis.
  PredicatedScalarEvolution &PSE;
  /// Loop Info analysis.
  LoopInfo *LI;
  /// Vectorization legality.
  LoopVectorizationLegality *Legal;
  /// Vector target information.
  const TargetTransformInfo &TTI;
  /// Target Library Info.
  const TargetLibraryInfo *TLI;
  /// Demanded bits analysis.
  DemandedBits *DB;
  /// Assumption cache.
  AssumptionCache *AC;
  const Function *TheFunction;
  /// Loop Vectorize Hint.
  const LoopVectorizeHints *Hints;
  /// Values to ignore in the cost model.
  SmallPtrSet<const Value *, 16> ValuesToIgnore;
  /// Values to ignore in the cost model when VF > 1.
  SmallPtrSet<const Value *, 16> VecValuesToIgnore;
};

/// Utility class for getting and setting loop vectorizer hints in the form
/// of loop metadata.
/// This class keeps a number of loop annotations locally (as member variables)
/// and can, upon request, write them back as metadata on the loop. It will
/// initially scan the loop for existing metadata, and will update the local
/// values based on information in the loop.
/// We cannot write all values to metadata, as the mere presence of some info,
/// for example 'force', means a decision has been made. So, we need to be
/// careful NOT to add them if the user hasn't specifically asked so.
class LoopVectorizeHints {
  enum HintKind {
    HK_WIDTH,
    HK_UNROLL,
    HK_FORCE
  };

  /// Hint - associates name and validation with the hint value.
  struct Hint {
    const char * Name;
    unsigned Value; // This may have to change for non-numeric values.
    HintKind Kind;

    Hint(const char * Name, unsigned Value, HintKind Kind)
      : Name(Name), Value(Value), Kind(Kind) { }

    bool validate(unsigned Val) {
      switch (Kind) {
      case HK_WIDTH:
        return isPowerOf2_32(Val) && Val <= VectorizerParams::MaxVectorWidth;
      case HK_UNROLL:
        return isPowerOf2_32(Val) && Val <= MaxInterleaveFactor;
      case HK_FORCE:
        return (Val <= 1);
      }
      return false;
    }
  };

  /// Vectorization width.
  Hint Width;
  /// Vectorization interleave factor.
  Hint Interleave;
  /// Vectorization forced
  Hint Force;

  /// Return the loop metadata prefix.
  static StringRef Prefix() { return "llvm.loop."; }

public:
  enum ForceKind {
    FK_Undefined = -1, ///< Not selected.
    FK_Disabled = 0,   ///< Forcing disabled.
    FK_Enabled = 1,    ///< Forcing enabled.
  };

  LoopVectorizeHints(const Loop *L, bool DisableInterleaving);

  /// Mark the loop L as already vectorized by setting the width to 1.
  void setAlreadyVectorized() {
    Width.Value = Interleave.Value = 1;
    Hint Hints[] = {Width, Interleave};
    writeHintsToMetadata(Hints);
  }

  bool allowVectorization(Function *F, Loop *L, bool AlwaysVectorize) const;

  /// Dumps all the hint information.
  std::string emitRemark() const {
    VectorizationReport R;
    if (Force.Value == LoopVectorizeHints::FK_Disabled)
      R << "vectorization is explicitly disabled";
    else {
      R << "use -Rpass-analysis=loop-vectorize for more info";
      if (Force.Value == LoopVectorizeHints::FK_Enabled) {
        R << " (Force=true";
        if (Width.Value != 0)
          R << ", Vector Width=" << Width.Value;
        if (Interleave.Value != 0)
          R << ", Interleave Count=" << Interleave.Value;
        R << ")";
      }
    }

    return R.str();
  }

  unsigned getWidth() const { return Width.Value; }
  unsigned getInterleave() const { return Interleave.Value; }
  enum ForceKind getForce() const { return (ForceKind)Force.Value; }
  const char *vectorizeAnalysisPassName() const;

  bool allowReordering() const {
    // When enabling loop hints are provided we allow the vectorizer to change
    // the order of operations that is given by the scalar loop. This is not
    // enabled by default because can be unsafe or inefficient. For example,
    // reordering floating-point operations will change the way round-off
    // error accumulates in the loop.
    return getForce() == LoopVectorizeHints::FK_Enabled || getWidth() > 1;
  }

private:
  /// Find hints specified in the loop metadata and update local values.
  void getHintsFromMetadata();

  /// Checks string hint with one operand and set value if valid.
  void setHint(StringRef Name, Metadata *Arg);

  /// Create a new hint from name / value pair.
  MDNode *createHintMetadata(StringRef Name, unsigned V) const;

  /// Matches metadata with hint name.
  bool matchesHintMetadataName(MDNode *Node, ArrayRef<Hint> HintTypes);

  /// Sets current hints into loop metadata, keeping other values intact.
  void writeHintsToMetadata(ArrayRef<Hint> HintTypes);

  /// The loop these hints belong to.
  const Loop *TheLoop;
};

  // TODO: Move this.
static void emitAnalysisDiag(const Function *TheFunction, const Loop *TheLoop,
                             const LoopVectorizeHints &Hints,
                             const LoopAccessReport &Message) {
  const char *Name = Hints.vectorizeAnalysisPassName();
  LoopAccessReport::emitAnalysis(Message, TheFunction, TheLoop, Name);
}

/// \brief This holds vectorization requirements that must be verified late in
/// the process. The requirements are set by legalize and costmodel. Once
/// vectorization has been determined to be possible and profitable the
/// requirements can be verified by looking for metadata or compiler options.
/// For example, some loops require FP commutativity which is only allowed if
/// vectorization is explicitly specified or if the fast-math compiler option
/// has been provided.
/// Late evaluation of these requirements allows helpful diagnostics to be
/// composed that tells the user what need to be done to vectorize the loop. For
/// example, by specifying #pragma clang loop vectorize or -ffast-math. Late
/// evaluation should be used only when diagnostics can generated that can be
/// followed by a non-expert user.
class LoopVectorizationRequirements {
public:
  LoopVectorizationRequirements()
      : NumRuntimePointerChecks(0), UnsafeAlgebraInst(nullptr) {}

  void addUnsafeAlgebraInst(Instruction *I) {
    // First unsafe algebra instruction.
    if (!UnsafeAlgebraInst)
      UnsafeAlgebraInst = I;
  }

  void addRuntimePointerChecks(unsigned Num) { NumRuntimePointerChecks = Num; }

  bool doesNotMeet(Function *F, Loop *L, const LoopVectorizeHints &Hints);

private:
  unsigned NumRuntimePointerChecks;
  Instruction *UnsafeAlgebraInst;
};

/// \brief The group of interleaved loads/stores sharing the same stride and
/// close to each other.
///
/// Each member in this group has an index starting from 0, and the largest
/// index should be less than interleaved factor, which is equal to the absolute
/// value of the access's stride.
///
/// E.g. An interleaved load group of factor 4:
///        for (unsigned i = 0; i < 1024; i+=4) {
///          a = A[i];                           // Member of index 0
///          b = A[i+1];                         // Member of index 1
///          d = A[i+3];                         // Member of index 3
///          ...
///        }
///
///      An interleaved store group of factor 4:
///        for (unsigned i = 0; i < 1024; i+=4) {
///          ...
///          A[i]   = a;                         // Member of index 0
///          A[i+1] = b;                         // Member of index 1
///          A[i+2] = c;                         // Member of index 2
///          A[i+3] = d;                         // Member of index 3
///        }
///
/// Note: the interleaved load group could have gaps (missing members), but
/// the interleaved store group doesn't allow gaps.
class InterleaveGroup {
public:
  InterleaveGroup(Instruction *Instr, int Stride, unsigned Align)
      : Align(Align), SmallestKey(0), LargestKey(0), InsertPos(Instr) {
    assert(Align && "The alignment should be non-zero");

    Factor = std::abs(Stride);
    assert(Factor > 1 && "Invalid interleave factor");

    Reverse = Stride < 0;
    Members[0] = Instr;
  }

  bool isReverse() const { return Reverse; }
  unsigned getFactor() const { return Factor; }
  unsigned getAlignment() const { return Align; }
  unsigned getNumMembers() const { return Members.size(); }

  /// \brief Try to insert a new member \p Instr with index \p Index and
  /// alignment \p NewAlign. The index is related to the leader and it could be
  /// negative if it is the new leader.
  ///
  /// \returns false if the instruction doesn't belong to the group.
  bool insertMember(Instruction *Instr, int Index, unsigned NewAlign) {
    assert(NewAlign && "The new member's alignment should be non-zero");

    int Key = Index + SmallestKey;

    // Skip if there is already a member with the same index.
    if (Members.count(Key))
      return false;

    if (Key > LargestKey) {
      // The largest index is always less than the interleave factor.
      if (Index >= static_cast<int>(Factor))
        return false;

      LargestKey = Key;
    } else if (Key < SmallestKey) {
      // The largest index is always less than the interleave factor.
      if (LargestKey - Key >= static_cast<int>(Factor))
        return false;

      SmallestKey = Key;
    }

    // It's always safe to select the minimum alignment.
    Align = std::min(Align, NewAlign);
    Members[Key] = Instr;
    return true;
  }

  /// \brief Get the member with the given index \p Index
  ///
  /// \returns nullptr if contains no such member.
  Instruction *getMember(unsigned Index) const {
    int Key = SmallestKey + Index;
    if (!Members.count(Key))
      return nullptr;

    return Members.find(Key)->second;
  }

  /// \brief Get the index for the given member. Unlike the key in the member
  /// map, the index starts from 0.
  unsigned getIndex(Instruction *Instr) const {
    for (auto I : Members)
      if (I.second == Instr)
        return I.first - SmallestKey;

    llvm_unreachable("InterleaveGroup contains no such member");
  }

  Instruction *getInsertPos() const { return InsertPos; }
  void setInsertPos(Instruction *Inst) { InsertPos = Inst; }

private:
  unsigned Factor; // Interleave Factor.
  bool Reverse;
  unsigned Align;
  DenseMap<int, Instruction *> Members;
  int SmallestKey;
  int LargestKey;

  // To avoid breaking dependences, vectorized instructions of an interleave
  // group should be inserted at either the first load or the last store in
  // program order.
  //
  // E.g. %even = load i32             // Insert Position
  //      %add = add i32 %even         // Use of %even
  //      %odd = load i32
  //
  //      store i32 %even
  //      %odd = add i32               // Def of %odd
  //      store i32 %odd               // Insert Position
  Instruction *InsertPos;
};

/// \brief Drive the analysis of interleaved memory accesses in the loop.
///
/// Use this class to analyze interleaved accesses only when we can vectorize
/// a loop. Otherwise it's meaningless to do analysis as the vectorization
/// on interleaved accesses is unsafe.
///
/// The analysis collects interleave groups and records the relationships
/// between the member and the group in a map.
class InterleavedAccessInfo {
public:
  InterleavedAccessInfo(PredicatedScalarEvolution &PSE, Loop *L,
                        DominatorTree *DT)
      : PSE(PSE), TheLoop(L), DT(DT) {}

  ~InterleavedAccessInfo() {
    SmallSet<InterleaveGroup *, 4> DelSet;
    // Avoid releasing a pointer twice.
    for (auto &I : InterleaveGroupMap)
      DelSet.insert(I.second);
    for (auto *Ptr : DelSet)
      delete Ptr;
  }

  /// \brief Analyze the interleaved accesses and collect them in interleave
  /// groups. Substitute symbolic strides using \p Strides.
  void analyzeInterleaving(const ValueToValueMap &Strides);

  /// \brief Check if \p Instr belongs to any interleave group.
  bool isInterleaved(Instruction *Instr) const {
    return InterleaveGroupMap.count(Instr);
  }

  /// \brief Get the interleave group that \p Instr belongs to.
  ///
  /// \returns nullptr if doesn't have such group.
  InterleaveGroup *getInterleaveGroup(Instruction *Instr) const {
    if (InterleaveGroupMap.count(Instr))
      return InterleaveGroupMap.find(Instr)->second;
    return nullptr;
  }

private:
  /// A wrapper around ScalarEvolution, used to add runtime SCEV checks.
  /// Simplifies SCEV expressions in the context of existing SCEV assumptions.
  /// The interleaved access analysis can also add new predicates (for example
  /// by versioning strides of pointers).
  PredicatedScalarEvolution &PSE;
  Loop *TheLoop;
  DominatorTree *DT;

  /// Holds the relationships between the members and the interleave group.
  DenseMap<Instruction *, InterleaveGroup *> InterleaveGroupMap;

  /// \brief The descriptor for a strided memory access.
  struct StrideDescriptor {
    StrideDescriptor(int Stride, const SCEV *Scev, unsigned Size,
                     unsigned Align)
        : Stride(Stride), Scev(Scev), Size(Size), Align(Align) {}

    StrideDescriptor() : Stride(0), Scev(nullptr), Size(0), Align(0) {}

    int Stride; // The access's stride. It is negative for a reverse access.
    const SCEV *Scev; // The scalar expression of this access
    unsigned Size;    // The size of the memory object.
    unsigned Align;   // The alignment of this access.
  };

  /// \brief Create a new interleave group with the given instruction \p Instr,
  /// stride \p Stride and alignment \p Align.
  ///
  /// \returns the newly created interleave group.
  InterleaveGroup *createInterleaveGroup(Instruction *Instr, int Stride,
                                         unsigned Align) {
    assert(!InterleaveGroupMap.count(Instr) &&
           "Already in an interleaved access group");
    InterleaveGroupMap[Instr] = new InterleaveGroup(Instr, Stride, Align);
    return InterleaveGroupMap[Instr];
  }

  /// \brief Release the group and remove all the relationships.
  void releaseGroup(InterleaveGroup *Group) {
    for (unsigned i = 0; i < Group->getFactor(); i++)
      if (Instruction *Member = Group->getMember(i))
        InterleaveGroupMap.erase(Member);

    delete Group;
  }

  /// \brief Collect all the accesses with a constant stride in program order.
  void collectConstStridedAccesses(
      MapVector<Instruction *, StrideDescriptor> &StrideAccesses,
      const ValueToValueMap &Strides);
};

/// A class to describe an 'Escapee', which has either a single Escapee Merge
/// node, or alternatively a single Store Node. An Escapee can only be
/// constructed by the EscapeeFactory class, which collects the set of
/// Escapees in the loop.
class Escapee {
protected:
  Escapee() {}

  template<typename ItTy>
  Escapee(Instruction *M, ItTy S, ItTy E, bool IsReduction = false) :
                                    Merge(M), IsReduction(IsReduction) {
    assert((isa<PHINode>(M) || isa<StoreInst>(M)) && 
           "MergeNode must be a PHI or Store");
    for (ItTy I = S; I != E; ++I)
      Values.push_back(*I);
  }

public:
  StoreInst *getStore() const {
    return Store;
  }

  void setStore(StoreInst *S) {
    Store = S;
  }

  Instruction* getMergeNode() const {
    return Merge;
  }

  iterator_range<SmallVectorImpl<Value*>::iterator> getValues() {
    return make_range(Values.begin(), Values.end());
  }

  Value *getValue(unsigned Idx) {
    return Values[Idx];
  }

  unsigned getNumValues() {
    return Values.size();
  }

  bool contains(const Value *V) {
    return std::find(Values.begin(), Values.end(), V) != Values.end();
  }

  bool isReduction() { return IsReduction; }

  bool isReductionValue(const Value *V) { return IsReduction && contains(V); }

private:
  Instruction* Merge;
  StoreInst* Store;
  SmallVector<Value*,5> Values;

protected:
  bool IsReduction;

  // Needed to set IsReduction of an Escapee object
  // from within EscapeeFactory::CreateEscapee().
  friend class EscapeeFactory;
};

class EscapeeFactory : public Escapee {
private:
  typedef std::tuple<BasicBlock*, Value*> MergeValTuple;
  // Convenience method to get a list of values from an escapee merge node
  void getEscapeeValuesFromMergeNode(PHINode *MergeNode,
                    SmallVectorImpl<MergeValTuple> &Values);

public:
  // Constructor
  EscapeeFactory(LoopBlocksDFS *DFS, PostDominatorTree *PDT) : 
      DFS(DFS), PDT(PDT) {}

  // Manually add escapees
  Escapee* CreateEscapee(PHINode *Recurrence, RecurrenceDescriptor &RD);
  Escapee* CreateEscapee(PHINode *MergeNode);

  iterator_range<MapVector<Instruction*,Escapee*>::iterator> getEscapees() {
    return make_range(Escapees.begin(), Escapees.end());
  }

  bool hasEscapees() { return Escapees.size() > 0; }

  // If returns true, Res is filled with the corresponding escapee.
  bool canVectorizeEscapeeValue(Instruction *Val, Escapee *&Res);

private:
  // Escapee cache with quick lookup by merge node.
  MapVector<Instruction*, Escapee*> Escapees;
  // DFS is needed to sort incoming edges
  LoopBlocksDFS *DFS;
  // PDT is needed to check position of the merge node.
  PostDominatorTree *PDT;
};

/// LoopVectorizationLegality checks if it is legal to vectorize a loop, and
/// to what vectorization factor.
/// This class does not look at the profitability of vectorization, only the
/// legality. This class has two main kinds of checks:
/// * Memory checks - The code in canVectorizeMemory checks if vectorization
///   will change the order of memory accesses in a way that will change the
///   correctness of the program.
/// * Scalars checks - The code in canVectorizeInstrs and canVectorizeMemory
/// checks for a number of different conditions, such as the availability of a
/// single induction variable, that all types are supported and vectorize-able,
/// etc. This code reflects the capabilities of InnerLoopVectorizer.
/// This class is also used by InnerLoopVectorizer for identifying
/// induction variable and the different reduction variables.
class LoopVectorizationLegality {
public:
  LoopVectorizationLegality(Loop *L, PredicatedScalarEvolution &PSE,
                            DominatorTree *DT, LoopInfo *LI,
                            PostDominatorTree *PDT,
                            TargetLibraryInfo *TLI,
                            AliasAnalysis *AA, Function *F,
                            const TargetTransformInfo *TTI,
                            LoopAccessAnalysis *LAA,
                            LoopVectorizationRequirements *R,
                            const LoopVectorizeHints *H)
      : NumPredStores(0), TheLoop(L), PSE(PSE), TLI(TLI), TheFunction(F),
        TTI(TTI), DT(DT), LI(LI), PDT(PDT), AA(AA), LAA(LAA), LAI(nullptr),
        InterleaveInfo(PSE, L, DT), Induction(nullptr),
        WidestIndTy(nullptr), HasFunNoNaNAttr(false), Requirements(R),
        Hints(H), ScalarizedReduction(false),
        AllowUncounted(true), IsUncounted(false) {
    DFS = new LoopBlocksDFS(TheLoop);
    DFS->perform(LI);
    EF = new EscapeeFactory(DFS, PDT);
  }
  // TODO       AllowUncounted(EnableUncountedLoops), IsUncounted(false) {}

  /// Returns true if the function has an attribute saying that
  /// we can assume the absence of NaNs.
  bool hasNoNaNAttr(void) const { return HasFunNoNaNAttr; }

  /// ReductionList contains the reduction descriptors for all
  /// of the reductions that were found in the loop.
  typedef DenseMap<PHINode *, RecurrenceDescriptor> ReductionList;

  /// InductionList saves induction variables and maps them to the
  /// induction descriptor.
  typedef MapVector<PHINode*, InductionDescriptor> InductionList;

  typedef SmallVector<Value*, 8> ConditionExprs;

  // foobar
  struct LoopExit {
    LoopExit()
      : Kind(EK_Unknown), ExitingBlock(nullptr), ExitBlock(nullptr) {}
    LoopExit(LoopExitKind Kind, BasicBlock *Exiting, BasicBlock *Exit)
      : Kind(Kind), ExitingBlock(Exiting), ExitBlock(Exit) {}
    LoopExit(LoopExitKind Kind, BasicBlock *Exiting, BasicBlock *Exit,
             ConditionExprs &SubExprs)
      : Kind(Kind), ExitingBlock(Exiting), ExitBlock(Exit) {
      Nodes.insert(Nodes.begin(), SubExprs.begin(), SubExprs.end());
    }

    LoopExitKind Kind;
    BasicBlock *ExitingBlock;
    BasicBlock *ExitBlock;
    ConditionExprs Nodes;
  };

  /// Mapping of all exits to a known type
  /// TODO: May need more info later.
  typedef SmallVector<LoopExit, 2> ExitList;

  /// Returns true if it is legal to vectorize this loop.
  /// This does not mean that it is profitable to vectorize this
  /// loop, only that it is legal to do so.
  bool canVectorize();

  /// Returns the Induction variable.
  PHINode *getInduction() { return Induction; }

  /// Returns the reduction variables found in the loop.
  ReductionList *getReductionVars() { return &Reductions; }

  /// Returns the induction variables found in the loop.
  InductionList *getInductionVars() { return &Inductions; }

  // Returns the EscapeeFactory
  EscapeeFactory *getEF() { return EF; }

  /// Return all known exits with their type
  /// TODO: Remove this in favour of the range func below?
  ExitList *getLoopExits() { return &Exits; }

  // TODO: Should this be part of loopinfo?
  iterator_range<LoopExit*> exits() {
    return make_range(Exits.begin(), Exits.end());
  }

  LoopExitKind getBlockExitKind(BasicBlock *BB) {
    for (auto &LE : Exits)
      if (LE.ExitingBlock == BB)
        return LE.Kind;

    // If we didn't find the block in the known exits,
    // then it isn't an exiting block.
    return EK_None;
  }

  /// Returns the widest induction type.
  Type *getWidestInductionType() { return WidestIndTy; }

  /// Returns True if V is an induction variable in this loop.
  bool isInductionVariable(const Value *V);

  /// Return true if the block BB needs to be predicated in order for the loop
  /// to be vectorized.
  bool blockNeedsPredication(BasicBlock *BB);

  /// Check if this  pointer is consecutive when vectorizing. This happens
  /// when the last index of the GEP is the induction variable, or that the
  /// pointer itself is an induction variable.
  /// This check allows us to vectorize A[idx] into a wide load/store.
  /// Returns:
  /// 0 - Stride is unknown or non-consecutive.
  /// 1 - Address is consecutive.
  /// -1 - Address is consecutive, and decreasing.
  int isConsecutivePtr(Value *Ptr);

  /// Returns true if the value V is uniform within the loop.
  bool isUniform(Value *V);

  /// Returns true if this instruction will remain scalar after vectorization.
  bool isUniformAfterVectorization(Instruction* I) { return Uniforms.count(I); }

  /// Returns the information that we collected about runtime memory check.
  const RuntimePointerChecking *getRuntimePointerChecking() const {
    return LAI->getRuntimePointerChecking();
  }

  const LoopAccessInfo *getLAI() const {
    return LAI;
  }

  /// \brief Check if \p Instr belongs to any interleaved access group.
  bool isAccessInterleaved(Instruction *Instr) {
    return InterleaveInfo.isInterleaved(Instr);
  }

  /// \brief Get the interleaved access group that \p Instr belongs to.
  const InterleaveGroup *getInterleavedAccessGroup(Instruction *Instr) {
    return InterleaveInfo.getInterleaveGroup(Instr);
  }

  unsigned getMaxSafeDepDistBytes() { return LAI->getMaxSafeDepDistBytes(); }

  bool hasStride(Value *V) { return StrideSet.count(V); }
  bool mustCheckStrides() { return !StrideSet.empty(); }
  SmallPtrSet<Value *, 8>::iterator strides_begin() {
    return StrideSet.begin();
  }
  SmallPtrSet<Value *, 8>::iterator strides_end() { return StrideSet.end(); }

  /// Returns true if the target machine supports masked store operation
  /// for the given \p DataType and kind of access to \p Ptr.
  bool isLegalMaskedStore(Type *DataType, Value *Ptr);

  /// Returns true if the target machine supports masked load operation
  /// for the given \p DataType and kind of access to \p Ptr.
  bool isLegalMaskedLoad(Type *DataType, Value *Ptr);

  /// Returns true if vector representation of the instruction \p I
  /// requires mask.
  bool isMaskRequired(const Instruction* I) {
    return (MaskedOp.count(I) != 0);
  }
  /// Returns true if the loop requires masked operations for vectorisation to
  /// be legal.
  bool hasMaskedOperations() {
    return MaskedOp.begin() != MaskedOp.end();
  }
  unsigned getNumStores() const {
    return LAI->getNumStores();
  }
  unsigned getNumLoads() const {
    return LAI->getNumLoads();
  }
  unsigned getNumPredStores() const {
    return NumPredStores;
  }

  /// Returns true if reductions exist that the target cannot perform directly.
  bool hasScalarizedReduction() const {
    return !Reductions.empty() && ScalarizedReduction;
  }

  bool isUncountedLoop() const {
    return IsUncounted;
  }

private:
  /// Check if a single basic block loop is vectorizable.
  /// At this point we know that this is a loop with a constant trip count
  /// and we only need to check individual instructions.
  bool canVectorizeInstrs();

  /// When we vectorize loops we may change the order in which
  /// we read and write from memory. This method checks if it is
  /// legal to vectorize the code, considering only memory constrains.
  /// Returns true if the loop is vectorizable
  bool canVectorizeMemory();

  /// Return true if we can vectorize this loop using the IF-conversion
  /// transformation.
  bool canVectorizeWithIfConvert();

  /// Collect the variables that need to stay uniform after vectorization.
  void collectLoopUniforms();

  /// Return true if all of the instructions in the block can be speculatively
  /// executed. \p SafePtrs is a list of addresses that are known to be legal
  /// and we know that we can read from them without segfault.
  bool blockCanBePredicated(BasicBlock *BB, SmallPtrSetImpl<Value *> &SafePtrs);

  /// Returns true if a loop variable within a loop that has an outside user can
  /// be safely vectorized and the appropriate terminating value extracted
  bool canVectorizeEscapee(Instruction *Esc);

  bool findConditionSubExprs(Value *V, ConditionExprs &SubExprs);
  bool findConditionSubExprsRecurse(Value *V, ConditionExprs &SubExprs);

  /// Returns true if all possible exits from the loop can be used to form a
  /// combined exit in the vectorized loop latch, with destructive operations
  /// controlled with predication during the loop
  bool canVectorizeExits();

  /// \brief Collect memory access with loop invariant strides.
  ///
  /// Looks for accesses like "a[i * StrideA]" where "StrideA" is loop
  /// invariant.
  void collectStridedAccess(Value *LoadOrStoreInst);

  /// Report an analysis message to assist the user in diagnosing loops that are
  /// not vectorized.  These are handled as LoopAccessReport rather than
  /// VectorizationReport because the << operator of VectorizationReport returns
  /// LoopAccessReport.
  void emitAnalysis(const LoopAccessReport &Message) const {
    emitAnalysisDiag(TheFunction, TheLoop, *Hints, Message);
  }

  unsigned NumPredStores;

  /// The loop that we evaluate.
  Loop *TheLoop;
  /// A wrapper around ScalarEvolution used to add runtime SCEV checks.
  /// Applies dynamic knowledge to simplify SCEV expressions in the context
  /// of existing SCEV assumptions. The analysis will also add a minimal set
  /// of new predicates if this is required to enable vectorization and
  /// unrolling.
  PredicatedScalarEvolution &PSE;
  /// Target Library Info.
  TargetLibraryInfo *TLI;
  /// Parent function
  Function *TheFunction;
  /// Target Transform Info
  const TargetTransformInfo *TTI;
  /// Dominator Tree.
  DominatorTree *DT;
  /// Loop Info
  LoopInfo *LI;
  /// PostDominator Tree.
  PostDominatorTree *PDT;
  // Depth first order graph of loop
  LoopBlocksDFS *DFS;
  // Alias analysis
  AliasAnalysis *AA;
  // LoopAccess analysis.
  LoopAccessAnalysis *LAA;
  // And the loop-accesses info corresponding to this loop.  This pointer is
  // null until canVectorizeMemory sets it up.
  const LoopAccessInfo *LAI;

  /// The interleave access information contains groups of interleaved accesses
  /// with the same stride and close to each other.
  InterleavedAccessInfo InterleaveInfo;

  //  ---  vectorization state --- //

  /// Holds the integer induction variable. This is the counter of the
  /// loop.
  PHINode *Induction;
  /// Holds the reduction variables.
  ReductionList Reductions;
  /// Holds all of the induction variables that we found in the loop.
  /// Notice that inductions don't need to start at zero and that induction
  /// variables can be pointers.
  InductionList Inductions;
  /// Holds and creates all Escapees
  EscapeeFactory *EF;
  /// Holds a mapping of all loop exits discovered and their type
  ExitList Exits;
  /// Holds the widest induction type encountered.
  Type *WidestIndTy;

  /// Allowed outside users. This holds the reduction
  /// vars which can be accessed from outside the loop.
  SmallPtrSet<Value*, 4> AllowedExit;
  /// This set holds the variables which are known to be uniform after
  /// vectorization.
  SmallPtrSet<Instruction*, 4> Uniforms;

  /// Can we assume the absence of NaNs.
  bool HasFunNoNaNAttr;

  /// Vectorization requirements that will go through late-evaluation.
  LoopVectorizationRequirements *Requirements;

  /// Used to emit an analysis of any legality issues.
  const LoopVectorizeHints *Hints;

  ValueToValueMap Strides;
  SmallPtrSet<Value *, 8> StrideSet;

  /// While vectorizing these instructions we have to generate a
  /// call to the appropriate masked intrinsic
  SmallPtrSet<const Instruction*, 8> MaskedOp;

  /// Does any in-vector reduction require scalarization?
  bool ScalarizedReduction;

  /// If enabled, we will vectorize (some) loops which do not have
  /// a defined trip count that SCEV can determine.
  bool AllowUncounted;

  /// If set, the current loop is uncounted
  bool IsUncounted;
};

class LoopVectorizationAnalysis : public FunctionPass {
public:
  static char ID;

  LoopVectorizationAnalysis() : FunctionPass(ID) {
    initializeLoopVectorizationAnalysisPass(*PassRegistry::getPassRegistry());
  }

  bool runOnFunction(Function &F) override;
  void getAnalysisUsage(AnalysisUsage &AU) const override;

  // TODO: cache, interface
};
} // End llvm namespace

#endif
