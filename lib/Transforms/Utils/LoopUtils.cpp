//===-- LoopUtils.cpp - Loop Utility functions -------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines common loop utility functions.
//
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/BasicAliasAnalysis.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/GlobalsModRef.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpander.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/ScalarEvolutionAliasAnalysis.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/ValueHandle.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/Utils/LoopUtils.h"

using namespace llvm;
using namespace llvm::PatternMatch;

#define DEBUG_TYPE "loop-utils"

static const char* RecurrenceNames[] = {
  "RK_NoReduction",
  "RK_IntegerAdd",
  "RK_IntegerMult",
  "RK_IntegerOr",
  "RK_IntegerAnd",
  "RK_IntegerXor",
  "RK_IntegerMinMax",
  "RK_FloatAdd",
  "RK_FloatMult",
  "RK_FloatMinMax"
};

bool RecurrenceDescriptor::areAllUsesIn(Instruction *I,
                                        SmallPtrSetImpl<Instruction *> &Set) {
  for (User::op_iterator Use = I->op_begin(), E = I->op_end(); Use != E; ++Use)
    if (!Set.count(dyn_cast<Instruction>(*Use)))
      return false;
  return true;
}

bool RecurrenceDescriptor::isIntegerRecurrenceKind(RecurrenceKind Kind) {
  switch (Kind) {
  default:
    break;
  case RK_IntegerAdd:
  case RK_IntegerMult:
  case RK_IntegerOr:
  case RK_IntegerAnd:
  case RK_IntegerXor:
  case RK_IntegerMinMax:
    return true;
  }
  return false;
}

bool RecurrenceDescriptor::isFloatingPointRecurrenceKind(RecurrenceKind Kind) {
  return (Kind != RK_NoRecurrence) && !isIntegerRecurrenceKind(Kind);
}

bool RecurrenceDescriptor::isArithmeticRecurrenceKind(RecurrenceKind Kind) {
  switch (Kind) {
  default:
    break;
  case RK_IntegerAdd:
  case RK_IntegerMult:
  case RK_FloatAdd:
  case RK_FloatMult:
    return true;
  }
  return false;
}

Instruction *
RecurrenceDescriptor::lookThroughAnd(PHINode *Phi, Type *&RT,
                                     SmallPtrSetImpl<Instruction *> &Visited,
                                     SmallPtrSetImpl<Instruction *> &CI) {
  if (!Phi->hasOneUse())
    return Phi;

  const APInt *M = nullptr;
  Instruction *I, *J = cast<Instruction>(Phi->use_begin()->getUser());

  // Matches either I & 2^x-1 or 2^x-1 & I. If we find a match, we update RT
  // with a new integer type of the corresponding bit width.
  if (match(J, m_CombineOr(m_And(m_Instruction(I), m_APInt(M)),
                           m_And(m_APInt(M), m_Instruction(I))))) {
    int32_t Bits = (*M + 1).exactLogBase2();
    if (Bits > 0) {
      RT = IntegerType::get(Phi->getContext(), Bits);
      Visited.insert(Phi);
      CI.insert(J);
      return J;
    }
  }
  return Phi;
}

bool RecurrenceDescriptor::getSourceExtensionKind(
    Instruction *Start, Instruction *Exit, Type *RT, bool &IsSigned,
    SmallPtrSetImpl<Instruction *> &Visited,
    SmallPtrSetImpl<Instruction *> &CI) {

  SmallVector<Instruction *, 8> Worklist;
  bool FoundOneOperand = false;
  unsigned DstSize = RT->getPrimitiveSizeInBits();
  Worklist.push_back(Exit);

  // Traverse the instructions in the reduction expression, beginning with the
  // exit value.
  while (!Worklist.empty()) {
    Instruction *I = Worklist.pop_back_val();
    for (Use &U : I->operands()) {

      // Terminate the traversal if the operand is not an instruction, or we
      // reach the starting value.
      Instruction *J = dyn_cast<Instruction>(U.get());
      if (!J || J == Start)
        continue;

      // Otherwise, investigate the operation if it is also in the expression.
      if (Visited.count(J)) {
        Worklist.push_back(J);
        continue;
      }

      // If the operand is not in Visited, it is not a reduction operation, but
      // it does feed into one. Make sure it is either a single-use sign- or
      // zero-extend instruction.
      CastInst *Cast = dyn_cast<CastInst>(J);
      bool IsSExtInst = isa<SExtInst>(J);
      if (!Cast || !Cast->hasOneUse() || !(isa<ZExtInst>(J) || IsSExtInst))
        return false;

      // Ensure the source type of the extend is no larger than the reduction
      // type. It is not necessary for the types to be identical.
      unsigned SrcSize = Cast->getSrcTy()->getPrimitiveSizeInBits();
      if (SrcSize > DstSize)
        return false;

      // Furthermore, ensure that all such extends are of the same kind.
      if (FoundOneOperand) {
        if (IsSigned != IsSExtInst)
          return false;
      } else {
        FoundOneOperand = true;
        IsSigned = IsSExtInst;
      }

      // Lastly, if the source type of the extend matches the reduction type,
      // add the extend to CI so that we can avoid accounting for it in the
      // cost model.
      if (SrcSize == DstSize)
        CI.insert(Cast);
    }
  }
  return true;
}

// Check if a given Phi node can be recognized as an ordered reduction for
// vectorizing floating point operations without unsafe math.
static bool
checkOrderedReduction(RecurrenceDescriptor::RecurrenceKind Kind,
                      RecurrenceDescriptor::ExitInstrList &ExitInstructions,
                      PHINode *Phi) {
  // Currently only 'fadd' is supported.
  if (Kind != RecurrenceDescriptor::RK_FloatAdd)
    return false;

  if (ExitInstructions.size() != 1)
    return false;

  auto EI = ExitInstructions[0];
  bool IsOrdered = EI->getOpcode() == Instruction::FAdd &&
                  !EI->hasUnsafeAlgebra();

  // If this comes from a PHI node, look through it
  if (auto EIP = dyn_cast<PHINode>(EI)) {
    if (EIP->getNumIncomingValues() != 2)
      return false;

    auto ChainVal = EIP->getIncomingValue(0) == Phi
                        ? EIP->getIncomingValue(1)
                        : EIP->getIncomingValue(0);

    if (!isa<Instruction>(ChainVal))
      return false;

    EI = cast<Instruction>(ChainVal);
    IsOrdered = EI->getOpcode() == Instruction::FAdd &&
                !EI->hasUnsafeAlgebra();
  }

  // The only pattern accepted is the one in which the reduction PHI is used
  // as one of the operands of the exit istruction.
  auto LHS = EI->getOperand(0);
  auto RHS = EI->getOperand(1);
  IsOrdered = IsOrdered && ((LHS == Phi) || (RHS == Phi));

  if (!IsOrdered)
    return false;

  DEBUG(dbgs() << "LU: Found an ordered reduction: Phi: "
        << *Phi << ", ExitInst: " << *EI << "\n");

  return true;
}

bool RecurrenceDescriptor::AddReductionVar(PHINode *Phi, RecurrenceKind Kind,
                                           Loop *TheLoop, bool HasFunNoNaNAttr,
                                           ScalarEvolution *SE,
                                           RecurrenceDescriptor &RedDes,
                                           bool AllowMultipleExits) {
  if (Phi->getNumIncomingValues() != 2)
    return false;

  // Reduction variables are only found in the loop header block.
  if (Phi->getParent() != TheLoop->getHeader())
    return false;

  // Obtain the reduction start value from the value that comes from the loop
  // preheader.
  Value *RdxStart = Phi->getIncomingValueForBlock(TheLoop->getLoopPreheader());

  // ExitInstruction is the single value which is used outside the loop.
  // We only allow for a single reduction value to be used outside the loop.
  // This includes users of the reduction, variables (which form a cycle
  // which ends in the phi node).
  ExitInstrList ExitInstructions;
  StoreInst* IntermediateStore = nullptr;
  // Indicates that we found a reduction operation in our scan.
  bool FoundReduxOp = false;

  // We start with the PHI node and scan for all of the users of this
  // instruction. All users must be instructions that can be used as reduction
  // variables (such as ADD). We must have a single out-of-block user. The cycle
  // must include the original PHI.
  bool FoundStartPHI = false;

  // To recognize min/max patterns formed by a icmp select sequence, we store
  // the number of instruction we saw from the recognized min/max pattern,
  //  to make sure we only see exactly the two instructions.
  unsigned NumCmpSelectPatternInst = 0;
  InstDesc ReduxDesc(false, nullptr);

  // Data used for determining if the recurrence has been type-promoted.
  Type *RecurrenceType = Phi->getType();
  SmallPtrSet<Instruction *, 4> CastInsts;
  Instruction *Start = Phi;
  bool IsSigned = false;

  SmallPtrSet<Instruction *, 8> VisitedInsts;
  SmallVector<Instruction *, 8> Worklist;

  // Return early if the recurrence kind does not match the type of Phi. If the
  // recurrence kind is arithmetic, we attempt to look through AND operations
  // resulting from the type promotion performed by InstCombine.  Vector
  // operations are not limited to the legal integer widths, so we may be able
  // to evaluate the reduction in the narrower width.
  if (RecurrenceType->isFloatingPointTy()) {
    if (!isFloatingPointRecurrenceKind(Kind))
      return false;
  } else {
    if (!isIntegerRecurrenceKind(Kind))
      return false;
    if (isArithmeticRecurrenceKind(Kind))
      Start = lookThroughAnd(Phi, RecurrenceType, VisitedInsts, CastInsts);
  }

  Worklist.push_back(Start);
  VisitedInsts.insert(Start);

  // A value in the reduction can be used:
  //  - By the reduction:
  //      - Reduction operation:
  //        - One use of reduction value (safe).
  //        - Multiple use of reduction value (not safe).
  //      - PHI:
  //        - All uses of the PHI must be the reduction (safe).
  //        - Otherwise, not safe.
  //  - By one instruction outside of the loop (safe).
  //  - By further instructions outside of the loop (not safe).
  //  - By an instruction that is not part of the reduction (not safe).
  //    This is either:
  //      * An instruction type other than PHI or the reduction operation.
  //      * A PHI in the header other than the initial PHI.
  while (!Worklist.empty()) {
    Instruction *Cur = Worklist.back();
    Worklist.pop_back();

    // Store instructions are allowed iff it is the store of the reduction
    // value to the same loop uniform memory location.
    if (auto *SI = dyn_cast<StoreInst>(Cur)) {
      const SCEV *PtrScev = SE->getSCEV(SI->getPointerOperand());
      // Check it is the same address as previous stores
      if (IntermediateStore) {
        const SCEV *OtherScev =
            SE->getSCEV(IntermediateStore->getPointerOperand());

        if (OtherScev != PtrScev) {
          DEBUG(dbgs() << "Storing reduction value to different addresses " <<
               "inside the loop: " << *SI->getPointerOperand() << " and " <<
               *IntermediateStore->getPointerOperand() << '\n');
          return false;
        }
      }

      // Check the pointer is loop invariant
      if (!SE->isLoopInvariant(PtrScev, TheLoop)) {
        DEBUG(dbgs() << "Storing reduction value to non-uniform address " <<
              "inside the loop: " << *SI->getPointerOperand() << '\n');
        return false;
      }

      // IntermediateStore is always the last store in the loop.
      IntermediateStore = SI;
      continue;
    }

    // No Users.
    // If the instruction has no users then this is a broken chain and can't be
    // a reduction variable.
    if (Cur->use_empty()) {
      DEBUG(dbgs() << "LU: Instruction has no users: " << *Cur << "\n");
      return false;
    }

    bool IsAPhi = isa<PHINode>(Cur);

    // A header PHI use other than the original PHI.
    if (Cur != Phi && IsAPhi && Cur->getParent() == Phi->getParent()) {
      DEBUG(dbgs() << "LU: loop header phi that isn't the original phi: " <<
            *Cur << "\n");
      return false;
    }

    // Reductions of instructions such as Div, and Sub is only possible if the
    // LHS is the reduction variable.
    if (!Cur->isCommutative() && !IsAPhi && !isa<SelectInst>(Cur) &&
        !isa<ICmpInst>(Cur) && !isa<FCmpInst>(Cur) &&
        !VisitedInsts.count(dyn_cast<Instruction>(Cur->getOperand(0)))) {
      DEBUG(dbgs() << "LU: LHS isn't the reduction var: " << *Cur << "\n");
      return false;
    }

    // Any reduction instruction must be of one of the allowed kinds. We ignore
    // the starting value (the Phi or an AND instruction if the Phi has been
    // type-promoted).
    if (Cur != Start) {
      ReduxDesc = isRecurrenceInstr(Cur, Kind, ReduxDesc, HasFunNoNaNAttr);
      if (!ReduxDesc.isRecurrence()) {
        DEBUG(dbgs() << "LU: Not an allowed instruction: " <<
              *Cur << " for recurrence type " << RecurrenceNames[Kind] << "\n");
        return false;
      }
    }

    // A reduction operation must only have one use of the reduction value.
    if (!IsAPhi && Kind != RK_IntegerMinMax && Kind != RK_FloatMinMax &&
        hasMultipleUsesOf(Cur, VisitedInsts)) {
      DEBUG(dbgs() << "LU: Too many uses of reduction value: " << *Cur << "\n");
      return false;
    }

    // All inputs to a PHI node must be a reduction value.
    if (IsAPhi && Cur != Phi && !areAllUsesIn(Cur, VisitedInsts)) {
      DEBUG(dbgs() << "LU: All input must be a reduction value: " <<
            *Cur << "\n");
      return false;
    }

    if (Kind == RK_IntegerMinMax &&
        (isa<ICmpInst>(Cur) || isa<SelectInst>(Cur)))
      ++NumCmpSelectPatternInst;
    if (Kind == RK_FloatMinMax && (isa<FCmpInst>(Cur) || isa<SelectInst>(Cur)))
      ++NumCmpSelectPatternInst;

    // Check  whether we found a reduction operator.
    FoundReduxOp |= !IsAPhi && Cur != Start;

    // Process users of current instruction. Push non-PHI nodes after PHI nodes
    // onto the stack. This way we are going to have seen all inputs to PHI
    // nodes once we get to them.
    SmallVector<Instruction *, 8> NonPHIs;
    SmallVector<Instruction *, 8> PHIs;
    // We really want exit analysis available to all of these instead of
    // doing it in all the transform passes or utilities.
    //
    // TODO: Exit analysis can come first -- just check that the ptr
    // op for loadcmp is SAR, not necessarily LI_Base+Induction
    // That way we can assume the cast is safe. (or a dedicated
    // pass makes it irrelevant)
    //
    // Simple assumption for now -- EE is not the latch.
    SmallVector<BasicBlock*, 4> ExitingBlocks;
    //    TheLoop->dump();
    TheLoop->getExitingBlocks(ExitingBlocks);
    // Grab expected exit instruction.
    BasicBlock *EEBlock = nullptr;
    for (auto *EB: ExitingBlocks) {
      if (EB != TheLoop->getLoopLatch())
        EEBlock = EB;
    }

    for (User *U : Cur->users()) {
      Instruction *UI = cast<Instruction>(U);

      // Check if we found the exit user.
      BasicBlock *Parent = UI->getParent();
      if (!TheLoop->contains(Parent)) {
        // We want to allow:
        //  %sum = phi(0, ph, %sum.next, loopbody)
        //   :
        //   <conditional loop break>
        //   :
        //  %sum.next = ..
        if (Cur == Phi) {
          if (!AllowMultipleExits) {
            DEBUG(dbgs() << "LU: Use of header phi: " << *Cur << "\n");
            return false;
          }
        }

        // Check if the operand is from an early exit
        if (AllowMultipleExits && EEBlock) {
          // The user should either be an escapee merge block OR a PHI node
          // that is used in a store to the intermediate store address.
          if (isa<PHINode>(UI)) {
            // If it has more than 1 operand, it should be an escapee merge block.
            if (UI->getNumOperands() > 1) {
              // Test that each exit instruction is a PHI operand
              bool Fail = false;
              for(auto *EI : ExitInstructions) {
                // if not represented in PHI, its not OK
                if (std::find(UI->op_begin(), UI->op_end(), EI) == UI->op_end()) {
                  Fail = true;
                  break;
                }
              }
              if (!Fail) {
                ExitInstructions.push_back(Cur);
                continue;
              }
            }
            // Only 1 operand, the PHI should be used in a store (check below)
            UI = dyn_cast<Instruction>(*(UI->user_begin()));
          }

          // This is an exit instruction iff the store is an intermediate store
          if (isa<StoreInst>(UI)) {
            ExitInstructions.push_back(Cur);
            NonPHIs.push_back(UI);
            continue;
          }

          DEBUG(dbgs() << "LU: Early exit value is not an escapee value\n");
          return false;
        }

        // The instruction used by an outside user must be the last instruction
        // before we feed back to the reduction phi. Otherwise, we loose VF-1
        // operations on the value.
        if (!AllowMultipleExits &&
            std::find(Phi->op_begin(), Phi->op_end(), Cur) == Phi->op_end()) {
          DEBUG(dbgs() << "LU: Outside user does not use last instruction in "
                << "reduction chain: " << *Cur << "\n");
          DEBUG(dbgs() << "LU: Phi checked is: " << *Phi << "\n");
          return false;
        }

        ExitInstructions.push_back(Cur);
        continue;
      }

      // Process instructions only once (termination). Each reduction cycle
      // value must only be used once, except by phi nodes and min/max
      // reductions which are represented as a cmp followed by a select.
      InstDesc IgnoredVal(false, nullptr);
      if (VisitedInsts.insert(UI).second) {
        if (isa<PHINode>(UI))
          PHIs.push_back(UI);
        else {
          if (auto *SI = dyn_cast<StoreInst>(UI)) {
            if (SI->getValueOperand() == Cur)
              NonPHIs.push_back(UI);
          } else
          NonPHIs.push_back(UI);
        }
      } else if (!isa<PHINode>(UI) &&
                 ((!isa<FCmpInst>(UI) && !isa<ICmpInst>(UI) &&
                   !isa<SelectInst>(UI)) ||
                  !isMinMaxSelectCmpPattern(UI, IgnoredVal).isRecurrence()))
        return false;

      // Remember that we completed the cycle.
      if (UI == Phi)
        FoundStartPHI = true;
    }
    Worklist.append(PHIs.begin(), PHIs.end());
    Worklist.append(NonPHIs.begin(), NonPHIs.end());
  }

  // This means we have seen one but not the other instruction of the
  // pattern or more than just a select and cmp.
  if ((Kind == RK_IntegerMinMax || Kind == RK_FloatMinMax) &&
      NumCmpSelectPatternInst != 2)
    return false;

  // If there is an intermediate store, it must store the last reduction value.
  if (!ExitInstructions.empty() && IntermediateStore) {
    if (!AllowMultipleExits &&
       IntermediateStore->getValueOperand() != ExitInstructions.back()) {
      DEBUG(dbgs() << "LU: Last store Instruction of reduction value " <<
            "does not store last calculated value of the reduction: " <<
            *IntermediateStore << '\n');
      return false;
    }
  }

  // If all uses are inside the loop (intermediate stores), then the
  // reduction value after the loop will be the one used in the last store.
  if (ExitInstructions.empty() && IntermediateStore) {
    auto *ExitValue =
        cast<Instruction>(IntermediateStore->getValueOperand());
    ExitInstructions.push_back(ExitValue);
  }

  if (!FoundStartPHI || !FoundReduxOp || ExitInstructions.empty()) {
    DEBUG(dbgs() << "LU: Did not find one of: StartPHI: " <<
          FoundStartPHI << ", ReduxOp: " << FoundReduxOp <<
          ", ExitInstruction Count: " << ExitInstructions.size() << "\n");
    return false;
  }

  // If we think Phi may have been type-promoted, we also need to ensure that
  // all source operands of the reduction are either SExtInsts or ZEstInsts. If
  // so, we will be able to evaluate the reduction in the narrower bit width.
  // TODO: Do we need to implement checks for each exit instruction?
  if (Start != Phi)
    if (!getSourceExtensionKind(Start, ExitInstructions.front(), RecurrenceType,
                                IsSigned, VisitedInsts, CastInsts))
      return false;

  // Special handling for ordered reductions
  const bool IsOrdered = checkOrderedReduction(Kind, ExitInstructions, Phi);

  // We found a reduction var if we have reached the original phi node and we
  // only have a single instruction with out-of-loop users.

  // The ExitInstruction(Instruction which is allowed to have out-of-loop users)
  // is saved as part of the RecurrenceDescriptor.

  // Save the description of this reduction variable.
  RecurrenceDescriptor RD(RdxStart, ExitInstructions, IntermediateStore, Kind,
                          ReduxDesc.getMinMaxKind(),
                          ReduxDesc.getUnsafeAlgebraInst(), RecurrenceType,
                          IsSigned, CastInsts, IsOrdered);
  RedDes = RD;

  return true;
}

/// Returns true if the instruction is a Select(ICmp(X, Y), X, Y) instruction
/// pattern corresponding to a min(X, Y) or max(X, Y).
RecurrenceDescriptor::InstDesc
RecurrenceDescriptor::isMinMaxSelectCmpPattern(Instruction *I, InstDesc &Prev) {

  assert((isa<ICmpInst>(I) || isa<FCmpInst>(I) || isa<SelectInst>(I)) &&
         "Expect a select instruction");
  Instruction *Cmp = nullptr;
  SelectInst *Select = nullptr;

  // We must handle the select(cmp()) as a single instruction. Advance to the
  // select.
  if ((Cmp = dyn_cast<ICmpInst>(I)) || (Cmp = dyn_cast<FCmpInst>(I))) {
    if (!Cmp->hasOneUse() || !(Select = dyn_cast<SelectInst>(*I->user_begin())))
      return InstDesc(false, I);
    return InstDesc(Select, Prev.getMinMaxKind());
  }

  // Only handle single use cases for now.
  if (!(Select = dyn_cast<SelectInst>(I)))
    return InstDesc(false, I);
  if (!(Cmp = dyn_cast<ICmpInst>(I->getOperand(0))) &&
      !(Cmp = dyn_cast<FCmpInst>(I->getOperand(0))))
    return InstDesc(false, I);
  if (!Cmp->hasOneUse())
    return InstDesc(false, I);

  Value *CmpLeft;
  Value *CmpRight;

  // Look for a min/max pattern.
  if (m_UMin(m_Value(CmpLeft), m_Value(CmpRight)).match(Select))
    return InstDesc(Select, MRK_UIntMin);
  else if (m_UMax(m_Value(CmpLeft), m_Value(CmpRight)).match(Select))
    return InstDesc(Select, MRK_UIntMax);
  else if (m_SMax(m_Value(CmpLeft), m_Value(CmpRight)).match(Select))
    return InstDesc(Select, MRK_SIntMax);
  else if (m_SMin(m_Value(CmpLeft), m_Value(CmpRight)).match(Select))
    return InstDesc(Select, MRK_SIntMin);
  else if (m_OrdFMin(m_Value(CmpLeft), m_Value(CmpRight)).match(Select))
    return InstDesc(Select, MRK_FloatMin);
  else if (m_OrdFMax(m_Value(CmpLeft), m_Value(CmpRight)).match(Select))
    return InstDesc(Select, MRK_FloatMax);
  else if (m_UnordFMin(m_Value(CmpLeft), m_Value(CmpRight)).match(Select))
    return InstDesc(Select, MRK_FloatMin);
  else if (m_UnordFMax(m_Value(CmpLeft), m_Value(CmpRight)).match(Select))
    return InstDesc(Select, MRK_FloatMax);

  return InstDesc(false, I);
}

RecurrenceDescriptor::InstDesc
RecurrenceDescriptor::isRecurrenceInstr(Instruction *I, RecurrenceKind Kind,
                                        InstDesc &Prev, bool HasFunNoNaNAttr) {
  bool FP = I->getType()->isFloatingPointTy();
  bool FastMath = FP && I->hasUnsafeAlgebra();
  auto Opc = I->getOpcode();

  // Explicitly note lack of fastmath when debugging vectorization
  if (FP && !FastMath && (Opc == Instruction::FMul ||
                          Opc == Instruction::FAdd ||
                          Opc == Instruction::FSub))
    DEBUG(dbgs() <<
          "LU: Warning! Fastmath not set on fp reduction instruction: "
          << *I << "\n");

  Instruction *UAI = Prev.getUnsafeAlgebraInst();
  if (!UAI && FP && !I->hasUnsafeAlgebra())
    UAI = I; // Found an unsafe (unvectorizable) algebra instruction.

  switch (I->getOpcode()) {
  default:
    return InstDesc(false, I);
  case Instruction::PHI:
    return InstDesc(I, Prev.getMinMaxKind(), Prev.getUnsafeAlgebraInst());
  case Instruction::Sub:
  case Instruction::Add:
    return InstDesc(Kind == RK_IntegerAdd, I);
  case Instruction::Mul:
    return InstDesc(Kind == RK_IntegerMult, I);
  case Instruction::And:
    return InstDesc(Kind == RK_IntegerAnd, I);
  case Instruction::Or:
    return InstDesc(Kind == RK_IntegerOr, I);
  case Instruction::Xor:
    return InstDesc(Kind == RK_IntegerXor, I);
  case Instruction::FMul:
    return InstDesc(Kind == RK_FloatMult, I, UAI);
  case Instruction::FSub:
  case Instruction::FAdd:
    return InstDesc(Kind == RK_FloatAdd, I, UAI);
  case Instruction::FCmp:
  case Instruction::ICmp:
  case Instruction::Select:
    if (Kind != RK_IntegerMinMax &&
        (!HasFunNoNaNAttr || Kind != RK_FloatMinMax))
      return InstDesc(false, I);
    return isMinMaxSelectCmpPattern(I, Prev);
  }
}

bool RecurrenceDescriptor::hasMultipleUsesOf(
    Instruction *I, SmallPtrSetImpl<Instruction *> &Insts) {
  unsigned NumUses = 0;
  for (User::op_iterator Use = I->op_begin(), E = I->op_end(); Use != E;
       ++Use) {
    if (Insts.count(dyn_cast<Instruction>(*Use)))
      ++NumUses;
    if (NumUses > 1)
      return true;
  }

  return false;
}

bool RecurrenceDescriptor::isReductionPHI(PHINode *Phi, Loop *TheLoop,
                                          ScalarEvolution *SE,
                                          RecurrenceDescriptor &RedDes,
                                          bool AllowMultipleExits) {

  BasicBlock *Header = TheLoop->getHeader();
  Function &F = *Header->getParent();
  bool HasFunNoNaNAttr =
      F.getFnAttribute("no-nans-fp-math").getValueAsString() == "true";

  if (AddReductionVar(Phi, RK_IntegerAdd, TheLoop, HasFunNoNaNAttr, SE, RedDes,
                      AllowMultipleExits)) {
    DEBUG(dbgs() << "Found an ADD reduction PHI." << *Phi << "\n");
    return true;
  }
  if (AddReductionVar(Phi, RK_IntegerMult, TheLoop, HasFunNoNaNAttr, SE, RedDes,
                      AllowMultipleExits)) {
    DEBUG(dbgs() << "Found a MUL reduction PHI." << *Phi << "\n");
    return true;
  }
  if (AddReductionVar(Phi, RK_IntegerOr, TheLoop, HasFunNoNaNAttr, SE, RedDes,
                      AllowMultipleExits)) {
    DEBUG(dbgs() << "Found an OR reduction PHI." << *Phi << "\n");
    return true;
  }
  if (AddReductionVar(Phi, RK_IntegerAnd, TheLoop, HasFunNoNaNAttr, SE, RedDes,
                      AllowMultipleExits)) {
    DEBUG(dbgs() << "Found an AND reduction PHI." << *Phi << "\n");
    return true;
  }
  if (AddReductionVar(Phi, RK_IntegerXor, TheLoop, HasFunNoNaNAttr, SE, RedDes,
                      AllowMultipleExits)) {
    DEBUG(dbgs() << "Found a XOR reduction PHI." << *Phi << "\n");
    return true;
  }
  if (AddReductionVar(Phi, RK_IntegerMinMax, TheLoop, HasFunNoNaNAttr,
                      SE, RedDes, AllowMultipleExits)) {
    DEBUG(dbgs() << "Found a MINMAX reduction PHI." << *Phi << "\n");
    return true;
  }
  if (AddReductionVar(Phi, RK_FloatMult, TheLoop, HasFunNoNaNAttr, SE, RedDes,
                      AllowMultipleExits)) {
    DEBUG(dbgs() << "Found an FMult reduction PHI." << *Phi << "\n");
    return true;
  }
  if (AddReductionVar(Phi, RK_FloatAdd, TheLoop, HasFunNoNaNAttr, SE, RedDes,
                      AllowMultipleExits)) {
    DEBUG(dbgs() << "Found an FAdd reduction PHI." << *Phi << "\n");
    return true;
  }
  if (AddReductionVar(Phi, RK_FloatMinMax, TheLoop, HasFunNoNaNAttr, SE, RedDes,
                      AllowMultipleExits)) {
    DEBUG(dbgs() << "Found an float MINMAX reduction PHI." << *Phi << "\n");
    return true;
  }
  // Not a reduction of known type.
  DEBUG(dbgs() << "Not a known reduction type: " << *Phi << "\n");
  return false;
}

bool RecurrenceDescriptor::isFirstOrderRecurrence(PHINode *Phi, Loop *TheLoop,
                                                  DominatorTree *DT) {

  // Ensure the phi node is in the loop header and has two incoming values.
  if (Phi->getParent() != TheLoop->getHeader() ||
      Phi->getNumIncomingValues() != 2)
    return false;

  // Ensure the loop has a preheader and a single latch block. The loop
  // vectorizer will need the latch to set up the next iteration of the loop.
  auto *Preheader = TheLoop->getLoopPreheader();
  auto *Latch = TheLoop->getLoopLatch();
  if (!Preheader || !Latch)
    return false;

  // Ensure the phi node's incoming blocks are the loop preheader and latch.
  if (Phi->getBasicBlockIndex(Preheader) < 0 ||
      Phi->getBasicBlockIndex(Latch) < 0)
    return false;

  // Get the previous value. The previous value comes from the latch edge while
  // the initial value comes form the preheader edge.
  auto *Previous = dyn_cast<Instruction>(Phi->getIncomingValueForBlock(Latch));
  if (!Previous || !TheLoop->contains(Previous) || isa<PHINode>(Previous))
    return false;

  // Ensure every user of the phi node is dominated by the previous value. The
  // dominance requirement ensures the loop vectorizer will not need to
  // vectorize the initial value prior to the first iteration of the loop.
  for (User *U : Phi->users())
    if (auto *I = dyn_cast<Instruction>(U))
      if (!DT->dominates(Previous, I))
        return false;

  return true;
}

/// This function returns the identity element (or neutral element) for
/// the operation K.
Constant *RecurrenceDescriptor::getRecurrenceIdentity(RecurrenceKind K,
                                                      Type *Tp) {
  assert(Tp && "Missing type");
  switch (K) {
  case RK_IntegerXor:
  case RK_IntegerAdd:
  case RK_IntegerOr:
    // Adding, Xoring, Oring zero to a number does not change it.
    return ConstantInt::get(Tp, 0);
  case RK_IntegerMult:
    // Multiplying a number by 1 does not change it.
    return ConstantInt::get(Tp, 1);
  case RK_IntegerAnd:
    // AND-ing a number with an all-1 value does not change it.
    return ConstantInt::get(Tp, -1, true);
  case RK_FloatMult:
    // Multiplying a number by 1 does not change it.
    return ConstantFP::get(Tp, 1.0L);
  case RK_FloatAdd:
    // Adding zero to a number does not change it.
    return ConstantFP::get(Tp, 0.0L);
  default:
    llvm_unreachable("Unknown recurrence kind");
  }
}

/// This function translates the recurrence kind to an LLVM binary operator.
unsigned RecurrenceDescriptor::getRecurrenceBinOp(RecurrenceKind Kind) {
  switch (Kind) {
  case RK_IntegerAdd:
    return Instruction::Add;
  case RK_IntegerMult:
    return Instruction::Mul;
  case RK_IntegerOr:
    return Instruction::Or;
  case RK_IntegerAnd:
    return Instruction::And;
  case RK_IntegerXor:
    return Instruction::Xor;
  case RK_FloatMult:
    return Instruction::FMul;
  case RK_FloatAdd:
    return Instruction::FAdd;
  case RK_IntegerMinMax:
    return Instruction::ICmp;
  case RK_FloatMinMax:
    return Instruction::FCmp;
  default:
    llvm_unreachable("Unknown recurrence operation");
  }
}

Value *RecurrenceDescriptor::createMinMaxOp(IRBuilder<> &Builder,
                                            MinMaxRecurrenceKind RK,
                                            Value *Left, Value *Right) {
  CmpInst::Predicate P = CmpInst::ICMP_NE;
  switch (RK) {
  default:
    llvm_unreachable("Unknown min/max recurrence kind");
  case MRK_UIntMin:
    P = CmpInst::ICMP_ULT;
    break;
  case MRK_UIntMax:
    P = CmpInst::ICMP_UGT;
    break;
  case MRK_SIntMin:
    P = CmpInst::ICMP_SLT;
    break;
  case MRK_SIntMax:
    P = CmpInst::ICMP_SGT;
    break;
  case MRK_FloatMin:
    P = CmpInst::FCMP_OLT;
    break;
  case MRK_FloatMax:
    P = CmpInst::FCMP_OGT;
    break;
  }

  // We only match FP sequences with unsafe algebra, so we can unconditionally
  // set it on any generated instructions.
  IRBuilder<>::FastMathFlagGuard FMFG(Builder);
  FastMathFlags FMF;
  FMF.setUnsafeAlgebra();
  Builder.setFastMathFlags(FMF);

  Value *Cmp;
  if (RK == MRK_FloatMin || RK == MRK_FloatMax)
    Cmp = Builder.CreateFCmp(P, Left, Right, "rdx.minmax.cmp");
  else
    Cmp = Builder.CreateICmp(P, Left, Right, "rdx.minmax.cmp");

  Value *Select = Builder.CreateSelect(Cmp, Left, Right, "rdx.minmax.select");
  return Select;
}

InductionDescriptor::InductionDescriptor(Value *Start, InductionKind K,
                                         const SCEV *Step)
  : StartValue(Start), IK(K), Step(Step) {
  assert(IK != IK_NoInduction && "Not an induction");

  // Start value type should match the induction kind and the value
  // itself should not be null.
  assert(StartValue && "StartValue is null");
  assert((IK != IK_PtrInduction || StartValue->getType()->isPointerTy()) &&
         "StartValue is not a pointer for pointer induction");
  assert((IK != IK_IntInduction || StartValue->getType()->isIntegerTy()) &&
         "StartValue is not an integer for integer induction");

  // Check the Step Value. It should be non-zero integer value.
  assert((!getConstIntStepValue() || !getConstIntStepValue()->isZero()) &&
         "Step value is zero");

  assert((IK != IK_PtrInduction || getConstIntStepValue()) &&
         "Step value should be constant for pointer induction");
  assert(Step->getType()->isIntegerTy() && "StepValue is not an integer");
}

InductionDescriptor::InductionDescriptor(Value *Start, InductionKind K,
                                         Value *Step)
  : StartValue(Start), IK(K), StepValue(Step) {
  assert(IK != IK_NoInduction && "Not an induction");

  // Start value type should match the induction kind and the value
  // itself should not be null.
  assert(StartValue && "StartValue is null");

  assert(StepValue && "No valid step given");
  assert((IK != IK_FPInduction || StartValue->getType()->isFloatingPointTy())
         && "StartValue is not a float for float induction");
}

int InductionDescriptor::getConsecutiveDirection() const {
  ConstantInt *ConstStep = getConstIntStepValue();
  if (ConstStep && (ConstStep->isOne() || ConstStep->isMinusOne()))
    return ConstStep->getSExtValue();
  return 0;
}

ConstantInt *InductionDescriptor::getConstIntStepValue() const {
  if (isa<SCEVConstant>(Step))
    return dyn_cast<ConstantInt>(cast<SCEVConstant>(Step)->getValue());
  return nullptr;
}

Value *InductionDescriptor::transform(IRBuilder<> &B, Value *Index,
                                      ScalarEvolution *SE,
                                      const DataLayout& DL) const {

  SCEVExpander Exp(*SE, DL, "induction");
  switch (IK) {
  case IK_IntInduction: {
    assert(Index->getType() == StartValue->getType() &&
           "Index type does not match StartValue type");

    // FIXME: Theoretically, we can call getAddExpr() of ScalarEvolution
    // and calculate (Start + Index * Step) for all cases, without
    // special handling for "isOne" and "isMinusOne".
    // But in the real life the result code getting worse. We mix SCEV
    // expressions and ADD/SUB operations and receive redundant
    // intermediate values being calculated in different ways and
    // Instcombine is unable to reduce them all.

    if (getConstIntStepValue() &&
        getConstIntStepValue()->isMinusOne())
      return B.CreateSub(StartValue, Index);
    if (getConstIntStepValue() &&
        getConstIntStepValue()->isOne())
      return B.CreateAdd(StartValue, Index);
    const SCEV *S = SE->getAddExpr(SE->getSCEV(StartValue),
                                   SE->getMulExpr(Step, SE->getSCEV(Index)));
    return Exp.expandCodeFor(S, StartValue->getType(), &*B.GetInsertPoint());
  }
  case IK_PtrInduction: {
    assert(Index->getType() == Step->getType() &&
           "Index type does not match StepValue type");
    assert(isa<SCEVConstant>(Step) &&
           "Expected constant step for pointer induction");
    const SCEV *S = SE->getMulExpr(SE->getSCEV(Index), Step);
    Index = Exp.expandCodeFor(S, Index->getType(), &*B.GetInsertPoint());
    return B.CreateGEP(nullptr, StartValue, Index);
  }
  case IK_FPInduction: {
    if (!Index->getType()->isFloatingPointTy()) {
      // We need to do some conversion.
      Index = B.CreateUIToFP(Index, StartValue->getType());
    }
    IRBuilder<>::FastMathFlagGuard Guard(B);
    FastMathFlags FMF;
    FMF.setUnsafeAlgebra();
    B.setFastMathFlags(FMF);
    Index = B.CreateFMul(Index, StepValue);
    return B.CreateFAdd(StartValue, Index);
  }
  case IK_NoInduction:
    return nullptr;
  }
  llvm_unreachable("invalid enum");
}

bool InductionDescriptor::isInductionPHI(PHINode *Phi,
                                         PredicatedScalarEvolution &PSE,
                                         InductionDescriptor &D,
                                         bool Assume, Loop *L) {
  Type *PhiTy = Phi->getType();
  // We only handle integer, fp and pointer inductions variables.
  if (!PhiTy->isIntegerTy() && !PhiTy->isFloatTy() &&
      !PhiTy->isDoubleTy() && !PhiTy->isPointerTy())
    return false;

  if (PhiTy->isFloatingPointTy()) {
    if (!L)
      return false; // Need loop info to handle FP.
    // Do a simple check if we have an FP recurrence.
    if (Phi->getNumIncomingValues() != 2)
      return false;

    Value *Start, *Step;
    for (int i = 0, e = Phi->getNumIncomingValues(); i != e; ++i) {
      if (Phi->getIncomingBlock(i) == L->getLoopPreheader())
        Start = Phi->getIncomingValue(i);
      else
        Step = Phi->getIncomingValue(i);
    }
    if (!Start)
      return false;
    // Check that the FP recurrence is a simple fadd. The recurrence must be
    // in the form:
    // %iv = phi [ %start, headerblock ], [ %backedge_val, backedge_block ]
    // %backedge_val = fadd fast %iv, %loop_invariant
    Instruction *AddRecInst = dyn_cast<Instruction>(Step);
    if (!AddRecInst || AddRecInst->getOpcode() != Instruction::FAdd ||
        !AddRecInst->hasUnsafeAlgebra())
      return false;

    Value *StepOp;
    if (AddRecInst->getOperand(0) == Phi) {
      StepOp = AddRecInst->getOperand(1);
    } else if (AddRecInst->getOperand(1) == Phi) {
      StepOp = AddRecInst->getOperand(0);
    } else
      return false;

    if (!L->isLoopInvariant(StepOp))
      return false;
    D = InductionDescriptor(Start, IK_FPInduction, StepOp);
    return true;
  }

  const SCEV *PhiScev = PSE.getSCEV(Phi);
  const auto *AR = dyn_cast<SCEVAddRecExpr>(PhiScev);

  // We need this expression to be an AddRecExpr.
  if (Assume && !AR)
    AR = PSE.getAsAddRec(Phi);

  if (!AR) {
    DEBUG(dbgs() << "LV: PHI is not a poly recurrence.\n");
    return false;
  }

  return isInductionPHI(Phi, PSE.getSE(), D, AR);
}

bool InductionDescriptor::isInductionPHI(PHINode *Phi,
                                         ScalarEvolution *SE,
                                         InductionDescriptor &D,
                                         const SCEV *Expr) {
  Type *PhiTy = Phi->getType();
  // We only handle integer and pointer inductions variables.
  if (!PhiTy->isIntegerTy() && !PhiTy->isPointerTy())
    return false;

  // Check that the PHI is consecutive.
  const SCEV *PhiScev = Expr ? Expr : SE->getSCEV(Phi);
  const SCEVAddRecExpr *AR = dyn_cast<SCEVAddRecExpr>(PhiScev);

  if (!AR) {
    DEBUG(dbgs() << "LU: PHI is not a poly recurrence.\n");
    return false;
  }

  assert(AR->getLoop()->getHeader() == Phi->getParent() &&
         "PHI is an AddRec for a different loop?!");
  Value *StartValue =
    Phi->getIncomingValueForBlock(AR->getLoop()->getLoopPreheader());
  const SCEV *Step = AR->getStepRecurrence(*SE);
  // Calculate the pointer stride and check if it is consecutive.
  // The stride may be a constant or a loop invariant integer value.
  const SCEVConstant *ConstStep = dyn_cast<SCEVConstant>(Step);
  if (!ConstStep && !SE->isLoopInvariant(Step, AR->getLoop()))
    return false;

  if (PhiTy->isIntegerTy()) {
    D = InductionDescriptor(StartValue, IK_IntInduction, Step);
    return true;
  }

  assert(PhiTy->isPointerTy() && "The PHI must be a pointer");
  // Pointer induction should be a constant.
  if (!ConstStep)
    return false;

  ConstantInt *CV = ConstStep->getValue();
  Type *PointerElementType = PhiTy->getPointerElementType();
  // The pointer stride cannot be determined if the pointer element type is not
  // sized.
  if (!PointerElementType->isSized())
    return false;

  const DataLayout &DL = Phi->getModule()->getDataLayout();
  int64_t Size = static_cast<int64_t>(DL.getTypeAllocSize(PointerElementType));
  if (!Size)
    return false;

  int64_t CVSize = CV->getSExtValue();
  if (CVSize % Size)
    return false;
  auto *StepValue = SE->getConstant(CV->getType(), CVSize / Size,
                                    true /* signed */);
  D = InductionDescriptor(StartValue, IK_PtrInduction, StepValue);
  return true;
}

/// \brief Returns the instructions that use values defined in the loop.
SmallVector<Instruction *, 8> llvm::findDefsUsedOutsideOfLoop(Loop *L) {
  SmallVector<Instruction *, 8> UsedOutside;

  for (auto *Block : L->getBlocks())
    // FIXME: I believe that this could use copy_if if the Inst reference could
    // be adapted into a pointer.
    for (auto &Inst : *Block) {
      auto Users = Inst.users();
      if (std::any_of(Users.begin(), Users.end(), [&](User *U) {
            auto *Use = cast<Instruction>(U);
            return !L->contains(Use->getParent());
          }))
        UsedOutside.push_back(&Inst);
    }

  return UsedOutside;
}

void llvm::getLoopAnalysisUsage(AnalysisUsage &AU) {
  // By definition, all loop passes need the LoopInfo analysis and the
  // Dominator tree it depends on. Because they all participate in the loop
  // pass manager, they must also preserve these.
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.addPreserved<DominatorTreeWrapperPass>();
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addPreserved<LoopInfoWrapperPass>();

  // We must also preserve LoopSimplify and LCSSA. We locally access their IDs
  // here because users shouldn't directly get them from this header.
  extern char &LoopSimplifyID;
  extern char &LCSSAID;
  AU.addRequiredID(LoopSimplifyID);
  AU.addPreservedID(LoopSimplifyID);
  AU.addRequiredID(LCSSAID);
  AU.addPreservedID(LCSSAID);

  // Loop passes are designed to run inside of a loop pass manager which means
  // that any function analyses they require must be required by the first loop
  // pass in the manager (so that it is computed before the loop pass manager
  // runs) and preserved by all loop pasess in the manager. To make this
  // reasonably robust, the set needed for most loop passes is maintained here.
  // If your loop pass requires an analysis not listed here, you will need to
  // carefully audit the loop pass manager nesting structure that results.
  AU.addRequired<AAResultsWrapperPass>();
  AU.addPreserved<AAResultsWrapperPass>();
  AU.addPreserved<BasicAAWrapperPass>();
  AU.addPreserved<GlobalsAAWrapperPass>();
  AU.addPreserved<SCEVAAWrapperPass>();
  AU.addRequired<ScalarEvolutionWrapperPass>();
  AU.addPreserved<ScalarEvolutionWrapperPass>();
}

/// Manually defined generic "LoopPass" dependency initialization. This is used
/// to initialize the exact set of passes from above in \c
/// getLoopAnalysisUsage. It can be used within a loop pass's initialization
/// with:
///
///   INITIALIZE_PASS_DEPENDENCY(LoopPass)
///
/// As-if "LoopPass" were a pass.
void llvm::initializeLoopPassPass(PassRegistry &Registry) {
  INITIALIZE_PASS_DEPENDENCY(DominatorTreeWrapperPass)
  INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
  INITIALIZE_PASS_DEPENDENCY(LoopSimplify)
  INITIALIZE_PASS_DEPENDENCY(LCSSA)
  INITIALIZE_PASS_DEPENDENCY(AAResultsWrapperPass)
  INITIALIZE_PASS_DEPENDENCY(BasicAAWrapperPass)
  INITIALIZE_PASS_DEPENDENCY(GlobalsAAWrapperPass)
  INITIALIZE_PASS_DEPENDENCY(SCEVAAWrapperPass)
  INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
}

/// \brief Find string metadata for loop
///
/// If it has a value (e.g. {"llvm.distribute", 1} return the value as an
/// operand or null otherwise.  If the string metadata is not found return
/// Optional's not-a-value.
Optional<const MDOperand *> llvm::findStringMetadataForLoop(Loop *TheLoop,
                                                            StringRef Name) {
  MDNode *LoopID = TheLoop->getLoopID();
  // Return none if LoopID is false.
  if (!LoopID)
    return None;

  // First operand should refer to the loop id itself.
  assert(LoopID->getNumOperands() > 0 && "requires at least one operand");
  assert(LoopID->getOperand(0) == LoopID && "invalid loop id");

  // Iterate over LoopID operands and look for MDString Metadata
  for (unsigned i = 1, e = LoopID->getNumOperands(); i < e; ++i) {
    MDNode *MD = dyn_cast<MDNode>(LoopID->getOperand(i));
    if (!MD)
      continue;
    MDString *S = dyn_cast<MDString>(MD->getOperand(0));
    if (!S)
      continue;
    // Return true if MDString holds expected MetaData.
    if (Name.equals(S->getString()))
      switch (MD->getNumOperands()) {
      case 1:
        return nullptr;
      case 2:
        return &MD->getOperand(1);
      default:
        llvm_unreachable("loop metadata has 0 or 1 operand");
      }
  }
  return None;
}
