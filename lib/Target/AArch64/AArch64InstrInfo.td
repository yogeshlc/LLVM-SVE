//=- AArch64InstrInfo.td - Describe the AArch64 Instructions -*- tablegen -*-=//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// AArch64 Instruction definitions.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// ARM Instruction Predicate Definitions.
//
def HasV8_1a         : Predicate<"Subtarget->hasV8_1aOps()">,
                                 AssemblerPredicate<"HasV8_1aOps", "armv8.1a">;
def HasV8_2a         : Predicate<"Subtarget->hasV8_2aOps()">,
                                 AssemblerPredicate<"HasV8_2aOps", "armv8.2a">;
def HasFPARMv8       : Predicate<"Subtarget->hasFPARMv8()">,
                               AssemblerPredicate<"FeatureFPARMv8", "fp-armv8">;
def HasNEON          : Predicate<"Subtarget->hasNEON()">,
                                 AssemblerPredicate<"FeatureNEON", "neon">;
def HasCrypto        : Predicate<"Subtarget->hasCrypto()">,
                                 AssemblerPredicate<"FeatureCrypto", "crypto">;
def HasCRC           : Predicate<"Subtarget->hasCRC()">,
                                 AssemblerPredicate<"FeatureCRC", "crc">;
def HasSVE           : Predicate<"Subtarget->hasSVE()">,
                                 AssemblerPredicate<"FeatureSVE", "sve">;
def HasPerfMon       : Predicate<"Subtarget->hasPerfMon()">;
def HasFullFP16      : Predicate<"Subtarget->hasFullFP16()">,
                                 AssemblerPredicate<"FeatureFullFP16", "fullfp16">;
def HasSPE           : Predicate<"Subtarget->hasSPE()">,
                                 AssemblerPredicate<"FeatureSPE", "spe">;

def IsLE             : Predicate<"Subtarget->isLittleEndian()">;
def IsBE             : Predicate<"!Subtarget->isLittleEndian()">;
def UseAlternateSExtLoadCVTF32
    : Predicate<"Subtarget->useAlternateSExtLoadCVTF32Pattern()">;

//===----------------------------------------------------------------------===//
// AArch64-specific DAG Nodes.
//

// SDTBinaryArithWithFlagsOut - RES1, FLAGS = op LHS, RHS
def SDTBinaryArithWithFlagsOut : SDTypeProfile<2, 2,
                                              [SDTCisSameAs<0, 2>,
                                               SDTCisSameAs<0, 3>,
                                               SDTCisInt<0>, SDTCisVT<1, i32>]>;

// SDTBinaryArithWithFlagsIn - RES1, FLAGS = op LHS, RHS, FLAGS
def SDTBinaryArithWithFlagsIn : SDTypeProfile<1, 3,
                                            [SDTCisSameAs<0, 1>,
                                             SDTCisSameAs<0, 2>,
                                             SDTCisInt<0>,
                                             SDTCisVT<3, i32>]>;

// SDTBinaryArithWithFlagsInOut - RES1, FLAGS = op LHS, RHS, FLAGS
def SDTBinaryArithWithFlagsInOut : SDTypeProfile<2, 3,
                                            [SDTCisSameAs<0, 2>,
                                             SDTCisSameAs<0, 3>,
                                             SDTCisInt<0>,
                                             SDTCisVT<1, i32>,
                                             SDTCisVT<4, i32>]>;

def SDT_AArch64Brcond  : SDTypeProfile<0, 3,
                                     [SDTCisVT<0, OtherVT>, SDTCisVT<1, i32>,
                                      SDTCisVT<2, i32>]>;
def SDT_AArch64cbz : SDTypeProfile<0, 2, [SDTCisInt<0>, SDTCisVT<1, OtherVT>]>;
def SDT_AArch64tbz : SDTypeProfile<0, 3, [SDTCisInt<0>, SDTCisInt<1>,
                                        SDTCisVT<2, OtherVT>]>;

def SDT_AArch64Fcvt_extend : SDTypeProfile<1, 1, [  // fextend
  SDTCisFP<0>, SDTCisFP<1>, SDTCisOpSmallerThanOp<1, 0>
]>;

def SDT_AArch64CSel  : SDTypeProfile<1, 4,
                                   [SDTCisSameAs<0, 1>,
                                    SDTCisSameAs<0, 2>,
                                    SDTCisInt<3>,
                                    SDTCisVT<4, i32>]>;
def SDT_AArch64CCMP : SDTypeProfile<1, 5,
                                    [SDTCisVT<0, i32>,
                                     SDTCisInt<1>,
                                     SDTCisSameAs<1, 2>,
                                     SDTCisInt<3>,
                                     SDTCisInt<4>,
                                     SDTCisVT<5, i32>]>;
def SDT_AArch64FCCMP : SDTypeProfile<1, 5,
                                     [SDTCisVT<0, i32>,
                                      SDTCisFP<1>,
                                      SDTCisSameAs<1, 2>,
                                      SDTCisInt<3>,
                                      SDTCisInt<4>,
                                      SDTCisVT<5, i32>]>;
def SDT_AArch64FCmp   : SDTypeProfile<0, 2,
                                   [SDTCisFP<0>,
                                    SDTCisSameAs<0, 1>]>;
def SDT_AArch64Dup   : SDTypeProfile<1, 1, [SDTCisVec<0>]>;
def SDT_AArch64DupLane   : SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCisInt<2>]>;
def SDT_AArch64Zip   : SDTypeProfile<1, 2, [SDTCisVec<0>,
                                          SDTCisSameAs<0, 1>,
                                          SDTCisSameAs<0, 2>]>;
def SDT_AArch64MOVIedit : SDTypeProfile<1, 1, [SDTCisInt<1>]>;
def SDT_AArch64MOVIshift : SDTypeProfile<1, 2, [SDTCisInt<1>, SDTCisInt<2>]>;
def SDT_AArch64vecimm : SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCisSameAs<0,1>,
                                           SDTCisInt<2>, SDTCisInt<3>]>;
def SDT_AArch64UnaryVec: SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisSameAs<0,1>]>;
def SDT_AArch64ExtVec: SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCisSameAs<0,1>,
                                          SDTCisSameAs<0,2>, SDTCisInt<3>]>;
def SDT_AArch64vshift : SDTypeProfile<1, 2, [SDTCisSameAs<0,1>, SDTCisInt<2>]>;

def SDT_AArch64unvec : SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisSameAs<0,1>]>;
def SDT_AArch64fcmpz : SDTypeProfile<1, 1, []>;
def SDT_AArch64fcmp  : SDTypeProfile<1, 2, [SDTCisSameAs<1,2>]>;
def SDT_AArch64binvec : SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCisSameAs<0,1>,
                                           SDTCisSameAs<0,2>]>;
def SDT_AArch64trivec : SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCisSameAs<0,1>,
                                           SDTCisSameAs<0,2>,
                                           SDTCisSameAs<0,3>]>;
def SDT_AArch64TCRET : SDTypeProfile<0, 2, [SDTCisPtrTy<0>]>;
def SDT_AArch64PREFETCH : SDTypeProfile<0, 2, [SDTCisVT<0, i32>, SDTCisPtrTy<1>]>;

def SDT_AArch64ITOF  : SDTypeProfile<1, 1, [SDTCisFP<0>, SDTCisSameAs<0,1>]>;

def SDT_AArch64TLSDescCall : SDTypeProfile<0, -2, [SDTCisPtrTy<0>,
                                                 SDTCisPtrTy<1>]>;

// Generates the general dynamic sequences, i.e.
//  adrp  x0, :tlsdesc:var
//  ldr   x1, [x0, #:tlsdesc_lo12:var]
//  add   x0, x0, #:tlsdesc_lo12:var
//  .tlsdesccall var
//  blr   x1

// (the TPIDR_EL0 offset is put directly in X0, hence no "result" here)
// number of operands (the variable)
def SDT_AArch64TLSDescCallSeq : SDTypeProfile<0,1,
                                          [SDTCisPtrTy<0>]>;

def SDT_AArch64WrapperLarge : SDTypeProfile<1, 4,
                                        [SDTCisVT<0, i64>, SDTCisVT<1, i32>,
                                         SDTCisSameAs<1, 2>, SDTCisSameAs<1, 3>,
                                         SDTCisSameAs<1, 4>]>;

def SDT_AArch64TBL : SDTypeProfile<1, 2, [
  SDTCisVec<0>, SDTCisSameAs<0, 1>, SDTCisInt<2>
]>;

// TODO: these are patterns that everybody could benefit from but sadly they
// cannot live in TargetSelectionDAG.td because compilation fails when targets
// without vector registers are enabled.

// sign extending masked load fragments.
def sext_masked_load :
  PatFrag<(ops node:$ptr, node:$pred, node:$def),
          (masked_load node:$ptr, node:$pred, node:$def),[{
  return cast<MaskedLoadSDNode>(N)->getExtensionType() == ISD::SEXTLOAD;
}]>;
def sext_masked_load_i8 :
  PatFrag<(ops node:$ptr, node:$pred, node:$def),
          (sext_masked_load node:$ptr, node:$pred, node:$def), [{
  return cast<MaskedLoadSDNode>(N)->getMemoryVT().getScalarType() == MVT::i8;
}]>;
def sext_masked_load_i16 :
  PatFrag<(ops node:$ptr, node:$pred, node:$def),
          (sext_masked_load node:$ptr, node:$pred, node:$def), [{
  return cast<MaskedLoadSDNode>(N)->getMemoryVT().getScalarType() == MVT::i16;
}]>;
def sext_masked_load_i32 :
  PatFrag<(ops node:$ptr, node:$pred, node:$def),
          (sext_masked_load node:$ptr, node:$pred, node:$def), [{
  return cast<MaskedLoadSDNode>(N)->getMemoryVT().getScalarType() == MVT::i32;
}]>;

// zero extending masked load fragments.
def zext_masked_load :
  PatFrag<(ops node:$ptr, node:$pred, node:$def),
          (masked_load node:$ptr, node:$pred, node:$def), [{
  return cast<MaskedLoadSDNode>(N)->getExtensionType() == ISD::ZEXTLOAD;
}]>;
def zext_masked_load_i8 :
  PatFrag<(ops node:$ptr, node:$pred, node:$def),
          (zext_masked_load node:$ptr, node:$pred, node:$def), [{
  return cast<MaskedLoadSDNode>(N)->getMemoryVT().getScalarType() == MVT::i8;
}]>;
def zext_masked_load_i16 :
  PatFrag<(ops node:$ptr, node:$pred, node:$def),
          (zext_masked_load node:$ptr, node:$pred, node:$def), [{
  return cast<MaskedLoadSDNode>(N)->getMemoryVT().getScalarType() == MVT::i16;
}]>;
def zext_masked_load_i32 :
  PatFrag<(ops node:$ptr, node:$pred, node:$def),
          (zext_masked_load node:$ptr, node:$pred, node:$def), [{
  return cast<MaskedLoadSDNode>(N)->getMemoryVT().getScalarType() == MVT::i32;
}]>;

// truncating masked store fragments.
def trunc_masked_store :
  PatFrag<(ops node:$ptr, node:$pred, node:$val),
          (masked_store node:$ptr, node:$pred, node:$val), [{
  return cast<MaskedStoreSDNode>(N)->isTruncatingStore();
}]>;
def trunc_masked_store_i8 :
  PatFrag<(ops node:$ptr, node:$pred, node:$val),
          (trunc_masked_store node:$ptr, node:$pred, node:$val), [{
  return cast<MaskedStoreSDNode>(N)->getMemoryVT().getScalarType() == MVT::i8;
}]>;
def trunc_masked_store_i16 :
  PatFrag<(ops node:$ptr, node:$pred, node:$val),
          (trunc_masked_store node:$ptr, node:$pred, node:$val), [{
  return cast<MaskedStoreSDNode>(N)->getMemoryVT().getScalarType() == MVT::i16;
}]>;
def trunc_masked_store_i32 :
  PatFrag<(ops node:$ptr, node:$pred, node:$val),
          (trunc_masked_store node:$ptr, node:$pred, node:$val), [{
  return cast<MaskedStoreSDNode>(N)->getMemoryVT().getScalarType() == MVT::i32;
}]>;

// NOTE: This is a clone of SDTMaskedGather as the "common" version looks rather
//       target specific.
def SDT_SVEMaskedGather : SDTypeProfile<1, 4, [       // masked gather
  SDTCisVec<0>, SDTCisSameAs<0, 1>, SDTCisVec<2>, SDTCisPtrTy<3>, SDTCisVec<4>,
  SDTCVecEltisVT<2, i1>, SDTCisSameNumEltsAs<0, 2>, SDTCisSameNumEltsAs<0, 4>
]>;
def sve_masked_gather : SDNode<"ISD::MGATHER", SDT_SVEMaskedGather,
                               [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

// sign extending masked gather fragments.
def sext_masked_gather :
  PatFrag<(ops node:$def, node:$pred, node:$ptr, node:$idx),
          (sve_masked_gather node:$def, node:$pred, node:$ptr, node:$idx),[{
  return cast<MaskedGatherSDNode>(N)->getExtensionType() == ISD::SEXTLOAD;
}]>;
def sext_masked_gather_i8 :
  PatFrag<(ops node:$def, node:$pred, node:$ptr, node:$idx),
          (sext_masked_gather node:$def, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedGatherSDNode>(N)->getMemoryVT().getScalarType() == MVT::i8;
}]>;
def sext_masked_gather_i16 :
  PatFrag<(ops node:$def, node:$pred, node:$ptr, node:$idx),
          (sext_masked_gather node:$def, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedGatherSDNode>(N)->getMemoryVT().getScalarType() == MVT::i16;
}]>;
def sext_masked_gather_i32 :
  PatFrag<(ops node:$def, node:$pred, node:$ptr, node:$idx),
          (sext_masked_gather node:$def, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedGatherSDNode>(N)->getMemoryVT().getScalarType() == MVT::i32;
}]>;

// zero extending masked gather fragments.
def zext_masked_gather :
  PatFrag<(ops node:$def, node:$pred, node:$ptr, node:$idx),
          (sve_masked_gather node:$def, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedGatherSDNode>(N)->getExtensionType() == ISD::ZEXTLOAD;
}]>;
def zext_masked_gather_i8 :
  PatFrag<(ops node:$def, node:$pred, node:$ptr, node:$idx),
          (zext_masked_gather node:$def, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedGatherSDNode>(N)->getMemoryVT().getScalarType() == MVT::i8;
}]>;
def zext_masked_gather_i16 :
  PatFrag<(ops node:$def, node:$pred, node:$ptr, node:$idx),
         (zext_masked_gather node:$def, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedGatherSDNode>(N)->getMemoryVT().getScalarType() == MVT::i16;
}]>;
def zext_masked_gather_i32 :
  PatFrag<(ops node:$def, node:$pred, node:$ptr, node:$idx),
          (zext_masked_gather node:$def, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedGatherSDNode>(N)->getMemoryVT().getScalarType() == MVT::i32;
}]>;

// NOTE: This is a clone of SDTMaskedScatter as the "common" version looks
//       rather target specific.
def SDT_SVEMaskedScatter : SDTypeProfile<0, 4, [       // masked scatter
  SDTCisVec<0>, SDTCisVec<1>, SDTCisPtrTy<2>, SDTCisVec<3>,
  SDTCVecEltisVT<1, i1>, SDTCisSameNumEltsAs<0, 1>, SDTCisSameNumEltsAs<0, 3>
]>;
def sve_masked_scatter : SDNode<"ISD::MSCATTER", SDT_SVEMaskedScatter,
                                  [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;

// truncating masked scatter fragments.
def trunc_masked_scatter :
  PatFrag<(ops node:$val, node:$pred, node:$ptr, node:$idx),
          (sve_masked_scatter node:$val, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedScatterSDNode>(N)->isTruncatingStore();
}]>;
def trunc_masked_scatter_i8 :
  PatFrag<(ops node:$val, node:$pred, node:$ptr, node:$idx),
          (trunc_masked_scatter node:$val, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedScatterSDNode>(N)->getMemoryVT().getScalarType() == MVT::i8;
}]>;
def trunc_masked_scatter_i16 :
  PatFrag<(ops node:$val, node:$pred, node:$ptr, node:$idx),
         (trunc_masked_scatter node:$val, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedScatterSDNode>(N)->getMemoryVT().getScalarType() == MVT::i16;
}]>;
def trunc_masked_scatter_i32 :
  PatFrag<(ops node:$val, node:$pred, node:$ptr, node:$idx),
          (trunc_masked_scatter node:$val, node:$pred, node:$ptr, node:$idx), [{
  return cast<MaskedScatterSDNode>(N)->getMemoryVT().getScalarType() == MVT::i32;
}]>;

// non-extending/truncating masked load/store fragments
def nonext_masked_load :
  PatFrag<(ops node:$ptr, node:$pred, node:$def),
          (masked_load node:$ptr, node:$pred, node:$def), [{
  return cast<MaskedLoadSDNode>(N)->getExtensionType() == ISD::NON_EXTLOAD;
}]>;
def nonext_masked_gather :
  PatFrag<(ops node:$def, node:$pred, node:$ptr, node:$idx),
          (sve_masked_gather node:$def, node:$pred, node:$ptr, node:$idx),[{
  return cast<MaskedGatherSDNode>(N)->getExtensionType() == ISD::NON_EXTLOAD;
}]>;
def nontrunc_masked_store :
  PatFrag<(ops node:$ptr, node:$pred, node:$val),
          (masked_store node:$ptr, node:$pred, node:$val), [{
  return !cast<MaskedStoreSDNode>(N)->isTruncatingStore();
}]>;
def nontrunc_masked_scatter :
  PatFrag<(ops node:$val, node:$pred, node:$ptr, node:$idx),
          (sve_masked_scatter node:$val, node:$pred, node:$ptr, node:$idx), [{
  return !cast<MaskedScatterSDNode>(N)->isTruncatingStore();
}]>;

// Node definitions.
def AArch64fcvt_extend   : SDNode<"AArch64ISD::FCVT", SDT_AArch64Fcvt_extend>;
def AArch64adrp          : SDNode<"AArch64ISD::ADRP", SDTIntUnaryOp, []>;
def AArch64addlow        : SDNode<"AArch64ISD::ADDlow", SDTIntBinOp, []>;
def AArch64LOADgot       : SDNode<"AArch64ISD::LOADgot", SDTIntUnaryOp>;
def AArch64callseq_start : SDNode<"ISD::CALLSEQ_START",
                                SDCallSeqStart<[ SDTCisVT<0, i32> ]>,
                                [SDNPHasChain, SDNPOutGlue]>;
def AArch64callseq_end   : SDNode<"ISD::CALLSEQ_END",
                                SDCallSeqEnd<[ SDTCisVT<0, i32>,
                                               SDTCisVT<1, i32> ]>,
                                [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue]>;
def AArch64call          : SDNode<"AArch64ISD::CALL",
                                SDTypeProfile<0, -1, [SDTCisPtrTy<0>]>,
                                [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue,
                                 SDNPVariadic]>;
def AArch64brcond        : SDNode<"AArch64ISD::BRCOND", SDT_AArch64Brcond,
                                [SDNPHasChain]>;
def AArch64cbz           : SDNode<"AArch64ISD::CBZ", SDT_AArch64cbz,
                                [SDNPHasChain]>;
def AArch64cbnz           : SDNode<"AArch64ISD::CBNZ", SDT_AArch64cbz,
                                [SDNPHasChain]>;
def AArch64tbz           : SDNode<"AArch64ISD::TBZ", SDT_AArch64tbz,
                                [SDNPHasChain]>;
def AArch64tbnz           : SDNode<"AArch64ISD::TBNZ", SDT_AArch64tbz,
                                [SDNPHasChain]>;


def AArch64csel          : SDNode<"AArch64ISD::CSEL", SDT_AArch64CSel>;
def AArch64csinv         : SDNode<"AArch64ISD::CSINV", SDT_AArch64CSel>;
def AArch64csneg         : SDNode<"AArch64ISD::CSNEG", SDT_AArch64CSel>;
def AArch64csinc         : SDNode<"AArch64ISD::CSINC", SDT_AArch64CSel>;
def AArch64retflag       : SDNode<"AArch64ISD::RET_FLAG", SDTNone,
                                [SDNPHasChain, SDNPOptInGlue, SDNPVariadic]>;
def AArch64adc       : SDNode<"AArch64ISD::ADC",  SDTBinaryArithWithFlagsIn >;
def AArch64sbc       : SDNode<"AArch64ISD::SBC",  SDTBinaryArithWithFlagsIn>;
def AArch64add_flag  : SDNode<"AArch64ISD::ADDS",  SDTBinaryArithWithFlagsOut,
                            [SDNPCommutative]>;
def AArch64sub_flag  : SDNode<"AArch64ISD::SUBS",  SDTBinaryArithWithFlagsOut>;
def AArch64and_flag  : SDNode<"AArch64ISD::ANDS",  SDTBinaryArithWithFlagsOut,
                            [SDNPCommutative]>;
def AArch64adc_flag  : SDNode<"AArch64ISD::ADCS",  SDTBinaryArithWithFlagsInOut>;
def AArch64sbc_flag  : SDNode<"AArch64ISD::SBCS",  SDTBinaryArithWithFlagsInOut>;

def AArch64ccmp      : SDNode<"AArch64ISD::CCMP",  SDT_AArch64CCMP>;
def AArch64ccmn      : SDNode<"AArch64ISD::CCMN",  SDT_AArch64CCMP>;
def AArch64fccmp     : SDNode<"AArch64ISD::FCCMP", SDT_AArch64FCCMP>;

def AArch64threadpointer : SDNode<"AArch64ISD::THREAD_POINTER", SDTPtrLeaf>;

def AArch64fcmp      : SDNode<"AArch64ISD::FCMP", SDT_AArch64FCmp>;

def AArch64dup       : SDNode<"AArch64ISD::DUP", SDT_AArch64Dup>;
def AArch64duplane8  : SDNode<"AArch64ISD::DUPLANE8", SDT_AArch64DupLane>;
def AArch64duplane16 : SDNode<"AArch64ISD::DUPLANE16", SDT_AArch64DupLane>;
def AArch64duplane32 : SDNode<"AArch64ISD::DUPLANE32", SDT_AArch64DupLane>;
def AArch64duplane64 : SDNode<"AArch64ISD::DUPLANE64", SDT_AArch64DupLane>;

def AArch64zip1      : SDNode<"AArch64ISD::ZIP1", SDT_AArch64Zip>;
def AArch64zip2      : SDNode<"AArch64ISD::ZIP2", SDT_AArch64Zip>;
def AArch64uzp1      : SDNode<"AArch64ISD::UZP1", SDT_AArch64Zip>;
def AArch64uzp2      : SDNode<"AArch64ISD::UZP2", SDT_AArch64Zip>;
def AArch64trn1      : SDNode<"AArch64ISD::TRN1", SDT_AArch64Zip>;
def AArch64trn2      : SDNode<"AArch64ISD::TRN2", SDT_AArch64Zip>;

def AArch64movi_edit : SDNode<"AArch64ISD::MOVIedit", SDT_AArch64MOVIedit>;
def AArch64movi_shift : SDNode<"AArch64ISD::MOVIshift", SDT_AArch64MOVIshift>;
def AArch64movi_msl : SDNode<"AArch64ISD::MOVImsl", SDT_AArch64MOVIshift>;
def AArch64mvni_shift : SDNode<"AArch64ISD::MVNIshift", SDT_AArch64MOVIshift>;
def AArch64mvni_msl : SDNode<"AArch64ISD::MVNImsl", SDT_AArch64MOVIshift>;
def AArch64movi : SDNode<"AArch64ISD::MOVI", SDT_AArch64MOVIedit>;
def AArch64fmov : SDNode<"AArch64ISD::FMOV", SDT_AArch64MOVIedit>;

def AArch64rev16 : SDNode<"AArch64ISD::REV16", SDT_AArch64UnaryVec>;
def AArch64rev32 : SDNode<"AArch64ISD::REV32", SDT_AArch64UnaryVec>;
def AArch64rev64 : SDNode<"AArch64ISD::REV64", SDT_AArch64UnaryVec>;
def AArch64ext : SDNode<"AArch64ISD::EXT", SDT_AArch64ExtVec>;

def AArch64vashr : SDNode<"AArch64ISD::VASHR", SDT_AArch64vshift>;
def AArch64vlshr : SDNode<"AArch64ISD::VLSHR", SDT_AArch64vshift>;
def AArch64vshl : SDNode<"AArch64ISD::VSHL", SDT_AArch64vshift>;
def AArch64sqshli : SDNode<"AArch64ISD::SQSHL_I", SDT_AArch64vshift>;
def AArch64uqshli : SDNode<"AArch64ISD::UQSHL_I", SDT_AArch64vshift>;
def AArch64sqshlui : SDNode<"AArch64ISD::SQSHLU_I", SDT_AArch64vshift>;
def AArch64srshri : SDNode<"AArch64ISD::SRSHR_I", SDT_AArch64vshift>;
def AArch64urshri : SDNode<"AArch64ISD::URSHR_I", SDT_AArch64vshift>;

def AArch64not: SDNode<"AArch64ISD::NOT", SDT_AArch64unvec>;
def AArch64bit: SDNode<"AArch64ISD::BIT", SDT_AArch64trivec>;
def AArch64bsl: SDNode<"AArch64ISD::BSL", SDT_AArch64trivec>;

def AArch64cmeq: SDNode<"AArch64ISD::CMEQ", SDT_AArch64binvec>;
def AArch64cmge: SDNode<"AArch64ISD::CMGE", SDT_AArch64binvec>;
def AArch64cmgt: SDNode<"AArch64ISD::CMGT", SDT_AArch64binvec>;
def AArch64cmhi: SDNode<"AArch64ISD::CMHI", SDT_AArch64binvec>;
def AArch64cmhs: SDNode<"AArch64ISD::CMHS", SDT_AArch64binvec>;

def AArch64fcmeq: SDNode<"AArch64ISD::FCMEQ", SDT_AArch64fcmp>;
def AArch64fcmge: SDNode<"AArch64ISD::FCMGE", SDT_AArch64fcmp>;
def AArch64fcmgt: SDNode<"AArch64ISD::FCMGT", SDT_AArch64fcmp>;

def AArch64cmeqz: SDNode<"AArch64ISD::CMEQz", SDT_AArch64unvec>;
def AArch64cmgez: SDNode<"AArch64ISD::CMGEz", SDT_AArch64unvec>;
def AArch64cmgtz: SDNode<"AArch64ISD::CMGTz", SDT_AArch64unvec>;
def AArch64cmlez: SDNode<"AArch64ISD::CMLEz", SDT_AArch64unvec>;
def AArch64cmltz: SDNode<"AArch64ISD::CMLTz", SDT_AArch64unvec>;
def AArch64cmtst : PatFrag<(ops node:$LHS, node:$RHS),
                        (AArch64not (AArch64cmeqz (and node:$LHS, node:$RHS)))>;

def AArch64fcmeqz: SDNode<"AArch64ISD::FCMEQz", SDT_AArch64fcmpz>;
def AArch64fcmgez: SDNode<"AArch64ISD::FCMGEz", SDT_AArch64fcmpz>;
def AArch64fcmgtz: SDNode<"AArch64ISD::FCMGTz", SDT_AArch64fcmpz>;
def AArch64fcmlez: SDNode<"AArch64ISD::FCMLEz", SDT_AArch64fcmpz>;
def AArch64fcmltz: SDNode<"AArch64ISD::FCMLTz", SDT_AArch64fcmpz>;

def AArch64bici: SDNode<"AArch64ISD::BICi", SDT_AArch64vecimm>;
def AArch64orri: SDNode<"AArch64ISD::ORRi", SDT_AArch64vecimm>;

def AArch64neg : SDNode<"AArch64ISD::NEG", SDT_AArch64unvec>;

def AArch64tcret: SDNode<"AArch64ISD::TC_RETURN", SDT_AArch64TCRET,
                  [SDNPHasChain,  SDNPOptInGlue, SDNPVariadic]>;

def AArch64Prefetch        : SDNode<"AArch64ISD::PREFETCH", SDT_AArch64PREFETCH,
                               [SDNPHasChain, SDNPSideEffect]>;

def AArch64sitof: SDNode<"AArch64ISD::SITOF", SDT_AArch64ITOF>;
def AArch64uitof: SDNode<"AArch64ISD::UITOF", SDT_AArch64ITOF>;

def AArch64tlsdesc_callseq : SDNode<"AArch64ISD::TLSDESC_CALLSEQ",
                                    SDT_AArch64TLSDescCallSeq,
                                    [SDNPInGlue, SDNPOutGlue, SDNPHasChain,
                                     SDNPVariadic]>;


def AArch64WrapperLarge : SDNode<"AArch64ISD::WrapperLarge",
                                 SDT_AArch64WrapperLarge>;

def AArch64NvCast : SDNode<"AArch64ISD::NVCAST", SDTUnaryOp>;

def SDT_AArch64mull : SDTypeProfile<1, 2, [SDTCisInt<0>, SDTCisInt<1>,
                                    SDTCisSameAs<1, 2>]>;
def AArch64smull    : SDNode<"AArch64ISD::SMULL", SDT_AArch64mull>;
def AArch64umull    : SDNode<"AArch64ISD::UMULL", SDT_AArch64mull>;

def AArch64frecpe   : SDNode<"AArch64ISD::FRECPE", SDTFPUnaryOp>;
def AArch64frsqrte  : SDNode<"AArch64ISD::FRSQRTE", SDTFPUnaryOp>;

def AArch64saddv    : SDNode<"AArch64ISD::SADDV", SDT_AArch64UnaryVec>;
def AArch64uaddv    : SDNode<"AArch64ISD::UADDV", SDT_AArch64UnaryVec>;
def AArch64sminv    : SDNode<"AArch64ISD::SMINV", SDT_AArch64UnaryVec>;
def AArch64uminv    : SDNode<"AArch64ISD::UMINV", SDT_AArch64UnaryVec>;
def AArch64smaxv    : SDNode<"AArch64ISD::SMAXV", SDT_AArch64UnaryVec>;
def AArch64umaxv    : SDNode<"AArch64ISD::UMAXV", SDT_AArch64UnaryVec>;

def AArch64TBL : SDNode<"AArch64ISD::TBL", SDT_AArch64TBL>;

def AArch64sunpkhi : SDNode<"AArch64ISD::SUNPKHI", SDTIntExtendOp>;
def AArch64sunpklo : SDNode<"AArch64ISD::SUNPKLO", SDTIntExtendOp>;
def AArch64uunpkhi : SDNode<"AArch64ISD::UUNPKHI", SDTIntExtendOp>;
def AArch64uunpklo : SDNode<"AArch64ISD::UUNPKLO", SDTIntExtendOp>;

//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//

// AArch64 Instruction Predicate Definitions.
//
def HasZCZ    : Predicate<"Subtarget->hasZeroCycleZeroing()">;
def NoZCZ     : Predicate<"!Subtarget->hasZeroCycleZeroing()">;
def IsDarwin  : Predicate<"Subtarget->isTargetDarwin()">;
def IsNotDarwin: Predicate<"!Subtarget->isTargetDarwin()">;
def ForCodeSize   : Predicate<"ForCodeSize">;
def NotForCodeSize   : Predicate<"!ForCodeSize">;

include "AArch64InstrFormats.td"

//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Miscellaneous instructions.
//===----------------------------------------------------------------------===//

let Defs = [SP], Uses = [SP], hasSideEffects = 1, isCodeGenOnly = 1 in {
// We set Sched to empty list because we expect these instructions to simply get
// removed in most cases.
def ADJCALLSTACKDOWN : Pseudo<(outs), (ins i32imm:$amt),
                              [(AArch64callseq_start timm:$amt)]>, Sched<[]>;
def ADJCALLSTACKUP : Pseudo<(outs), (ins i32imm:$amt1, i32imm:$amt2),
                            [(AArch64callseq_end timm:$amt1, timm:$amt2)]>,
                            Sched<[]>;
} // Defs = [SP], Uses = [SP], hasSideEffects = 1, isCodeGenOnly = 1

let isReMaterializable = 1, isCodeGenOnly = 1 in {
// FIXME: The following pseudo instructions are only needed because remat
// cannot handle multiple instructions.  When that changes, they can be
// removed, along with the AArch64Wrapper node.

let AddedComplexity = 10 in
def LOADgot : Pseudo<(outs GPR64:$dst), (ins i64imm:$addr),
                     [(set GPR64:$dst, (AArch64LOADgot tglobaladdr:$addr))]>,
              Sched<[WriteLDAdr]>;

// The MOVaddr instruction should match only when the add is not folded
// into a load or store address.
def MOVaddr
    : Pseudo<(outs GPR64:$dst), (ins i64imm:$hi, i64imm:$low),
             [(set GPR64:$dst, (AArch64addlow (AArch64adrp tglobaladdr:$hi),
                                            tglobaladdr:$low))]>,
      Sched<[WriteAdrAdr]>;
def MOVaddrJT
    : Pseudo<(outs GPR64:$dst), (ins i64imm:$hi, i64imm:$low),
             [(set GPR64:$dst, (AArch64addlow (AArch64adrp tjumptable:$hi),
                                             tjumptable:$low))]>,
      Sched<[WriteAdrAdr]>;
def MOVaddrCP
    : Pseudo<(outs GPR64:$dst), (ins i64imm:$hi, i64imm:$low),
             [(set GPR64:$dst, (AArch64addlow (AArch64adrp tconstpool:$hi),
                                             tconstpool:$low))]>,
      Sched<[WriteAdrAdr]>;
def MOVaddrBA
    : Pseudo<(outs GPR64:$dst), (ins i64imm:$hi, i64imm:$low),
             [(set GPR64:$dst, (AArch64addlow (AArch64adrp tblockaddress:$hi),
                                             tblockaddress:$low))]>,
      Sched<[WriteAdrAdr]>;
def MOVaddrTLS
    : Pseudo<(outs GPR64:$dst), (ins i64imm:$hi, i64imm:$low),
             [(set GPR64:$dst, (AArch64addlow (AArch64adrp tglobaltlsaddr:$hi),
                                            tglobaltlsaddr:$low))]>,
      Sched<[WriteAdrAdr]>;
def MOVaddrEXT
    : Pseudo<(outs GPR64:$dst), (ins i64imm:$hi, i64imm:$low),
             [(set GPR64:$dst, (AArch64addlow (AArch64adrp texternalsym:$hi),
                                            texternalsym:$low))]>,
      Sched<[WriteAdrAdr]>;

} // isReMaterializable, isCodeGenOnly

def : Pat<(AArch64LOADgot tglobaltlsaddr:$addr),
          (LOADgot tglobaltlsaddr:$addr)>;

def : Pat<(AArch64LOADgot texternalsym:$addr),
          (LOADgot texternalsym:$addr)>;

def : Pat<(AArch64LOADgot tconstpool:$addr),
          (LOADgot tconstpool:$addr)>;

//===----------------------------------------------------------------------===//
// System instructions.
//===----------------------------------------------------------------------===//

def HINT : HintI<"hint">;
def : InstAlias<"nop",  (HINT 0b000)>;
def : InstAlias<"yield",(HINT 0b001)>;
def : InstAlias<"wfe",  (HINT 0b010)>;
def : InstAlias<"wfi",  (HINT 0b011)>;
def : InstAlias<"sev",  (HINT 0b100)>;
def : InstAlias<"sevl", (HINT 0b101)>;

// v8.2a Statistical Profiling extension
def : InstAlias<"psb $op",  (HINT psbhint_op:$op)>, Requires<[HasSPE]>;

// As far as LLVM is concerned this writes to the system's exclusive monitors.
let mayLoad = 1, mayStore = 1 in
def CLREX : CRmSystemI<imm0_15, 0b010, "clrex">;

// NOTE: ideally, this would have mayStore = 0, mayLoad = 0, but we cannot
// model patterns with sufficiently fine granularity.
let mayLoad = ?, mayStore = ? in {
def DMB   : CRmSystemI<barrier_op, 0b101, "dmb",
                       [(int_aarch64_dmb (i32 imm32_0_15:$CRm))]>;

def DSB   : CRmSystemI<barrier_op, 0b100, "dsb",
                       [(int_aarch64_dsb (i32 imm32_0_15:$CRm))]>;

def ISB   : CRmSystemI<barrier_op, 0b110, "isb",
                       [(int_aarch64_isb (i32 imm32_0_15:$CRm))]>;
}

def : InstAlias<"clrex", (CLREX 0xf)>;
def : InstAlias<"isb", (ISB 0xf)>;

def MRS    : MRSI;
def MSR    : MSRI;
def MSRpstateImm1 : MSRpstateImm0_1;
def MSRpstateImm4 : MSRpstateImm0_15;

// The thread pointer (on Linux, at least, where this has been implemented) is
// TPIDR_EL0.
def : Pat<(AArch64threadpointer), (MRS 0xde82)>;

// The cycle counter PMC register is PMCCNTR_EL0.
let Predicates = [HasPerfMon] in
def : Pat<(readcyclecounter), (MRS 0xdce8)>;

// Generic system instructions
def SYSxt  : SystemXtI<0, "sys">;
def SYSLxt : SystemLXtI<1, "sysl">;

def : InstAlias<"sys $op1, $Cn, $Cm, $op2",
                (SYSxt imm0_7:$op1, sys_cr_op:$Cn,
                 sys_cr_op:$Cm, imm0_7:$op2, XZR)>;

//===----------------------------------------------------------------------===//
// Move immediate instructions.
//===----------------------------------------------------------------------===//

defm MOVK : InsertImmediate<0b11, "movk">;
defm MOVN : MoveImmediate<0b00, "movn">;

let PostEncoderMethod = "fixMOVZ" in
defm MOVZ : MoveImmediate<0b10, "movz">;

// First group of aliases covers an implicit "lsl #0".
def : InstAlias<"movk $dst, $imm", (MOVKWi GPR32:$dst, imm0_65535dec:$imm, 0)>;
def : InstAlias<"movk $dst, $imm", (MOVKXi GPR64:$dst, imm0_65535dec:$imm, 0)>;
def : InstAlias<"movn $dst, $imm", (MOVNWi GPR32:$dst, imm0_65535dec:$imm, 0)>;
def : InstAlias<"movn $dst, $imm", (MOVNXi GPR64:$dst, imm0_65535dec:$imm, 0)>;
def : InstAlias<"movz $dst, $imm", (MOVZWi GPR32:$dst, imm0_65535dec:$imm, 0)>;
def : InstAlias<"movz $dst, $imm", (MOVZXi GPR64:$dst, imm0_65535dec:$imm, 0)>;

// Next, we have various ELF relocations with the ":XYZ_g0:sym" syntax.
def : InstAlias<"movz $Rd, $sym", (MOVZXi GPR64:$Rd, movz_symbol_g3:$sym, 48)>;
def : InstAlias<"movz $Rd, $sym", (MOVZXi GPR64:$Rd, movz_symbol_g2:$sym, 32)>;
def : InstAlias<"movz $Rd, $sym", (MOVZXi GPR64:$Rd, movz_symbol_g1:$sym, 16)>;
def : InstAlias<"movz $Rd, $sym", (MOVZXi GPR64:$Rd, movz_symbol_g0:$sym, 0)>;

def : InstAlias<"movn $Rd, $sym", (MOVNXi GPR64:$Rd, movz_symbol_g3:$sym, 48)>;
def : InstAlias<"movn $Rd, $sym", (MOVNXi GPR64:$Rd, movz_symbol_g2:$sym, 32)>;
def : InstAlias<"movn $Rd, $sym", (MOVNXi GPR64:$Rd, movz_symbol_g1:$sym, 16)>;
def : InstAlias<"movn $Rd, $sym", (MOVNXi GPR64:$Rd, movz_symbol_g0:$sym, 0)>;

def : InstAlias<"movk $Rd, $sym", (MOVKXi GPR64:$Rd, movk_symbol_g3:$sym, 48), 0>;
def : InstAlias<"movk $Rd, $sym", (MOVKXi GPR64:$Rd, movk_symbol_g2:$sym, 32), 0>;
def : InstAlias<"movk $Rd, $sym", (MOVKXi GPR64:$Rd, movk_symbol_g1:$sym, 16), 0>;
def : InstAlias<"movk $Rd, $sym", (MOVKXi GPR64:$Rd, movk_symbol_g0:$sym, 0), 0>;

def : InstAlias<"movz $Rd, $sym", (MOVZWi GPR32:$Rd, movz_symbol_g1:$sym, 16)>;
def : InstAlias<"movz $Rd, $sym", (MOVZWi GPR32:$Rd, movz_symbol_g0:$sym, 0)>;

def : InstAlias<"movn $Rd, $sym", (MOVNWi GPR32:$Rd, movz_symbol_g1:$sym, 16)>;
def : InstAlias<"movn $Rd, $sym", (MOVNWi GPR32:$Rd, movz_symbol_g0:$sym, 0)>;

def : InstAlias<"movk $Rd, $sym", (MOVKWi GPR32:$Rd, movk_symbol_g1:$sym, 16), 0>;
def : InstAlias<"movk $Rd, $sym", (MOVKWi GPR32:$Rd, movk_symbol_g0:$sym, 0), 0>;

// Final group of aliases covers true "mov $Rd, $imm" cases.
multiclass movw_mov_alias<string basename,Instruction INST, RegisterClass GPR,
                          int width, int shift> {
  def _asmoperand : AsmOperandClass {
    let Name = basename # width # "_lsl" # shift # "MovAlias";
    let PredicateMethod = "is" # basename # "MovAlias<" # width # ", "
                               # shift # ">";
    let RenderMethod = "add" # basename # "MovAliasOperands<" # shift # ">";
  }

  def _movimm : Operand<i32> {
    let ParserMatchClass = !cast<AsmOperandClass>(NAME # "_asmoperand");
  }

  def : InstAlias<"mov $Rd, $imm",
                  (INST GPR:$Rd, !cast<Operand>(NAME # "_movimm"):$imm, shift)>;
}

defm : movw_mov_alias<"MOVZ", MOVZWi, GPR32, 32, 0>;
defm : movw_mov_alias<"MOVZ", MOVZWi, GPR32, 32, 16>;

defm : movw_mov_alias<"MOVZ", MOVZXi, GPR64, 64, 0>;
defm : movw_mov_alias<"MOVZ", MOVZXi, GPR64, 64, 16>;
defm : movw_mov_alias<"MOVZ", MOVZXi, GPR64, 64, 32>;
defm : movw_mov_alias<"MOVZ", MOVZXi, GPR64, 64, 48>;

defm : movw_mov_alias<"MOVN", MOVNWi, GPR32, 32, 0>;
defm : movw_mov_alias<"MOVN", MOVNWi, GPR32, 32, 16>;

defm : movw_mov_alias<"MOVN", MOVNXi, GPR64, 64, 0>;
defm : movw_mov_alias<"MOVN", MOVNXi, GPR64, 64, 16>;
defm : movw_mov_alias<"MOVN", MOVNXi, GPR64, 64, 32>;
defm : movw_mov_alias<"MOVN", MOVNXi, GPR64, 64, 48>;

let isReMaterializable = 1, isCodeGenOnly = 1, isMoveImm = 1,
    isAsCheapAsAMove = 1 in {
// FIXME: The following pseudo instructions are only needed because remat
// cannot handle multiple instructions.  When that changes, we can select
// directly to the real instructions and get rid of these pseudos.

def MOVi32imm
    : Pseudo<(outs GPR32:$dst), (ins i32imm:$src),
             [(set GPR32:$dst, imm:$src)]>,
      Sched<[WriteImm]>;
def MOVi64imm
    : Pseudo<(outs GPR64:$dst), (ins i64imm:$src),
             [(set GPR64:$dst, imm:$src)]>,
      Sched<[WriteImm]>;
} // isReMaterializable, isCodeGenOnly

// If possible, we want to use MOVi32imm even for 64-bit moves. This gives the
// eventual expansion code fewer bits to worry about getting right. Marshalling
// the types is a little tricky though:
def i64imm_32bit : ImmLeaf<i64, [{
  return (Imm & 0xffffffffULL) == static_cast<uint64_t>(Imm);
}]>;

def s64imm_32bit : ImmLeaf<i64, [{
  int64_t Imm64 = static_cast<int64_t>(Imm);
  return Imm64 >= std::numeric_limits<int32_t>::min() &&
         Imm64 <= std::numeric_limits<int32_t>::max();
}]>;

def trunc_imm : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(N->getZExtValue(), SDLoc(N), MVT::i32);
}]>;

def : Pat<(i64 i64imm_32bit:$src),
          (SUBREG_TO_REG (i64 0), (MOVi32imm (trunc_imm imm:$src)), sub_32)>;

// Materialize FP constants via MOVi32imm/MOVi64imm (MachO large code model).
def bitcast_fpimm_to_i32 : SDNodeXForm<fpimm, [{
return CurDAG->getTargetConstant(
  N->getValueAPF().bitcastToAPInt().getZExtValue(), SDLoc(N), MVT::i32);
}]>;

def bitcast_fpimm_to_i64 : SDNodeXForm<fpimm, [{
return CurDAG->getTargetConstant(
  N->getValueAPF().bitcastToAPInt().getZExtValue(), SDLoc(N), MVT::i64);
}]>;


def : Pat<(f32 fpimm:$in),
  (COPY_TO_REGCLASS (MOVi32imm (bitcast_fpimm_to_i32 f32:$in)), FPR32)>;
def : Pat<(f64 fpimm:$in),
  (COPY_TO_REGCLASS (MOVi64imm (bitcast_fpimm_to_i64 f64:$in)), FPR64)>;


// Deal with the various forms of (ELF) large addressing with MOVZ/MOVK
// sequences.
def : Pat<(AArch64WrapperLarge tglobaladdr:$g3, tglobaladdr:$g2,
                             tglobaladdr:$g1, tglobaladdr:$g0),
          (MOVKXi (MOVKXi (MOVKXi (MOVZXi tglobaladdr:$g3, 48),
                                  tglobaladdr:$g2, 32),
                          tglobaladdr:$g1, 16),
                  tglobaladdr:$g0, 0)>;

def : Pat<(AArch64WrapperLarge tblockaddress:$g3, tblockaddress:$g2,
                             tblockaddress:$g1, tblockaddress:$g0),
          (MOVKXi (MOVKXi (MOVKXi (MOVZXi tblockaddress:$g3, 48),
                                  tblockaddress:$g2, 32),
                          tblockaddress:$g1, 16),
                  tblockaddress:$g0, 0)>;

def : Pat<(AArch64WrapperLarge tconstpool:$g3, tconstpool:$g2,
                             tconstpool:$g1, tconstpool:$g0),
          (MOVKXi (MOVKXi (MOVKXi (MOVZXi tconstpool:$g3, 48),
                                  tconstpool:$g2, 32),
                          tconstpool:$g1, 16),
                  tconstpool:$g0, 0)>;

def : Pat<(AArch64WrapperLarge tjumptable:$g3, tjumptable:$g2,
                             tjumptable:$g1, tjumptable:$g0),
          (MOVKXi (MOVKXi (MOVKXi (MOVZXi tjumptable:$g3, 48),
                                  tjumptable:$g2, 32),
                          tjumptable:$g1, 16),
                  tjumptable:$g0, 0)>;


//===----------------------------------------------------------------------===//
// Arithmetic instructions.
//===----------------------------------------------------------------------===//

// Add/subtract with carry.
defm ADC : AddSubCarry<0, "adc", "adcs", AArch64adc, AArch64adc_flag>;
defm SBC : AddSubCarry<1, "sbc", "sbcs", AArch64sbc, AArch64sbc_flag>;

def : InstAlias<"ngc $dst, $src",  (SBCWr  GPR32:$dst, WZR, GPR32:$src)>;
def : InstAlias<"ngc $dst, $src",  (SBCXr  GPR64:$dst, XZR, GPR64:$src)>;
def : InstAlias<"ngcs $dst, $src", (SBCSWr GPR32:$dst, WZR, GPR32:$src)>;
def : InstAlias<"ngcs $dst, $src", (SBCSXr GPR64:$dst, XZR, GPR64:$src)>;

// Add/subtract
defm ADD : AddSub<0, "add", "sub", add>;
defm SUB : AddSub<1, "sub", "add">;

def : InstAlias<"mov $dst, $src",
                (ADDWri GPR32sponly:$dst, GPR32sp:$src, 0, 0)>;
def : InstAlias<"mov $dst, $src",
                (ADDWri GPR32sp:$dst, GPR32sponly:$src, 0, 0)>;
def : InstAlias<"mov $dst, $src",
                (ADDXri GPR64sponly:$dst, GPR64sp:$src, 0, 0)>;
def : InstAlias<"mov $dst, $src",
                (ADDXri GPR64sp:$dst, GPR64sponly:$src, 0, 0)>;

defm ADDS : AddSubS<0, "adds", AArch64add_flag, "cmn", "subs", "cmp">;
defm SUBS : AddSubS<1, "subs", AArch64sub_flag, "cmp", "adds", "cmn">;

// Use SUBS instead of SUB to enable CSE between SUBS and SUB.
def : Pat<(sub GPR32sp:$Rn, addsub_shifted_imm32:$imm),
          (SUBSWri GPR32sp:$Rn, addsub_shifted_imm32:$imm)>;
def : Pat<(sub GPR64sp:$Rn, addsub_shifted_imm64:$imm),
          (SUBSXri GPR64sp:$Rn, addsub_shifted_imm64:$imm)>;
def : Pat<(sub GPR32:$Rn, GPR32:$Rm),
          (SUBSWrr GPR32:$Rn, GPR32:$Rm)>;
def : Pat<(sub GPR64:$Rn, GPR64:$Rm),
          (SUBSXrr GPR64:$Rn, GPR64:$Rm)>;
def : Pat<(sub GPR32:$Rn, arith_shifted_reg32:$Rm),
          (SUBSWrs GPR32:$Rn, arith_shifted_reg32:$Rm)>;
def : Pat<(sub GPR64:$Rn, arith_shifted_reg64:$Rm),
          (SUBSXrs GPR64:$Rn, arith_shifted_reg64:$Rm)>;
let AddedComplexity = 1 in {
def : Pat<(sub GPR32sp:$R2, arith_extended_reg32<i32>:$R3),
          (SUBSWrx GPR32sp:$R2, arith_extended_reg32<i32>:$R3)>;
def : Pat<(sub GPR64sp:$R2, arith_extended_reg32to64<i64>:$R3),
          (SUBSXrx GPR64sp:$R2, arith_extended_reg32to64<i64>:$R3)>;
}

// Because of the immediate format for add/sub-imm instructions, the
// expression (add x, -1) must be transformed to (SUB{W,X}ri x, 1).
//  These patterns capture that transformation.
let AddedComplexity = 1 in {
def : Pat<(add GPR32:$Rn, neg_addsub_shifted_imm32:$imm),
          (SUBSWri GPR32:$Rn, neg_addsub_shifted_imm32:$imm)>;
def : Pat<(add GPR64:$Rn, neg_addsub_shifted_imm64:$imm),
          (SUBSXri GPR64:$Rn, neg_addsub_shifted_imm64:$imm)>;
def : Pat<(sub GPR32:$Rn, neg_addsub_shifted_imm32:$imm),
          (ADDWri GPR32:$Rn, neg_addsub_shifted_imm32:$imm)>;
def : Pat<(sub GPR64:$Rn, neg_addsub_shifted_imm64:$imm),
          (ADDXri GPR64:$Rn, neg_addsub_shifted_imm64:$imm)>;
}

// Because of the immediate format for add/sub-imm instructions, the
// expression (add x, -1) must be transformed to (SUB{W,X}ri x, 1).
//  These patterns capture that transformation.
let AddedComplexity = 1 in {
def : Pat<(AArch64add_flag GPR32:$Rn, neg_addsub_shifted_imm32:$imm),
          (SUBSWri GPR32:$Rn, neg_addsub_shifted_imm32:$imm)>;
def : Pat<(AArch64add_flag GPR64:$Rn, neg_addsub_shifted_imm64:$imm),
          (SUBSXri GPR64:$Rn, neg_addsub_shifted_imm64:$imm)>;
def : Pat<(AArch64sub_flag GPR32:$Rn, neg_addsub_shifted_imm32:$imm),
          (ADDSWri GPR32:$Rn, neg_addsub_shifted_imm32:$imm)>;
def : Pat<(AArch64sub_flag GPR64:$Rn, neg_addsub_shifted_imm64:$imm),
          (ADDSXri GPR64:$Rn, neg_addsub_shifted_imm64:$imm)>;
}

def : InstAlias<"neg $dst, $src", (SUBWrs GPR32:$dst, WZR, GPR32:$src, 0), 3>;
def : InstAlias<"neg $dst, $src", (SUBXrs GPR64:$dst, XZR, GPR64:$src, 0), 3>;
def : InstAlias<"neg $dst, $src$shift",
                (SUBWrs GPR32:$dst, WZR, GPR32:$src, arith_shift32:$shift), 2>;
def : InstAlias<"neg $dst, $src$shift",
                (SUBXrs GPR64:$dst, XZR, GPR64:$src, arith_shift64:$shift), 2>;

def : InstAlias<"negs $dst, $src", (SUBSWrs GPR32:$dst, WZR, GPR32:$src, 0), 3>;
def : InstAlias<"negs $dst, $src", (SUBSXrs GPR64:$dst, XZR, GPR64:$src, 0), 3>;
def : InstAlias<"negs $dst, $src$shift",
                (SUBSWrs GPR32:$dst, WZR, GPR32:$src, arith_shift32:$shift), 2>;
def : InstAlias<"negs $dst, $src$shift",
                (SUBSXrs GPR64:$dst, XZR, GPR64:$src, arith_shift64:$shift), 2>;


// Unsigned/Signed divide
defm UDIV : Div<0, "udiv", udiv>;
defm SDIV : Div<1, "sdiv", sdiv>;

def : Pat<(int_aarch64_udiv GPR32:$Rn, GPR32:$Rm), (UDIVWr $Rn, $Rm)>;
def : Pat<(int_aarch64_udiv GPR64:$Rn, GPR64:$Rm), (UDIVXr $Rn, $Rm)>;
def : Pat<(int_aarch64_sdiv GPR32:$Rn, GPR32:$Rm), (SDIVWr $Rn, $Rm)>;
def : Pat<(int_aarch64_sdiv GPR64:$Rn, GPR64:$Rm), (SDIVXr $Rn, $Rm)>;

// Variable shift
defm ASRV : Shift<0b10, "asr", sra>;
defm LSLV : Shift<0b00, "lsl", shl>;
defm LSRV : Shift<0b01, "lsr", srl>;
defm RORV : Shift<0b11, "ror", rotr>;

def : ShiftAlias<"asrv", ASRVWr, GPR32>;
def : ShiftAlias<"asrv", ASRVXr, GPR64>;
def : ShiftAlias<"lslv", LSLVWr, GPR32>;
def : ShiftAlias<"lslv", LSLVXr, GPR64>;
def : ShiftAlias<"lsrv", LSRVWr, GPR32>;
def : ShiftAlias<"lsrv", LSRVXr, GPR64>;
def : ShiftAlias<"rorv", RORVWr, GPR32>;
def : ShiftAlias<"rorv", RORVXr, GPR64>;

// Multiply-add
let AddedComplexity = 7 in {
defm MADD : MulAccum<0, "madd", add>;
defm MSUB : MulAccum<1, "msub", sub>;

def : Pat<(i32 (mul GPR32:$Rn, GPR32:$Rm)),
          (MADDWrrr GPR32:$Rn, GPR32:$Rm, WZR)>;
def : Pat<(i64 (mul GPR64:$Rn, GPR64:$Rm)),
          (MADDXrrr GPR64:$Rn, GPR64:$Rm, XZR)>;

def : Pat<(i32 (ineg (mul GPR32:$Rn, GPR32:$Rm))),
          (MSUBWrrr GPR32:$Rn, GPR32:$Rm, WZR)>;
def : Pat<(i64 (ineg (mul GPR64:$Rn, GPR64:$Rm))),
          (MSUBXrrr GPR64:$Rn, GPR64:$Rm, XZR)>;
def : Pat<(i32 (mul (ineg GPR32:$Rn), GPR32:$Rm)),
          (MSUBWrrr GPR32:$Rn, GPR32:$Rm, WZR)>;
def : Pat<(i64 (mul (ineg GPR64:$Rn), GPR64:$Rm)),
          (MSUBXrrr GPR64:$Rn, GPR64:$Rm, XZR)>;
} // AddedComplexity = 7

let AddedComplexity = 5 in {
def SMADDLrrr : WideMulAccum<0, 0b001, "smaddl", add, sext>;
def SMSUBLrrr : WideMulAccum<1, 0b001, "smsubl", sub, sext>;
def UMADDLrrr : WideMulAccum<0, 0b101, "umaddl", add, zext>;
def UMSUBLrrr : WideMulAccum<1, 0b101, "umsubl", sub, zext>;

def : Pat<(i64 (mul (sext GPR32:$Rn), (sext GPR32:$Rm))),
          (SMADDLrrr GPR32:$Rn, GPR32:$Rm, XZR)>;
def : Pat<(i64 (mul (zext GPR32:$Rn), (zext GPR32:$Rm))),
          (UMADDLrrr GPR32:$Rn, GPR32:$Rm, XZR)>;

def : Pat<(i64 (ineg (mul (sext GPR32:$Rn), (sext GPR32:$Rm)))),
          (SMSUBLrrr GPR32:$Rn, GPR32:$Rm, XZR)>;
def : Pat<(i64 (ineg (mul (zext GPR32:$Rn), (zext GPR32:$Rm)))),
          (UMSUBLrrr GPR32:$Rn, GPR32:$Rm, XZR)>;

def : Pat<(i64 (mul (sext GPR32:$Rn), (s64imm_32bit:$C))),
          (SMADDLrrr GPR32:$Rn, (MOVi32imm (trunc_imm imm:$C)), XZR)>;
def : Pat<(i64 (mul (zext GPR32:$Rn), (i64imm_32bit:$C))),
          (UMADDLrrr GPR32:$Rn, (MOVi32imm (trunc_imm imm:$C)), XZR)>;
def : Pat<(i64 (mul (sext_inreg GPR64:$Rn, i32), (s64imm_32bit:$C))),
          (SMADDLrrr (i32 (EXTRACT_SUBREG GPR64:$Rn, sub_32)),
                     (MOVi32imm (trunc_imm imm:$C)), XZR)>;

def : Pat<(i64 (ineg (mul (sext GPR32:$Rn), (s64imm_32bit:$C)))),
          (SMSUBLrrr GPR32:$Rn, (MOVi32imm (trunc_imm imm:$C)), XZR)>;
def : Pat<(i64 (ineg (mul (zext GPR32:$Rn), (i64imm_32bit:$C)))),
          (UMSUBLrrr GPR32:$Rn, (MOVi32imm (trunc_imm imm:$C)), XZR)>;
def : Pat<(i64 (ineg (mul (sext_inreg GPR64:$Rn, i32), (s64imm_32bit:$C)))),
          (SMSUBLrrr (i32 (EXTRACT_SUBREG GPR64:$Rn, sub_32)),
                     (MOVi32imm (trunc_imm imm:$C)), XZR)>;

def : Pat<(i64 (add (mul (sext GPR32:$Rn), (s64imm_32bit:$C)), GPR64:$Ra)),
          (SMADDLrrr GPR32:$Rn, (MOVi32imm (trunc_imm imm:$C)), GPR64:$Ra)>;
def : Pat<(i64 (add (mul (zext GPR32:$Rn), (i64imm_32bit:$C)), GPR64:$Ra)),
          (UMADDLrrr GPR32:$Rn, (MOVi32imm (trunc_imm imm:$C)), GPR64:$Ra)>;
def : Pat<(i64 (add (mul (sext_inreg GPR64:$Rn, i32), (s64imm_32bit:$C)),
                    GPR64:$Ra)),
          (SMADDLrrr (i32 (EXTRACT_SUBREG GPR64:$Rn, sub_32)),
                     (MOVi32imm (trunc_imm imm:$C)), GPR64:$Ra)>;

def : Pat<(i64 (sub GPR64:$Ra, (mul (sext GPR32:$Rn), (s64imm_32bit:$C)))),
          (SMSUBLrrr GPR32:$Rn, (MOVi32imm (trunc_imm imm:$C)), GPR64:$Ra)>;
def : Pat<(i64 (sub GPR64:$Ra, (mul (zext GPR32:$Rn), (i64imm_32bit:$C)))),
          (UMSUBLrrr GPR32:$Rn, (MOVi32imm (trunc_imm imm:$C)), GPR64:$Ra)>;
def : Pat<(i64 (sub GPR64:$Ra, (mul (sext_inreg GPR64:$Rn, i32),
                                    (s64imm_32bit:$C)))),
          (SMSUBLrrr (i32 (EXTRACT_SUBREG GPR64:$Rn, sub_32)),
                     (MOVi32imm (trunc_imm imm:$C)), GPR64:$Ra)>;
} // AddedComplexity = 5

def : MulAccumWAlias<"mul", MADDWrrr>;
def : MulAccumXAlias<"mul", MADDXrrr>;
def : MulAccumWAlias<"mneg", MSUBWrrr>;
def : MulAccumXAlias<"mneg", MSUBXrrr>;
def : WideMulAccumAlias<"smull", SMADDLrrr>;
def : WideMulAccumAlias<"smnegl", SMSUBLrrr>;
def : WideMulAccumAlias<"umull", UMADDLrrr>;
def : WideMulAccumAlias<"umnegl", UMSUBLrrr>;

// Multiply-high
def SMULHrr : MulHi<0b010, "smulh", mulhs>;
def UMULHrr : MulHi<0b110, "umulh", mulhu>;

// CRC32
def CRC32Brr : BaseCRC32<0, 0b00, 0, GPR32, int_aarch64_crc32b, "crc32b">;
def CRC32Hrr : BaseCRC32<0, 0b01, 0, GPR32, int_aarch64_crc32h, "crc32h">;
def CRC32Wrr : BaseCRC32<0, 0b10, 0, GPR32, int_aarch64_crc32w, "crc32w">;
def CRC32Xrr : BaseCRC32<1, 0b11, 0, GPR64, int_aarch64_crc32x, "crc32x">;

def CRC32CBrr : BaseCRC32<0, 0b00, 1, GPR32, int_aarch64_crc32cb, "crc32cb">;
def CRC32CHrr : BaseCRC32<0, 0b01, 1, GPR32, int_aarch64_crc32ch, "crc32ch">;
def CRC32CWrr : BaseCRC32<0, 0b10, 1, GPR32, int_aarch64_crc32cw, "crc32cw">;
def CRC32CXrr : BaseCRC32<1, 0b11, 1, GPR64, int_aarch64_crc32cx, "crc32cx">;

// v8.1 atomic CAS
defm CAS   : CompareAndSwap<0, 0, "">;
defm CASA  : CompareAndSwap<1, 0, "a">;
defm CASL  : CompareAndSwap<0, 1, "l">;
defm CASAL : CompareAndSwap<1, 1, "al">;

// v8.1 atomic CASP
defm CASP   : CompareAndSwapPair<0, 0, "">;
defm CASPA  : CompareAndSwapPair<1, 0, "a">;
defm CASPL  : CompareAndSwapPair<0, 1, "l">;
defm CASPAL : CompareAndSwapPair<1, 1, "al">;

// v8.1 atomic SWP
defm SWP   : Swap<0, 0, "">;
defm SWPA  : Swap<1, 0, "a">;
defm SWPL  : Swap<0, 1, "l">;
defm SWPAL : Swap<1, 1, "al">;

// v8.1 atomic LD<OP>(register). Performs load and then ST<OP>(register)
defm LDADD   : LDOPregister<0b000, "add", 0, 0, "">;
defm LDADDA  : LDOPregister<0b000, "add", 1, 0, "a">;
defm LDADDL  : LDOPregister<0b000, "add", 0, 1, "l">;
defm LDADDAL : LDOPregister<0b000, "add", 1, 1, "al">;

defm LDCLR   : LDOPregister<0b001, "clr", 0, 0, "">;
defm LDCLRA  : LDOPregister<0b001, "clr", 1, 0, "a">;
defm LDCLRL  : LDOPregister<0b001, "clr", 0, 1, "l">;
defm LDCLRAL : LDOPregister<0b001, "clr", 1, 1, "al">;

defm LDEOR   : LDOPregister<0b010, "eor", 0, 0, "">;
defm LDEORA  : LDOPregister<0b010, "eor", 1, 0, "a">;
defm LDEORL  : LDOPregister<0b010, "eor", 0, 1, "l">;
defm LDEORAL : LDOPregister<0b010, "eor", 1, 1, "al">;

defm LDSET   : LDOPregister<0b011, "set", 0, 0, "">;
defm LDSETA  : LDOPregister<0b011, "set", 1, 0, "a">;
defm LDSETL  : LDOPregister<0b011, "set", 0, 1, "l">;
defm LDSETAL : LDOPregister<0b011, "set", 1, 1, "al">;

defm LDSMAX   : LDOPregister<0b100, "smax", 0, 0, "">;
defm LDSMAXA  : LDOPregister<0b100, "smax", 1, 0, "a">;
defm LDSMAXL  : LDOPregister<0b100, "smax", 0, 1, "l">;
defm LDSMAXAL : LDOPregister<0b100, "smax", 1, 1, "al">;

defm LDSMIN   : LDOPregister<0b101, "smin", 0, 0, "">;
defm LDSMINA  : LDOPregister<0b101, "smin", 1, 0, "a">;
defm LDSMINL  : LDOPregister<0b101, "smin", 0, 1, "l">;
defm LDSMINAL : LDOPregister<0b101, "smin", 1, 1, "al">;

defm LDUMAX   : LDOPregister<0b110, "umax", 0, 0, "">;
defm LDUMAXA  : LDOPregister<0b110, "umax", 1, 0, "a">;
defm LDUMAXL  : LDOPregister<0b110, "umax", 0, 1, "l">;
defm LDUMAXAL : LDOPregister<0b110, "umax", 1, 1, "al">;

defm LDUMIN   : LDOPregister<0b111, "umin", 0, 0, "">;
defm LDUMINA  : LDOPregister<0b111, "umin", 1, 0, "a">;
defm LDUMINL  : LDOPregister<0b111, "umin", 0, 1, "l">;
defm LDUMINAL : LDOPregister<0b111, "umin", 1, 1, "al">;

// v8.1 atomic ST<OP>(register) as aliases to "LD<OP>(register) when Rt=xZR"
defm : STOPregister<"stadd","LDADD">; // STADDx
defm : STOPregister<"stclr","LDCLR">; // STCLRx
defm : STOPregister<"steor","LDEOR">; // STEORx
defm : STOPregister<"stset","LDSET">; // STSETx
defm : STOPregister<"stsmax","LDSMAX">;// STSMAXx
defm : STOPregister<"stsmin","LDSMIN">;// STSMINx
defm : STOPregister<"stumax","LDUMAX">;// STUMAXx
defm : STOPregister<"stumin","LDUMIN">;// STUMINx

//===----------------------------------------------------------------------===//
// Logical instructions.
//===----------------------------------------------------------------------===//

// (immediate)
defm ANDS : LogicalImmS<0b11, "ands", AArch64and_flag, "bics">;
defm AND  : LogicalImm<0b00, "and", and, "bic">;
defm EOR  : LogicalImm<0b10, "eor", xor, "eon">;
defm ORR  : LogicalImm<0b01, "orr", or, "orn">;

// FIXME: these aliases *are* canonical sometimes (when movz can't be
// used). Actually, it seems to be working right now, but putting logical_immXX
// here is a bit dodgy on the AsmParser side too.
def : InstAlias<"mov $dst, $imm", (ORRWri GPR32sp:$dst, WZR,
                                          logical_imm32:$imm), 0>;
def : InstAlias<"mov $dst, $imm", (ORRXri GPR64sp:$dst, XZR,
                                          logical_imm64:$imm), 0>;


// (register)
defm ANDS : LogicalRegS<0b11, 0, "ands", AArch64and_flag>;
defm BICS : LogicalRegS<0b11, 1, "bics",
                        BinOpFrag<(AArch64and_flag node:$LHS, (not node:$RHS))>>;
defm AND  : LogicalReg<0b00, 0, "and", and>;
defm BIC  : LogicalReg<0b00, 1, "bic",
                       BinOpFrag<(and node:$LHS, (not node:$RHS))>>;
defm EON  : LogicalReg<0b10, 1, "eon",
                       BinOpFrag<(not (xor node:$LHS, node:$RHS))>>;
defm EOR  : LogicalReg<0b10, 0, "eor", xor>;
defm ORN  : LogicalReg<0b01, 1, "orn",
                       BinOpFrag<(or node:$LHS, (not node:$RHS))>>;
defm ORR  : LogicalReg<0b01, 0, "orr", or>;

def : InstAlias<"mov $dst, $src", (ORRWrs GPR32:$dst, WZR, GPR32:$src, 0), 2>;
def : InstAlias<"mov $dst, $src", (ORRXrs GPR64:$dst, XZR, GPR64:$src, 0), 2>;

def : InstAlias<"mvn $Wd, $Wm", (ORNWrs GPR32:$Wd, WZR, GPR32:$Wm, 0), 3>;
def : InstAlias<"mvn $Xd, $Xm", (ORNXrs GPR64:$Xd, XZR, GPR64:$Xm, 0), 3>;

def : InstAlias<"mvn $Wd, $Wm$sh",
                (ORNWrs GPR32:$Wd, WZR, GPR32:$Wm, logical_shift32:$sh), 2>;
def : InstAlias<"mvn $Xd, $Xm$sh",
                (ORNXrs GPR64:$Xd, XZR, GPR64:$Xm, logical_shift64:$sh), 2>;

def : InstAlias<"tst $src1, $src2",
                (ANDSWri WZR, GPR32:$src1, logical_imm32:$src2), 2>;
def : InstAlias<"tst $src1, $src2",
                (ANDSXri XZR, GPR64:$src1, logical_imm64:$src2), 2>;

def : InstAlias<"tst $src1, $src2",
                        (ANDSWrs WZR, GPR32:$src1, GPR32:$src2, 0), 3>;
def : InstAlias<"tst $src1, $src2",
                        (ANDSXrs XZR, GPR64:$src1, GPR64:$src2, 0), 3>;

def : InstAlias<"tst $src1, $src2$sh",
               (ANDSWrs WZR, GPR32:$src1, GPR32:$src2, logical_shift32:$sh), 2>;
def : InstAlias<"tst $src1, $src2$sh",
               (ANDSXrs XZR, GPR64:$src1, GPR64:$src2, logical_shift64:$sh), 2>;


def : Pat<(not GPR32:$Wm), (ORNWrr WZR, GPR32:$Wm)>;
def : Pat<(not GPR64:$Xm), (ORNXrr XZR, GPR64:$Xm)>;


//===----------------------------------------------------------------------===//
// One operand data processing instructions.
//===----------------------------------------------------------------------===//

defm CLS    : OneOperandData<0b101, "cls">;
defm CLZ    : OneOperandData<0b100, "clz", ctlz>;
defm RBIT   : OneOperandData<0b000, "rbit">;

def : Pat<(int_aarch64_rbit GPR32:$Rn), (RBITWr $Rn)>;
def : Pat<(int_aarch64_rbit GPR64:$Rn), (RBITXr $Rn)>;

def  REV16Wr : OneWRegData<0b001, "rev16",
                                  UnOpFrag<(rotr (bswap node:$LHS), (i64 16))>>;
def  REV16Xr : OneXRegData<0b001, "rev16", null_frag>;

def : Pat<(cttz GPR32:$Rn),
          (CLZWr (RBITWr GPR32:$Rn))>;
def : Pat<(cttz GPR64:$Rn),
          (CLZXr (RBITXr GPR64:$Rn))>;
def : Pat<(ctlz (or (shl (xor (sra GPR32:$Rn, (i64 31)), GPR32:$Rn), (i64 1)),
                (i32 1))),
          (CLSWr GPR32:$Rn)>;
def : Pat<(ctlz (or (shl (xor (sra GPR64:$Rn, (i64 63)), GPR64:$Rn), (i64 1)),
                (i64 1))),
          (CLSXr GPR64:$Rn)>;

// Unlike the other one operand instructions, the instructions with the "rev"
// mnemonic do *not* just different in the size bit, but actually use different
// opcode bits for the different sizes.
def REVWr   : OneWRegData<0b010, "rev", bswap>;
def REVXr   : OneXRegData<0b011, "rev", bswap>;
def REV32Xr : OneXRegData<0b010, "rev32",
                                 UnOpFrag<(rotr (bswap node:$LHS), (i64 32))>>;

def : InstAlias<"rev64 $Rd, $Rn", (REVXr GPR64:$Rd, GPR64:$Rn), 0>;

// The bswap commutes with the rotr so we want a pattern for both possible
// orders.
def : Pat<(bswap (rotr GPR32:$Rn, (i64 16))), (REV16Wr GPR32:$Rn)>;
def : Pat<(bswap (rotr GPR64:$Rn, (i64 32))), (REV32Xr GPR64:$Rn)>;

//===----------------------------------------------------------------------===//
// Bitfield immediate extraction instruction.
//===----------------------------------------------------------------------===//
let hasSideEffects = 0 in
defm EXTR : ExtractImm<"extr">;
def : InstAlias<"ror $dst, $src, $shift",
            (EXTRWrri GPR32:$dst, GPR32:$src, GPR32:$src, imm0_31:$shift)>;
def : InstAlias<"ror $dst, $src, $shift",
            (EXTRXrri GPR64:$dst, GPR64:$src, GPR64:$src, imm0_63:$shift)>;

def : Pat<(rotr GPR32:$Rn, (i64 imm0_31:$imm)),
          (EXTRWrri GPR32:$Rn, GPR32:$Rn, imm0_31:$imm)>;
def : Pat<(rotr GPR64:$Rn, (i64 imm0_63:$imm)),
          (EXTRXrri GPR64:$Rn, GPR64:$Rn, imm0_63:$imm)>;

//===----------------------------------------------------------------------===//
// Other bitfield immediate instructions.
//===----------------------------------------------------------------------===//
let hasSideEffects = 0 in {
defm BFM  : BitfieldImmWith2RegArgs<0b01, "bfm">;
defm SBFM : BitfieldImm<0b00, "sbfm">;
defm UBFM : BitfieldImm<0b10, "ubfm">;
}

def i32shift_a : Operand<i64>, SDNodeXForm<imm, [{
  uint64_t enc = (32 - N->getZExtValue()) & 0x1f;
  return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i64);
}]>;

def i32shift_b : Operand<i64>, SDNodeXForm<imm, [{
  uint64_t enc = 31 - N->getZExtValue();
  return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i64);
}]>;

// min(7, 31 - shift_amt)
def i32shift_sext_i8 : Operand<i64>, SDNodeXForm<imm, [{
  uint64_t enc = 31 - N->getZExtValue();
  enc = enc > 7 ? 7 : enc;
  return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i64);
}]>;

// min(15, 31 - shift_amt)
def i32shift_sext_i16 : Operand<i64>, SDNodeXForm<imm, [{
  uint64_t enc = 31 - N->getZExtValue();
  enc = enc > 15 ? 15 : enc;
  return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i64);
}]>;

def i64shift_a : Operand<i64>, SDNodeXForm<imm, [{
  uint64_t enc = (64 - N->getZExtValue()) & 0x3f;
  return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i64);
}]>;

def i64shift_b : Operand<i64>, SDNodeXForm<imm, [{
  uint64_t enc = 63 - N->getZExtValue();
  return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i64);
}]>;

// min(7, 63 - shift_amt)
def i64shift_sext_i8 : Operand<i64>, SDNodeXForm<imm, [{
  uint64_t enc = 63 - N->getZExtValue();
  enc = enc > 7 ? 7 : enc;
  return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i64);
}]>;

// min(15, 63 - shift_amt)
def i64shift_sext_i16 : Operand<i64>, SDNodeXForm<imm, [{
  uint64_t enc = 63 - N->getZExtValue();
  enc = enc > 15 ? 15 : enc;
  return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i64);
}]>;

// min(31, 63 - shift_amt)
def i64shift_sext_i32 : Operand<i64>, SDNodeXForm<imm, [{
  uint64_t enc = 63 - N->getZExtValue();
  enc = enc > 31 ? 31 : enc;
  return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i64);
}]>;

def : Pat<(shl GPR32:$Rn, (i64 imm0_31:$imm)),
          (UBFMWri GPR32:$Rn, (i64 (i32shift_a imm0_31:$imm)),
                              (i64 (i32shift_b imm0_31:$imm)))>;
def : Pat<(shl GPR64:$Rn, (i64 imm0_63:$imm)),
          (UBFMXri GPR64:$Rn, (i64 (i64shift_a imm0_63:$imm)),
                              (i64 (i64shift_b imm0_63:$imm)))>;

let AddedComplexity = 10 in {
def : Pat<(sra GPR32:$Rn, (i64 imm0_31:$imm)),
          (SBFMWri GPR32:$Rn, imm0_31:$imm, 31)>;
def : Pat<(sra GPR64:$Rn, (i64 imm0_63:$imm)),
          (SBFMXri GPR64:$Rn, imm0_63:$imm, 63)>;
}

def : InstAlias<"asr $dst, $src, $shift",
                (SBFMWri GPR32:$dst, GPR32:$src, imm0_31:$shift, 31)>;
def : InstAlias<"asr $dst, $src, $shift",
                (SBFMXri GPR64:$dst, GPR64:$src, imm0_63:$shift, 63)>;
def : InstAlias<"sxtb $dst, $src", (SBFMWri GPR32:$dst, GPR32:$src, 0, 7)>;
def : InstAlias<"sxtb $dst, $src", (SBFMXri GPR64:$dst, GPR64:$src, 0, 7)>;
def : InstAlias<"sxth $dst, $src", (SBFMWri GPR32:$dst, GPR32:$src, 0, 15)>;
def : InstAlias<"sxth $dst, $src", (SBFMXri GPR64:$dst, GPR64:$src, 0, 15)>;
def : InstAlias<"sxtw $dst, $src", (SBFMXri GPR64:$dst, GPR64:$src, 0, 31)>;

def : Pat<(srl GPR32:$Rn, (i64 imm0_31:$imm)),
          (UBFMWri GPR32:$Rn, imm0_31:$imm, 31)>;
def : Pat<(srl GPR64:$Rn, (i64 imm0_63:$imm)),
          (UBFMXri GPR64:$Rn, imm0_63:$imm, 63)>;

def : InstAlias<"lsr $dst, $src, $shift",
                (UBFMWri GPR32:$dst, GPR32:$src, imm0_31:$shift, 31)>;
def : InstAlias<"lsr $dst, $src, $shift",
                (UBFMXri GPR64:$dst, GPR64:$src, imm0_63:$shift, 63)>;
def : InstAlias<"uxtb $dst, $src", (UBFMWri GPR32:$dst, GPR32:$src, 0, 7)>;
def : InstAlias<"uxtb $dst, $src", (UBFMXri GPR64:$dst, GPR64:$src, 0, 7)>;
def : InstAlias<"uxth $dst, $src", (UBFMWri GPR32:$dst, GPR32:$src, 0, 15)>;
def : InstAlias<"uxth $dst, $src", (UBFMXri GPR64:$dst, GPR64:$src, 0, 15)>;
def : InstAlias<"uxtw $dst, $src", (UBFMXri GPR64:$dst, GPR64:$src, 0, 31)>;

//===----------------------------------------------------------------------===//
// Conditional comparison instructions.
//===----------------------------------------------------------------------===//
defm CCMN : CondComparison<0, "ccmn", AArch64ccmn>;
defm CCMP : CondComparison<1, "ccmp", AArch64ccmp>;

//===----------------------------------------------------------------------===//
// Conditional select instructions.
//===----------------------------------------------------------------------===//
defm CSEL  : CondSelect<0, 0b00, "csel">;

def inc : PatFrag<(ops node:$in), (add node:$in, 1)>;
defm CSINC : CondSelectOp<0, 0b01, "csinc", inc>;
defm CSINV : CondSelectOp<1, 0b00, "csinv", not>;
defm CSNEG : CondSelectOp<1, 0b01, "csneg", ineg>;

def : Pat<(AArch64csinv GPR32:$tval, GPR32:$fval, (i32 imm:$cc), NZCV),
          (CSINVWr GPR32:$tval, GPR32:$fval, (i32 imm:$cc))>;
def : Pat<(AArch64csinv GPR64:$tval, GPR64:$fval, (i32 imm:$cc), NZCV),
          (CSINVXr GPR64:$tval, GPR64:$fval, (i32 imm:$cc))>;
def : Pat<(AArch64csneg GPR32:$tval, GPR32:$fval, (i32 imm:$cc), NZCV),
          (CSNEGWr GPR32:$tval, GPR32:$fval, (i32 imm:$cc))>;
def : Pat<(AArch64csneg GPR64:$tval, GPR64:$fval, (i32 imm:$cc), NZCV),
          (CSNEGXr GPR64:$tval, GPR64:$fval, (i32 imm:$cc))>;
def : Pat<(AArch64csinc GPR32:$tval, GPR32:$fval, (i32 imm:$cc), NZCV),
          (CSINCWr GPR32:$tval, GPR32:$fval, (i32 imm:$cc))>;
def : Pat<(AArch64csinc GPR64:$tval, GPR64:$fval, (i32 imm:$cc), NZCV),
          (CSINCXr GPR64:$tval, GPR64:$fval, (i32 imm:$cc))>;

def : Pat<(AArch64csel (i32 0), (i32 1), (i32 imm:$cc), NZCV),
          (CSINCWr WZR, WZR, (i32 imm:$cc))>;
def : Pat<(AArch64csel (i64 0), (i64 1), (i32 imm:$cc), NZCV),
          (CSINCXr XZR, XZR, (i32 imm:$cc))>;
def : Pat<(AArch64csel (i32 0), (i32 -1), (i32 imm:$cc), NZCV),
          (CSINVWr WZR, WZR, (i32 imm:$cc))>;
def : Pat<(AArch64csel (i64 0), (i64 -1), (i32 imm:$cc), NZCV),
          (CSINVXr XZR, XZR, (i32 imm:$cc))>;
def : Pat<(AArch64csel GPR32:$tval, (i32 -1), (i32 imm:$cc), NZCV),
          (CSINVWr GPR32:$tval, WZR, (i32 imm:$cc))>;
def : Pat<(AArch64csel GPR64:$tval, (i64 -1), (i32 imm:$cc), NZCV),
          (CSINVXr GPR64:$tval, XZR, (i32 imm:$cc))>;
def : Pat<(AArch64csel (i32 -1), GPR32:$fval, (i32 imm:$cc), NZCV),
          (CSINVWr GPR32:$fval, WZR, (i32 (inv_cond_XFORM imm:$cc)))>;
def : Pat<(AArch64csel (i64 -1), GPR64:$fval, (i32 imm:$cc), NZCV),
          (CSINVXr GPR64:$fval, XZR, (i32 (inv_cond_XFORM imm:$cc)))>;

// The inverse of the condition code from the alias instruction is what is used
// in the aliased instruction. The parser all ready inverts the condition code
// for these aliases.
def : InstAlias<"cset $dst, $cc",
                (CSINCWr GPR32:$dst, WZR, WZR, inv_ccode:$cc)>;
def : InstAlias<"cset $dst, $cc",
                (CSINCXr GPR64:$dst, XZR, XZR, inv_ccode:$cc)>;

def : InstAlias<"csetm $dst, $cc",
                (CSINVWr GPR32:$dst, WZR, WZR, inv_ccode:$cc)>;
def : InstAlias<"csetm $dst, $cc",
                (CSINVXr GPR64:$dst, XZR, XZR, inv_ccode:$cc)>;

def : InstAlias<"cinc $dst, $src, $cc",
                (CSINCWr GPR32:$dst, GPR32:$src, GPR32:$src, inv_ccode:$cc)>;
def : InstAlias<"cinc $dst, $src, $cc",
                (CSINCXr GPR64:$dst, GPR64:$src, GPR64:$src, inv_ccode:$cc)>;

def : InstAlias<"cinv $dst, $src, $cc",
                (CSINVWr GPR32:$dst, GPR32:$src, GPR32:$src, inv_ccode:$cc)>;
def : InstAlias<"cinv $dst, $src, $cc",
                (CSINVXr GPR64:$dst, GPR64:$src, GPR64:$src, inv_ccode:$cc)>;

def : InstAlias<"cneg $dst, $src, $cc",
                (CSNEGWr GPR32:$dst, GPR32:$src, GPR32:$src, inv_ccode:$cc)>;
def : InstAlias<"cneg $dst, $src, $cc",
                (CSNEGXr GPR64:$dst, GPR64:$src, GPR64:$src, inv_ccode:$cc)>;

//===----------------------------------------------------------------------===//
// PC-relative instructions.
//===----------------------------------------------------------------------===//
let isReMaterializable = 1 in {
let hasSideEffects = 0, mayStore = 0, mayLoad = 0 in {
def ADR  : ADRI<0, "adr", adrlabel, []>;
} // hasSideEffects = 0

def ADRP : ADRI<1, "adrp", adrplabel,
                [(set GPR64:$Xd, (AArch64adrp tglobaladdr:$label))]>;
} // isReMaterializable = 1

// page address of a constant pool entry, block address
def : Pat<(AArch64adrp tconstpool:$cp), (ADRP tconstpool:$cp)>;
def : Pat<(AArch64adrp tblockaddress:$cp), (ADRP tblockaddress:$cp)>;

//===----------------------------------------------------------------------===//
// Unconditional branch (register) instructions.
//===----------------------------------------------------------------------===//

let isReturn = 1, isTerminator = 1, isBarrier = 1 in {
def RET  : BranchReg<0b0010, "ret", []>;
def DRPS : SpecialReturn<0b0101, "drps">;
def ERET : SpecialReturn<0b0100, "eret">;
} // isReturn = 1, isTerminator = 1, isBarrier = 1

// Default to the LR register.
def : InstAlias<"ret", (RET LR)>;

let isCall = 1, Defs = [LR], Uses = [SP] in {
def BLR : BranchReg<0b0001, "blr", [(AArch64call GPR64:$Rn)]>;
} // isCall

let isBranch = 1, isTerminator = 1, isBarrier = 1, isIndirectBranch = 1 in {
def BR  : BranchReg<0b0000, "br", [(brind GPR64:$Rn)]>;
} // isBranch, isTerminator, isBarrier, isIndirectBranch

// Create a separate pseudo-instruction for codegen to use so that we don't
// flag lr as used in every function. It'll be restored before the RET by the
// epilogue if it's legitimately used.
def RET_ReallyLR : Pseudo<(outs), (ins), [(AArch64retflag)]>,
                   Sched<[WriteBrReg]> {
  let isTerminator = 1;
  let isBarrier = 1;
  let isReturn = 1;
}

// This is a directive-like pseudo-instruction. The purpose is to insert an
// R_AARCH64_TLSDESC_CALL relocation at the offset of the following instruction
// (which in the usual case is a BLR).
let hasSideEffects = 1 in
def TLSDESCCALL : Pseudo<(outs), (ins i64imm:$sym), []>, Sched<[]> {
  let AsmString = ".tlsdesccall $sym";
}

// FIXME: maybe the scratch register used shouldn't be fixed to X1?
// FIXME: can "hasSideEffects be dropped?
let isCall = 1, Defs = [LR, X0, X1], hasSideEffects = 1,
    isCodeGenOnly = 1 in
def TLSDESC_CALLSEQ
    : Pseudo<(outs), (ins i64imm:$sym),
             [(AArch64tlsdesc_callseq tglobaltlsaddr:$sym)]>,
      Sched<[WriteI, WriteLD, WriteI, WriteBrReg]>;
def : Pat<(AArch64tlsdesc_callseq texternalsym:$sym),
          (TLSDESC_CALLSEQ texternalsym:$sym)>;

//===----------------------------------------------------------------------===//
// Conditional branch (immediate) instruction.
//===----------------------------------------------------------------------===//
def Bcc : BranchCond;

//===----------------------------------------------------------------------===//
// Compare-and-branch instructions.
//===----------------------------------------------------------------------===//
defm CBZ  : CmpBranch<0, "cbz", AArch64cbz>;
defm CBNZ : CmpBranch<1, "cbnz", AArch64cbnz>;

//===----------------------------------------------------------------------===//
// Test-bit-and-branch instructions.
//===----------------------------------------------------------------------===//
defm TBZ  : TestBranch<0, "tbz", AArch64tbz>;
defm TBNZ : TestBranch<1, "tbnz", AArch64tbnz>;

//===----------------------------------------------------------------------===//
// Unconditional branch (immediate) instructions.
//===----------------------------------------------------------------------===//
let isBranch = 1, isTerminator = 1, isBarrier = 1 in {
def B  : BranchImm<0, "b", [(br bb:$addr)]>;
} // isBranch, isTerminator, isBarrier

let isCall = 1, Defs = [LR], Uses = [SP] in {
def BL : CallImm<1, "bl", [(AArch64call tglobaladdr:$addr)]>;
} // isCall
def : Pat<(AArch64call texternalsym:$func), (BL texternalsym:$func)>;

//===----------------------------------------------------------------------===//
// Exception generation instructions.
//===----------------------------------------------------------------------===//
def BRK   : ExceptionGeneration<0b001, 0b00, "brk">;
def DCPS1 : ExceptionGeneration<0b101, 0b01, "dcps1">;
def DCPS2 : ExceptionGeneration<0b101, 0b10, "dcps2">;
def DCPS3 : ExceptionGeneration<0b101, 0b11, "dcps3">;
def HLT   : ExceptionGeneration<0b010, 0b00, "hlt">;
def HVC   : ExceptionGeneration<0b000, 0b10, "hvc">;
def SMC   : ExceptionGeneration<0b000, 0b11, "smc">;
def SVC   : ExceptionGeneration<0b000, 0b01, "svc">;

// DCPSn defaults to an immediate operand of zero if unspecified.
def : InstAlias<"dcps1", (DCPS1 0)>;
def : InstAlias<"dcps2", (DCPS2 0)>;
def : InstAlias<"dcps3", (DCPS3 0)>;

//===----------------------------------------------------------------------===//
// Load instructions.
//===----------------------------------------------------------------------===//

// Pair (indexed, offset)
defm LDPW : LoadPairOffset<0b00, 0, GPR32, simm7s4, "ldp">;
defm LDPX : LoadPairOffset<0b10, 0, GPR64, simm7s8, "ldp">;
defm LDPS : LoadPairOffset<0b00, 1, FPR32, simm7s4, "ldp">;
defm LDPD : LoadPairOffset<0b01, 1, FPR64, simm7s8, "ldp">;
defm LDPQ : LoadPairOffset<0b10, 1, FPR128, simm7s16, "ldp">;

defm LDPSW : LoadPairOffset<0b01, 0, GPR64, simm7s4, "ldpsw">;

// Pair (pre-indexed)
def LDPWpre : LoadPairPreIdx<0b00, 0, GPR32, simm7s4, "ldp">;
def LDPXpre : LoadPairPreIdx<0b10, 0, GPR64, simm7s8, "ldp">;
def LDPSpre : LoadPairPreIdx<0b00, 1, FPR32, simm7s4, "ldp">;
def LDPDpre : LoadPairPreIdx<0b01, 1, FPR64, simm7s8, "ldp">;
def LDPQpre : LoadPairPreIdx<0b10, 1, FPR128, simm7s16, "ldp">;

def LDPSWpre : LoadPairPreIdx<0b01, 0, GPR64, simm7s4, "ldpsw">;

// Pair (post-indexed)
def LDPWpost : LoadPairPostIdx<0b00, 0, GPR32, simm7s4, "ldp">;
def LDPXpost : LoadPairPostIdx<0b10, 0, GPR64, simm7s8, "ldp">;
def LDPSpost : LoadPairPostIdx<0b00, 1, FPR32, simm7s4, "ldp">;
def LDPDpost : LoadPairPostIdx<0b01, 1, FPR64, simm7s8, "ldp">;
def LDPQpost : LoadPairPostIdx<0b10, 1, FPR128, simm7s16, "ldp">;

def LDPSWpost : LoadPairPostIdx<0b01, 0, GPR64, simm7s4, "ldpsw">;


// Pair (no allocate)
defm LDNPW : LoadPairNoAlloc<0b00, 0, GPR32, simm7s4, "ldnp">;
defm LDNPX : LoadPairNoAlloc<0b10, 0, GPR64, simm7s8, "ldnp">;
defm LDNPS : LoadPairNoAlloc<0b00, 1, FPR32, simm7s4, "ldnp">;
defm LDNPD : LoadPairNoAlloc<0b01, 1, FPR64, simm7s8, "ldnp">;
defm LDNPQ : LoadPairNoAlloc<0b10, 1, FPR128, simm7s16, "ldnp">;

//---
// (register offset)
//---

// Integer
defm LDRBB : Load8RO<0b00,  0, 0b01, GPR32, "ldrb", i32, zextloadi8>;
defm LDRHH : Load16RO<0b01, 0, 0b01, GPR32, "ldrh", i32, zextloadi16>;
defm LDRW  : Load32RO<0b10, 0, 0b01, GPR32, "ldr", i32, load>;
defm LDRX  : Load64RO<0b11, 0, 0b01, GPR64, "ldr", i64, load>;

// Floating-point
defm LDRB : Load8RO<0b00,   1, 0b01, FPR8,   "ldr", untyped, load>;
defm LDRH : Load16RO<0b01,  1, 0b01, FPR16,  "ldr", f16, load>;
defm LDRS : Load32RO<0b10,  1, 0b01, FPR32,  "ldr", f32, load>;
defm LDRD : Load64RO<0b11,  1, 0b01, FPR64,  "ldr", f64, load>;
defm LDRQ : Load128RO<0b00, 1, 0b11, FPR128, "ldr", f128, load>;

// Load sign-extended half-word
defm LDRSHW : Load16RO<0b01, 0, 0b11, GPR32, "ldrsh", i32, sextloadi16>;
defm LDRSHX : Load16RO<0b01, 0, 0b10, GPR64, "ldrsh", i64, sextloadi16>;

// Load sign-extended byte
defm LDRSBW : Load8RO<0b00, 0, 0b11, GPR32, "ldrsb", i32, sextloadi8>;
defm LDRSBX : Load8RO<0b00, 0, 0b10, GPR64, "ldrsb", i64, sextloadi8>;

// Load sign-extended word
defm LDRSW  : Load32RO<0b10, 0, 0b10, GPR64, "ldrsw", i64, sextloadi32>;

// Pre-fetch.
defm PRFM : PrefetchRO<0b11, 0, 0b10, "prfm">;

// For regular load, we do not have any alignment requirement.
// Thus, it is safe to directly map the vector loads with interesting
// addressing modes.
// FIXME: We could do the same for bitconvert to floating point vectors.
multiclass ScalToVecROLoadPat<ROAddrMode ro, SDPatternOperator loadop,
                              ValueType ScalTy, ValueType VecTy,
                              Instruction LOADW, Instruction LOADX,
                              SubRegIndex sub> {
  def : Pat<(VecTy (scalar_to_vector (ScalTy
              (loadop (ro.Wpat GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$offset))))),
            (INSERT_SUBREG (VecTy (IMPLICIT_DEF)),
                           (LOADW GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$offset),
                           sub)>;

  def : Pat<(VecTy (scalar_to_vector (ScalTy
              (loadop (ro.Xpat GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$offset))))),
            (INSERT_SUBREG (VecTy (IMPLICIT_DEF)),
                           (LOADX GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$offset),
                           sub)>;
}

let AddedComplexity = 10 in {
defm : ScalToVecROLoadPat<ro8,  extloadi8,  i32, v8i8,  LDRBroW, LDRBroX, bsub>;
defm : ScalToVecROLoadPat<ro8,  extloadi8,  i32, v16i8, LDRBroW, LDRBroX, bsub>;

defm : ScalToVecROLoadPat<ro16, extloadi16, i32, v4i16, LDRHroW, LDRHroX, hsub>;
defm : ScalToVecROLoadPat<ro16, extloadi16, i32, v8i16, LDRHroW, LDRHroX, hsub>;

defm : ScalToVecROLoadPat<ro16, load,       i32, v4f16, LDRHroW, LDRHroX, hsub>;
defm : ScalToVecROLoadPat<ro16, load,       i32, v8f16, LDRHroW, LDRHroX, hsub>;

defm : ScalToVecROLoadPat<ro32, load,       i32, v2i32, LDRSroW, LDRSroX, ssub>;
defm : ScalToVecROLoadPat<ro32, load,       i32, v4i32, LDRSroW, LDRSroX, ssub>;

defm : ScalToVecROLoadPat<ro32, load,       f32, v2f32, LDRSroW, LDRSroX, ssub>;
defm : ScalToVecROLoadPat<ro32, load,       f32, v4f32, LDRSroW, LDRSroX, ssub>;

defm : ScalToVecROLoadPat<ro64, load,       i64, v2i64, LDRDroW, LDRDroX, dsub>;

defm : ScalToVecROLoadPat<ro64, load,       f64, v2f64, LDRDroW, LDRDroX, dsub>;


def : Pat <(v1i64 (scalar_to_vector (i64
                      (load (ro_Windexed64 GPR64sp:$Rn, GPR32:$Rm,
                                           ro_Wextend64:$extend))))),
           (LDRDroW GPR64sp:$Rn, GPR32:$Rm, ro_Wextend64:$extend)>;

def : Pat <(v1i64 (scalar_to_vector (i64
                      (load (ro_Xindexed64 GPR64sp:$Rn, GPR64:$Rm,
                                           ro_Xextend64:$extend))))),
           (LDRDroX GPR64sp:$Rn, GPR64:$Rm, ro_Xextend64:$extend)>;
}

// Match all load 64 bits width whose type is compatible with FPR64
multiclass VecROLoadPat<ROAddrMode ro, ValueType VecTy,
                        Instruction LOADW, Instruction LOADX> {

  def : Pat<(VecTy (load (ro.Wpat GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend))),
            (LOADW GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend)>;

  def : Pat<(VecTy (load (ro.Xpat GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend))),
            (LOADX GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend)>;
}

let AddedComplexity = 10 in {
let Predicates = [IsLE] in {
  // We must do vector loads with LD1 in big-endian.
  defm : VecROLoadPat<ro64, v2i32, LDRDroW, LDRDroX>;
  defm : VecROLoadPat<ro64, v2f32, LDRDroW, LDRDroX>;
  defm : VecROLoadPat<ro64, v8i8,  LDRDroW, LDRDroX>;
  defm : VecROLoadPat<ro64, v4i16, LDRDroW, LDRDroX>;
  defm : VecROLoadPat<ro64, v4f16, LDRDroW, LDRDroX>;
}

defm : VecROLoadPat<ro64, v1i64,  LDRDroW, LDRDroX>;
defm : VecROLoadPat<ro64, v1f64,  LDRDroW, LDRDroX>;

// Match all load 128 bits width whose type is compatible with FPR128
let Predicates = [IsLE] in {
  // We must do vector loads with LD1 in big-endian.
  defm : VecROLoadPat<ro128, v2i64,  LDRQroW, LDRQroX>;
  defm : VecROLoadPat<ro128, v2f64,  LDRQroW, LDRQroX>;
  defm : VecROLoadPat<ro128, v4i32,  LDRQroW, LDRQroX>;
  defm : VecROLoadPat<ro128, v4f32,  LDRQroW, LDRQroX>;
  defm : VecROLoadPat<ro128, v8i16,  LDRQroW, LDRQroX>;
  defm : VecROLoadPat<ro128, v8f16,  LDRQroW, LDRQroX>;
  defm : VecROLoadPat<ro128, v16i8,  LDRQroW, LDRQroX>;
}
} // AddedComplexity = 10

// zextload -> i64
multiclass ExtLoadTo64ROPat<ROAddrMode ro, SDPatternOperator loadop,
                            Instruction INSTW, Instruction INSTX> {
  def : Pat<(i64 (loadop (ro.Wpat GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend))),
            (SUBREG_TO_REG (i64 0),
                           (INSTW GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend),
                           sub_32)>;

  def : Pat<(i64 (loadop (ro.Xpat GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend))),
            (SUBREG_TO_REG (i64 0),
                           (INSTX GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend),
                           sub_32)>;
}

let AddedComplexity = 10 in {
  defm : ExtLoadTo64ROPat<ro8,  zextloadi8,  LDRBBroW, LDRBBroX>;
  defm : ExtLoadTo64ROPat<ro16, zextloadi16, LDRHHroW, LDRHHroX>;
  defm : ExtLoadTo64ROPat<ro32, zextloadi32, LDRWroW,  LDRWroX>;

  // zextloadi1 -> zextloadi8
  defm : ExtLoadTo64ROPat<ro8,  zextloadi1,  LDRBBroW, LDRBBroX>;

  // extload -> zextload
  defm : ExtLoadTo64ROPat<ro8,  extloadi8,   LDRBBroW, LDRBBroX>;
  defm : ExtLoadTo64ROPat<ro16, extloadi16,  LDRHHroW, LDRHHroX>;
  defm : ExtLoadTo64ROPat<ro32, extloadi32,  LDRWroW,  LDRWroX>;

  // extloadi1 -> zextloadi8
  defm : ExtLoadTo64ROPat<ro8,  extloadi1,   LDRBBroW, LDRBBroX>;
}


// zextload -> i64
multiclass ExtLoadTo32ROPat<ROAddrMode ro, SDPatternOperator loadop,
                            Instruction INSTW, Instruction INSTX> {
  def : Pat<(i32 (loadop (ro.Wpat GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend))),
            (INSTW GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend)>;

  def : Pat<(i32 (loadop (ro.Xpat GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend))),
            (INSTX GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend)>;

}

let AddedComplexity = 10 in {
  // extload -> zextload
  defm : ExtLoadTo32ROPat<ro8,  extloadi8,   LDRBBroW, LDRBBroX>;
  defm : ExtLoadTo32ROPat<ro16, extloadi16,  LDRHHroW, LDRHHroX>;
  defm : ExtLoadTo32ROPat<ro32, extloadi32,  LDRWroW,  LDRWroX>;

  // zextloadi1 -> zextloadi8
  defm : ExtLoadTo32ROPat<ro8, zextloadi1, LDRBBroW, LDRBBroX>;
}

//---
// (unsigned immediate)
//---
defm LDRX : LoadUI<0b11, 0, 0b01, GPR64, uimm12s8, "ldr",
                   [(set GPR64:$Rt,
                         (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset)))]>;
defm LDRW : LoadUI<0b10, 0, 0b01, GPR32, uimm12s4, "ldr",
                   [(set GPR32:$Rt,
                         (load (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset)))]>;
defm LDRB : LoadUI<0b00, 1, 0b01, FPR8, uimm12s1, "ldr",
                   [(set FPR8:$Rt,
                         (load (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset)))]>;
defm LDRH : LoadUI<0b01, 1, 0b01, FPR16, uimm12s2, "ldr",
                   [(set (f16 FPR16:$Rt),
                         (load (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset)))]>;
defm LDRS : LoadUI<0b10, 1, 0b01, FPR32, uimm12s4, "ldr",
                   [(set (f32 FPR32:$Rt),
                         (load (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset)))]>;
defm LDRD : LoadUI<0b11, 1, 0b01, FPR64, uimm12s8, "ldr",
                   [(set (f64 FPR64:$Rt),
                         (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset)))]>;
defm LDRQ : LoadUI<0b00, 1, 0b11, FPR128, uimm12s16, "ldr",
                 [(set (f128 FPR128:$Rt),
                       (load (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset)))]>;

// For regular load, we do not have any alignment requirement.
// Thus, it is safe to directly map the vector loads with interesting
// addressing modes.
// FIXME: We could do the same for bitconvert to floating point vectors.
def : Pat <(v8i8 (scalar_to_vector (i32
               (extloadi8 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))))),
           (INSERT_SUBREG (v8i8 (IMPLICIT_DEF)),
                          (LDRBui GPR64sp:$Rn, uimm12s1:$offset), bsub)>;
def : Pat <(v16i8 (scalar_to_vector (i32
               (extloadi8 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))))),
           (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
                          (LDRBui GPR64sp:$Rn, uimm12s1:$offset), bsub)>;
def : Pat <(v4i16 (scalar_to_vector (i32
               (extloadi16 (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset))))),
           (INSERT_SUBREG (v4i16 (IMPLICIT_DEF)),
                          (LDRHui GPR64sp:$Rn, uimm12s2:$offset), hsub)>;
def : Pat <(v8i16 (scalar_to_vector (i32
               (extloadi16 (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset))))),
           (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)),
                          (LDRHui GPR64sp:$Rn, uimm12s2:$offset), hsub)>;
def : Pat <(v2i32 (scalar_to_vector (i32
               (load (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset))))),
           (INSERT_SUBREG (v2i32 (IMPLICIT_DEF)),
                          (LDRSui GPR64sp:$Rn, uimm12s4:$offset), ssub)>;
def : Pat <(v4i32 (scalar_to_vector (i32
               (load (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset))))),
           (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)),
                          (LDRSui GPR64sp:$Rn, uimm12s4:$offset), ssub)>;
def : Pat <(v1i64 (scalar_to_vector (i64
               (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))))),
           (LDRDui GPR64sp:$Rn, uimm12s8:$offset)>;
def : Pat <(v2i64 (scalar_to_vector (i64
               (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))))),
           (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)),
                          (LDRDui GPR64sp:$Rn, uimm12s8:$offset), dsub)>;

// Match all load 64 bits width whose type is compatible with FPR64
let Predicates = [IsLE] in {
  // We must use LD1 to perform vector loads in big-endian.
  def : Pat<(v2f32 (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))),
            (LDRDui GPR64sp:$Rn, uimm12s8:$offset)>;
  def : Pat<(v8i8 (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))),
            (LDRDui GPR64sp:$Rn, uimm12s8:$offset)>;
  def : Pat<(v4i16 (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))),
            (LDRDui GPR64sp:$Rn, uimm12s8:$offset)>;
  def : Pat<(v2i32 (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))),
            (LDRDui GPR64sp:$Rn, uimm12s8:$offset)>;
  def : Pat<(v4f16 (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))),
            (LDRDui GPR64sp:$Rn, uimm12s8:$offset)>;
}
def : Pat<(v1f64 (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))),
          (LDRDui GPR64sp:$Rn, uimm12s8:$offset)>;
def : Pat<(v1i64 (load (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))),
          (LDRDui GPR64sp:$Rn, uimm12s8:$offset)>;

// Match all load 128 bits width whose type is compatible with FPR128
let Predicates = [IsLE] in {
  // We must use LD1 to perform vector loads in big-endian.
  def : Pat<(v4f32 (load (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset))),
            (LDRQui GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(v2f64 (load (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset))),
            (LDRQui GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(v16i8 (load (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset))),
            (LDRQui GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(v8i16 (load (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset))),
            (LDRQui GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(v4i32 (load (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset))),
            (LDRQui GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(v2i64 (load (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset))),
            (LDRQui GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(v8f16 (load (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset))),
            (LDRQui GPR64sp:$Rn, uimm12s16:$offset)>;
}
def : Pat<(f128  (load (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset))),
          (LDRQui GPR64sp:$Rn, uimm12s16:$offset)>;

defm LDRHH : LoadUI<0b01, 0, 0b01, GPR32, uimm12s2, "ldrh",
                    [(set GPR32:$Rt,
                          (zextloadi16 (am_indexed16 GPR64sp:$Rn,
                                                     uimm12s2:$offset)))]>;
defm LDRBB : LoadUI<0b00, 0, 0b01, GPR32, uimm12s1, "ldrb",
                    [(set GPR32:$Rt,
                          (zextloadi8 (am_indexed8 GPR64sp:$Rn,
                                                   uimm12s1:$offset)))]>;
// zextload -> i64
def : Pat<(i64 (zextloadi8 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))),
    (SUBREG_TO_REG (i64 0), (LDRBBui GPR64sp:$Rn, uimm12s1:$offset), sub_32)>;
def : Pat<(i64 (zextloadi16 (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset))),
    (SUBREG_TO_REG (i64 0), (LDRHHui GPR64sp:$Rn, uimm12s2:$offset), sub_32)>;

// zextloadi1 -> zextloadi8
def : Pat<(i32 (zextloadi1 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))),
          (LDRBBui GPR64sp:$Rn, uimm12s1:$offset)>;
def : Pat<(i64 (zextloadi1 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))),
    (SUBREG_TO_REG (i64 0), (LDRBBui GPR64sp:$Rn, uimm12s1:$offset), sub_32)>;

// extload -> zextload
def : Pat<(i32 (extloadi16 (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset))),
          (LDRHHui GPR64sp:$Rn, uimm12s2:$offset)>;
def : Pat<(i32 (extloadi8 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))),
          (LDRBBui GPR64sp:$Rn, uimm12s1:$offset)>;
def : Pat<(i32 (extloadi1 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))),
          (LDRBBui GPR64sp:$Rn, uimm12s1:$offset)>;
def : Pat<(i64 (extloadi32 (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset))),
    (SUBREG_TO_REG (i64 0), (LDRWui GPR64sp:$Rn, uimm12s4:$offset), sub_32)>;
def : Pat<(i64 (extloadi16 (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset))),
    (SUBREG_TO_REG (i64 0), (LDRHHui GPR64sp:$Rn, uimm12s2:$offset), sub_32)>;
def : Pat<(i64 (extloadi8 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))),
    (SUBREG_TO_REG (i64 0), (LDRBBui GPR64sp:$Rn, uimm12s1:$offset), sub_32)>;
def : Pat<(i64 (extloadi1 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))),
    (SUBREG_TO_REG (i64 0), (LDRBBui GPR64sp:$Rn, uimm12s1:$offset), sub_32)>;

// load sign-extended half-word
defm LDRSHW : LoadUI<0b01, 0, 0b11, GPR32, uimm12s2, "ldrsh",
                     [(set GPR32:$Rt,
                           (sextloadi16 (am_indexed16 GPR64sp:$Rn,
                                                      uimm12s2:$offset)))]>;
defm LDRSHX : LoadUI<0b01, 0, 0b10, GPR64, uimm12s2, "ldrsh",
                     [(set GPR64:$Rt,
                           (sextloadi16 (am_indexed16 GPR64sp:$Rn,
                                                      uimm12s2:$offset)))]>;

// load sign-extended byte
defm LDRSBW : LoadUI<0b00, 0, 0b11, GPR32, uimm12s1, "ldrsb",
                     [(set GPR32:$Rt,
                           (sextloadi8 (am_indexed8 GPR64sp:$Rn,
                                                    uimm12s1:$offset)))]>;
defm LDRSBX : LoadUI<0b00, 0, 0b10, GPR64, uimm12s1, "ldrsb",
                     [(set GPR64:$Rt,
                           (sextloadi8 (am_indexed8 GPR64sp:$Rn,
                                                    uimm12s1:$offset)))]>;

// load sign-extended word
defm LDRSW  : LoadUI<0b10, 0, 0b10, GPR64, uimm12s4, "ldrsw",
                     [(set GPR64:$Rt,
                           (sextloadi32 (am_indexed32 GPR64sp:$Rn,
                                                      uimm12s4:$offset)))]>;

// load zero-extended word
def : Pat<(i64 (zextloadi32 (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset))),
      (SUBREG_TO_REG (i64 0), (LDRWui GPR64sp:$Rn, uimm12s4:$offset), sub_32)>;

// Pre-fetch.
def PRFMui : PrefetchUI<0b11, 0, 0b10, "prfm",
                        [(AArch64Prefetch imm:$Rt,
                                        (am_indexed64 GPR64sp:$Rn,
                                                      uimm12s8:$offset))]>;

def : InstAlias<"prfm $Rt, [$Rn]", (PRFMui prfop:$Rt, GPR64sp:$Rn, 0)>;

//---
// (literal)
def LDRWl : LoadLiteral<0b00, 0, GPR32, "ldr">;
def LDRXl : LoadLiteral<0b01, 0, GPR64, "ldr">;
def LDRSl : LoadLiteral<0b00, 1, FPR32, "ldr">;
def LDRDl : LoadLiteral<0b01, 1, FPR64, "ldr">;
def LDRQl : LoadLiteral<0b10, 1, FPR128, "ldr">;

// load sign-extended word
def LDRSWl : LoadLiteral<0b10, 0, GPR64, "ldrsw">;

// prefetch
def PRFMl : PrefetchLiteral<0b11, 0, "prfm", []>;
//                   [(AArch64Prefetch imm:$Rt, tglobaladdr:$label)]>;

//---
// (unscaled immediate)
defm LDURX : LoadUnscaled<0b11, 0, 0b01, GPR64, "ldur",
                    [(set GPR64:$Rt,
                          (load (am_unscaled64 GPR64sp:$Rn, simm9:$offset)))]>;
defm LDURW : LoadUnscaled<0b10, 0, 0b01, GPR32, "ldur",
                    [(set GPR32:$Rt,
                          (load (am_unscaled32 GPR64sp:$Rn, simm9:$offset)))]>;
defm LDURB : LoadUnscaled<0b00, 1, 0b01, FPR8, "ldur",
                    [(set FPR8:$Rt,
                          (load (am_unscaled8 GPR64sp:$Rn, simm9:$offset)))]>;
defm LDURH : LoadUnscaled<0b01, 1, 0b01, FPR16, "ldur",
                    [(set FPR16:$Rt,
                          (load (am_unscaled16 GPR64sp:$Rn, simm9:$offset)))]>;
defm LDURS : LoadUnscaled<0b10, 1, 0b01, FPR32, "ldur",
                    [(set (f32 FPR32:$Rt),
                          (load (am_unscaled32 GPR64sp:$Rn, simm9:$offset)))]>;
defm LDURD : LoadUnscaled<0b11, 1, 0b01, FPR64, "ldur",
                    [(set (f64 FPR64:$Rt),
                          (load (am_unscaled64 GPR64sp:$Rn, simm9:$offset)))]>;
defm LDURQ : LoadUnscaled<0b00, 1, 0b11, FPR128, "ldur",
                    [(set (f128 FPR128:$Rt),
                          (load (am_unscaled128 GPR64sp:$Rn, simm9:$offset)))]>;

defm LDURHH
    : LoadUnscaled<0b01, 0, 0b01, GPR32, "ldurh",
             [(set GPR32:$Rt,
                    (zextloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset)))]>;
defm LDURBB
    : LoadUnscaled<0b00, 0, 0b01, GPR32, "ldurb",
             [(set GPR32:$Rt,
                    (zextloadi8 (am_unscaled16 GPR64sp:$Rn, simm9:$offset)))]>;

// Match all load 64 bits width whose type is compatible with FPR64
let Predicates = [IsLE] in {
  def : Pat<(v2f32 (load (am_unscaled64 GPR64sp:$Rn, simm9:$offset))),
            (LDURDi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v2i32 (load (am_unscaled64 GPR64sp:$Rn, simm9:$offset))),
            (LDURDi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v4i16 (load (am_unscaled64 GPR64sp:$Rn, simm9:$offset))),
            (LDURDi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v8i8 (load (am_unscaled64 GPR64sp:$Rn, simm9:$offset))),
            (LDURDi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v4f16 (load (am_unscaled64 GPR64sp:$Rn, simm9:$offset))),
            (LDURDi GPR64sp:$Rn, simm9:$offset)>;
}
def : Pat<(v1f64 (load (am_unscaled64 GPR64sp:$Rn, simm9:$offset))),
          (LDURDi GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(v1i64 (load (am_unscaled64 GPR64sp:$Rn, simm9:$offset))),
          (LDURDi GPR64sp:$Rn, simm9:$offset)>;

// Match all load 128 bits width whose type is compatible with FPR128
let Predicates = [IsLE] in {
  def : Pat<(v2f64 (load (am_unscaled128 GPR64sp:$Rn, simm9:$offset))),
            (LDURQi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v2i64 (load (am_unscaled128 GPR64sp:$Rn, simm9:$offset))),
            (LDURQi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v4f32 (load (am_unscaled128 GPR64sp:$Rn, simm9:$offset))),
            (LDURQi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v4i32 (load (am_unscaled128 GPR64sp:$Rn, simm9:$offset))),
            (LDURQi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v8i16 (load (am_unscaled128 GPR64sp:$Rn, simm9:$offset))),
            (LDURQi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v16i8 (load (am_unscaled128 GPR64sp:$Rn, simm9:$offset))),
            (LDURQi GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(v8f16 (load (am_unscaled128 GPR64sp:$Rn, simm9:$offset))),
            (LDURQi GPR64sp:$Rn, simm9:$offset)>;
}

//  anyext -> zext
def : Pat<(i32 (extloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset))),
          (LDURHHi GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(i32 (extloadi8 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))),
          (LDURBBi GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(i32 (extloadi1 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))),
          (LDURBBi GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(i64 (extloadi32 (am_unscaled32 GPR64sp:$Rn, simm9:$offset))),
    (SUBREG_TO_REG (i64 0), (LDURWi GPR64sp:$Rn, simm9:$offset), sub_32)>;
def : Pat<(i64 (extloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset))),
    (SUBREG_TO_REG (i64 0), (LDURHHi GPR64sp:$Rn, simm9:$offset), sub_32)>;
def : Pat<(i64 (extloadi8 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))),
    (SUBREG_TO_REG (i64 0), (LDURBBi GPR64sp:$Rn, simm9:$offset), sub_32)>;
def : Pat<(i64 (extloadi1 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))),
    (SUBREG_TO_REG (i64 0), (LDURBBi GPR64sp:$Rn, simm9:$offset), sub_32)>;
// unscaled zext
def : Pat<(i32 (zextloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset))),
          (LDURHHi GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(i32 (zextloadi8 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))),
          (LDURBBi GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(i32 (zextloadi1 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))),
          (LDURBBi GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(i64 (zextloadi32 (am_unscaled32 GPR64sp:$Rn, simm9:$offset))),
    (SUBREG_TO_REG (i64 0), (LDURWi GPR64sp:$Rn, simm9:$offset), sub_32)>;
def : Pat<(i64 (zextloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset))),
    (SUBREG_TO_REG (i64 0), (LDURHHi GPR64sp:$Rn, simm9:$offset), sub_32)>;
def : Pat<(i64 (zextloadi8 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))),
    (SUBREG_TO_REG (i64 0), (LDURBBi GPR64sp:$Rn, simm9:$offset), sub_32)>;
def : Pat<(i64 (zextloadi1 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))),
    (SUBREG_TO_REG (i64 0), (LDURBBi GPR64sp:$Rn, simm9:$offset), sub_32)>;


//---
// LDR mnemonics fall back to LDUR for negative or unaligned offsets.

// Define new assembler match classes as we want to only match these when
// the don't otherwise match the scaled addressing mode for LDR/STR. Don't
// associate a DiagnosticType either, as we want the diagnostic for the
// canonical form (the scaled operand) to take precedence.
class SImm9OffsetOperand<int Width> : AsmOperandClass {
  let Name = "SImm9OffsetFB" # Width;
  let PredicateMethod = "isSImm9OffsetFB<" # Width # ">";
  let RenderMethod = "addImmOperands";
}

def SImm9OffsetFB8Operand : SImm9OffsetOperand<8>;
def SImm9OffsetFB16Operand : SImm9OffsetOperand<16>;
def SImm9OffsetFB32Operand : SImm9OffsetOperand<32>;
def SImm9OffsetFB64Operand : SImm9OffsetOperand<64>;
def SImm9OffsetFB128Operand : SImm9OffsetOperand<128>;

def simm9_offset_fb8 : Operand<i64> {
  let ParserMatchClass = SImm9OffsetFB8Operand;
}
def simm9_offset_fb16 : Operand<i64> {
  let ParserMatchClass = SImm9OffsetFB16Operand;
}
def simm9_offset_fb32 : Operand<i64> {
  let ParserMatchClass = SImm9OffsetFB32Operand;
}
def simm9_offset_fb64 : Operand<i64> {
  let ParserMatchClass = SImm9OffsetFB64Operand;
}
def simm9_offset_fb128 : Operand<i64> {
  let ParserMatchClass = SImm9OffsetFB128Operand;
}

def : InstAlias<"ldr $Rt, [$Rn, $offset]",
                (LDURXi GPR64:$Rt, GPR64sp:$Rn, simm9_offset_fb64:$offset), 0>;
def : InstAlias<"ldr $Rt, [$Rn, $offset]",
                (LDURWi GPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb32:$offset), 0>;
def : InstAlias<"ldr $Rt, [$Rn, $offset]",
                (LDURBi FPR8:$Rt, GPR64sp:$Rn, simm9_offset_fb8:$offset), 0>;
def : InstAlias<"ldr $Rt, [$Rn, $offset]",
                (LDURHi FPR16:$Rt, GPR64sp:$Rn, simm9_offset_fb16:$offset), 0>;
def : InstAlias<"ldr $Rt, [$Rn, $offset]",
                (LDURSi FPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb32:$offset), 0>;
def : InstAlias<"ldr $Rt, [$Rn, $offset]",
                (LDURDi FPR64:$Rt, GPR64sp:$Rn, simm9_offset_fb64:$offset), 0>;
def : InstAlias<"ldr $Rt, [$Rn, $offset]",
               (LDURQi FPR128:$Rt, GPR64sp:$Rn, simm9_offset_fb128:$offset), 0>;

// zextload -> i64
def : Pat<(i64 (zextloadi8 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))),
  (SUBREG_TO_REG (i64 0), (LDURBBi GPR64sp:$Rn, simm9:$offset), sub_32)>;
def : Pat<(i64 (zextloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset))),
  (SUBREG_TO_REG (i64 0), (LDURHHi GPR64sp:$Rn, simm9:$offset), sub_32)>;

// load sign-extended half-word
defm LDURSHW
    : LoadUnscaled<0b01, 0, 0b11, GPR32, "ldursh",
               [(set GPR32:$Rt,
                    (sextloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset)))]>;
defm LDURSHX
    : LoadUnscaled<0b01, 0, 0b10, GPR64, "ldursh",
              [(set GPR64:$Rt,
                    (sextloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset)))]>;

// load sign-extended byte
defm LDURSBW
    : LoadUnscaled<0b00, 0, 0b11, GPR32, "ldursb",
                [(set GPR32:$Rt,
                      (sextloadi8 (am_unscaled8 GPR64sp:$Rn, simm9:$offset)))]>;
defm LDURSBX
    : LoadUnscaled<0b00, 0, 0b10, GPR64, "ldursb",
                [(set GPR64:$Rt,
                      (sextloadi8 (am_unscaled8 GPR64sp:$Rn, simm9:$offset)))]>;

// load sign-extended word
defm LDURSW
    : LoadUnscaled<0b10, 0, 0b10, GPR64, "ldursw",
              [(set GPR64:$Rt,
                    (sextloadi32 (am_unscaled32 GPR64sp:$Rn, simm9:$offset)))]>;

// zero and sign extending aliases from generic LDR* mnemonics to LDUR*.
def : InstAlias<"ldrb $Rt, [$Rn, $offset]",
                (LDURBBi GPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb8:$offset), 0>;
def : InstAlias<"ldrh $Rt, [$Rn, $offset]",
                (LDURHHi GPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb16:$offset), 0>;
def : InstAlias<"ldrsb $Rt, [$Rn, $offset]",
                (LDURSBWi GPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb8:$offset), 0>;
def : InstAlias<"ldrsb $Rt, [$Rn, $offset]",
                (LDURSBXi GPR64:$Rt, GPR64sp:$Rn, simm9_offset_fb8:$offset), 0>;
def : InstAlias<"ldrsh $Rt, [$Rn, $offset]",
                (LDURSHWi GPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb16:$offset), 0>;
def : InstAlias<"ldrsh $Rt, [$Rn, $offset]",
                (LDURSHXi GPR64:$Rt, GPR64sp:$Rn, simm9_offset_fb16:$offset), 0>;
def : InstAlias<"ldrsw $Rt, [$Rn, $offset]",
                (LDURSWi GPR64:$Rt, GPR64sp:$Rn, simm9_offset_fb32:$offset), 0>;

// Pre-fetch.
defm PRFUM : PrefetchUnscaled<0b11, 0, 0b10, "prfum",
                  [(AArch64Prefetch imm:$Rt,
                                  (am_unscaled64 GPR64sp:$Rn, simm9:$offset))]>;

//---
// (unscaled immediate, unprivileged)
defm LDTRX : LoadUnprivileged<0b11, 0, 0b01, GPR64, "ldtr">;
defm LDTRW : LoadUnprivileged<0b10, 0, 0b01, GPR32, "ldtr">;

defm LDTRH : LoadUnprivileged<0b01, 0, 0b01, GPR32, "ldtrh">;
defm LDTRB : LoadUnprivileged<0b00, 0, 0b01, GPR32, "ldtrb">;

// load sign-extended half-word
defm LDTRSHW : LoadUnprivileged<0b01, 0, 0b11, GPR32, "ldtrsh">;
defm LDTRSHX : LoadUnprivileged<0b01, 0, 0b10, GPR64, "ldtrsh">;

// load sign-extended byte
defm LDTRSBW : LoadUnprivileged<0b00, 0, 0b11, GPR32, "ldtrsb">;
defm LDTRSBX : LoadUnprivileged<0b00, 0, 0b10, GPR64, "ldtrsb">;

// load sign-extended word
defm LDTRSW  : LoadUnprivileged<0b10, 0, 0b10, GPR64, "ldtrsw">;

//---
// (immediate pre-indexed)
def LDRWpre : LoadPreIdx<0b10, 0, 0b01, GPR32, "ldr">;
def LDRXpre : LoadPreIdx<0b11, 0, 0b01, GPR64, "ldr">;
def LDRBpre : LoadPreIdx<0b00, 1, 0b01, FPR8,  "ldr">;
def LDRHpre : LoadPreIdx<0b01, 1, 0b01, FPR16, "ldr">;
def LDRSpre : LoadPreIdx<0b10, 1, 0b01, FPR32, "ldr">;
def LDRDpre : LoadPreIdx<0b11, 1, 0b01, FPR64, "ldr">;
def LDRQpre : LoadPreIdx<0b00, 1, 0b11, FPR128, "ldr">;

// load sign-extended half-word
def LDRSHWpre : LoadPreIdx<0b01, 0, 0b11, GPR32, "ldrsh">;
def LDRSHXpre : LoadPreIdx<0b01, 0, 0b10, GPR64, "ldrsh">;

// load sign-extended byte
def LDRSBWpre : LoadPreIdx<0b00, 0, 0b11, GPR32, "ldrsb">;
def LDRSBXpre : LoadPreIdx<0b00, 0, 0b10, GPR64, "ldrsb">;

// load zero-extended byte
def LDRBBpre : LoadPreIdx<0b00, 0, 0b01, GPR32, "ldrb">;
def LDRHHpre : LoadPreIdx<0b01, 0, 0b01, GPR32, "ldrh">;

// load sign-extended word
def LDRSWpre : LoadPreIdx<0b10, 0, 0b10, GPR64, "ldrsw">;

//---
// (immediate post-indexed)
def LDRWpost : LoadPostIdx<0b10, 0, 0b01, GPR32, "ldr">;
def LDRXpost : LoadPostIdx<0b11, 0, 0b01, GPR64, "ldr">;
def LDRBpost : LoadPostIdx<0b00, 1, 0b01, FPR8,  "ldr">;
def LDRHpost : LoadPostIdx<0b01, 1, 0b01, FPR16, "ldr">;
def LDRSpost : LoadPostIdx<0b10, 1, 0b01, FPR32, "ldr">;
def LDRDpost : LoadPostIdx<0b11, 1, 0b01, FPR64, "ldr">;
def LDRQpost : LoadPostIdx<0b00, 1, 0b11, FPR128, "ldr">;

// load sign-extended half-word
def LDRSHWpost : LoadPostIdx<0b01, 0, 0b11, GPR32, "ldrsh">;
def LDRSHXpost : LoadPostIdx<0b01, 0, 0b10, GPR64, "ldrsh">;

// load sign-extended byte
def LDRSBWpost : LoadPostIdx<0b00, 0, 0b11, GPR32, "ldrsb">;
def LDRSBXpost : LoadPostIdx<0b00, 0, 0b10, GPR64, "ldrsb">;

// load zero-extended byte
def LDRBBpost : LoadPostIdx<0b00, 0, 0b01, GPR32, "ldrb">;
def LDRHHpost : LoadPostIdx<0b01, 0, 0b01, GPR32, "ldrh">;

// load sign-extended word
def LDRSWpost : LoadPostIdx<0b10, 0, 0b10, GPR64, "ldrsw">;

//===----------------------------------------------------------------------===//
// Store instructions.
//===----------------------------------------------------------------------===//

// Pair (indexed, offset)
// FIXME: Use dedicated range-checked addressing mode operand here.
defm STPW : StorePairOffset<0b00, 0, GPR32, simm7s4, "stp">;
defm STPX : StorePairOffset<0b10, 0, GPR64, simm7s8, "stp">;
defm STPS : StorePairOffset<0b00, 1, FPR32, simm7s4, "stp">;
defm STPD : StorePairOffset<0b01, 1, FPR64, simm7s8, "stp">;
defm STPQ : StorePairOffset<0b10, 1, FPR128, simm7s16, "stp">;

// Pair (pre-indexed)
def STPWpre : StorePairPreIdx<0b00, 0, GPR32, simm7s4, "stp">;
def STPXpre : StorePairPreIdx<0b10, 0, GPR64, simm7s8, "stp">;
def STPSpre : StorePairPreIdx<0b00, 1, FPR32, simm7s4, "stp">;
def STPDpre : StorePairPreIdx<0b01, 1, FPR64, simm7s8, "stp">;
def STPQpre : StorePairPreIdx<0b10, 1, FPR128, simm7s16, "stp">;

// Pair (pre-indexed)
def STPWpost : StorePairPostIdx<0b00, 0, GPR32, simm7s4, "stp">;
def STPXpost : StorePairPostIdx<0b10, 0, GPR64, simm7s8, "stp">;
def STPSpost : StorePairPostIdx<0b00, 1, FPR32, simm7s4, "stp">;
def STPDpost : StorePairPostIdx<0b01, 1, FPR64, simm7s8, "stp">;
def STPQpost : StorePairPostIdx<0b10, 1, FPR128, simm7s16, "stp">;

// Pair (no allocate)
defm STNPW : StorePairNoAlloc<0b00, 0, GPR32, simm7s4, "stnp">;
defm STNPX : StorePairNoAlloc<0b10, 0, GPR64, simm7s8, "stnp">;
defm STNPS : StorePairNoAlloc<0b00, 1, FPR32, simm7s4, "stnp">;
defm STNPD : StorePairNoAlloc<0b01, 1, FPR64, simm7s8, "stnp">;
defm STNPQ : StorePairNoAlloc<0b10, 1, FPR128, simm7s16, "stnp">;

//---
// (Register offset)

// Integer
defm STRBB : Store8RO< 0b00, 0, 0b00, GPR32, "strb", i32, truncstorei8>;
defm STRHH : Store16RO<0b01, 0, 0b00, GPR32, "strh", i32, truncstorei16>;
defm STRW  : Store32RO<0b10, 0, 0b00, GPR32, "str",  i32, store>;
defm STRX  : Store64RO<0b11, 0, 0b00, GPR64, "str",  i64, store>;


// Floating-point
defm STRB : Store8RO< 0b00,  1, 0b00, FPR8,   "str", untyped, store>;
defm STRH : Store16RO<0b01,  1, 0b00, FPR16,  "str", f16,     store>;
defm STRS : Store32RO<0b10,  1, 0b00, FPR32,  "str", f32,     store>;
defm STRD : Store64RO<0b11,  1, 0b00, FPR64,  "str", f64,     store>;
defm STRQ : Store128RO<0b00, 1, 0b10, FPR128, "str", f128,    store>;

multiclass TruncStoreFrom64ROPat<ROAddrMode ro, SDPatternOperator storeop,
                                 Instruction STRW, Instruction STRX> {

  def : Pat<(storeop GPR64:$Rt,
                     (ro.Wpat GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend)),
            (STRW (EXTRACT_SUBREG GPR64:$Rt, sub_32),
                  GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend)>;

  def : Pat<(storeop GPR64:$Rt,
                     (ro.Xpat GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend)),
            (STRX (EXTRACT_SUBREG GPR64:$Rt, sub_32),
                  GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend)>;
}

let AddedComplexity = 10 in {
  // truncstore i64
  defm : TruncStoreFrom64ROPat<ro8,  truncstorei8,  STRBBroW, STRBBroX>;
  defm : TruncStoreFrom64ROPat<ro16, truncstorei16, STRHHroW, STRHHroX>;
  defm : TruncStoreFrom64ROPat<ro32, truncstorei32, STRWroW,  STRWroX>;
}

multiclass VecROStorePat<ROAddrMode ro, ValueType VecTy, RegisterClass FPR,
                         Instruction STRW, Instruction STRX> {
  def : Pat<(store (VecTy FPR:$Rt),
                   (ro.Wpat GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend)),
            (STRW FPR:$Rt, GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend)>;

  def : Pat<(store (VecTy FPR:$Rt),
                   (ro.Xpat GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend)),
            (STRX FPR:$Rt, GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend)>;
}

let AddedComplexity = 10 in {
// Match all store 64 bits width whose type is compatible with FPR64
let Predicates = [IsLE] in {
  // We must use ST1 to store vectors in big-endian.
  defm : VecROStorePat<ro64, v2i32, FPR64, STRDroW, STRDroX>;
  defm : VecROStorePat<ro64, v2f32, FPR64, STRDroW, STRDroX>;
  defm : VecROStorePat<ro64, v4i16, FPR64, STRDroW, STRDroX>;
  defm : VecROStorePat<ro64, v8i8, FPR64, STRDroW, STRDroX>;
  defm : VecROStorePat<ro64, v4f16, FPR64, STRDroW, STRDroX>;
}

defm : VecROStorePat<ro64, v1i64, FPR64, STRDroW, STRDroX>;
defm : VecROStorePat<ro64, v1f64, FPR64, STRDroW, STRDroX>;

// Match all store 128 bits width whose type is compatible with FPR128
let Predicates = [IsLE] in {
  // We must use ST1 to store vectors in big-endian.
  defm : VecROStorePat<ro128, v2i64, FPR128, STRQroW, STRQroX>;
  defm : VecROStorePat<ro128, v2f64, FPR128, STRQroW, STRQroX>;
  defm : VecROStorePat<ro128, v4i32, FPR128, STRQroW, STRQroX>;
  defm : VecROStorePat<ro128, v4f32, FPR128, STRQroW, STRQroX>;
  defm : VecROStorePat<ro128, v8i16, FPR128, STRQroW, STRQroX>;
  defm : VecROStorePat<ro128, v16i8, FPR128, STRQroW, STRQroX>;
  defm : VecROStorePat<ro128, v8f16, FPR128, STRQroW, STRQroX>;
}
} // AddedComplexity = 10

// Match stores from lane 0 to the appropriate subreg's store.
multiclass VecROStoreLane0Pat<ROAddrMode ro, SDPatternOperator storeop,
                              ValueType VecTy, ValueType STy,
                              SubRegIndex SubRegIdx,
                              Instruction STRW, Instruction STRX> {

  def : Pat<(storeop (STy (vector_extract (VecTy VecListOne128:$Vt), 0)),
                     (ro.Wpat GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend)),
            (STRW (EXTRACT_SUBREG VecListOne128:$Vt, SubRegIdx),
                  GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend)>;

  def : Pat<(storeop (STy (vector_extract (VecTy VecListOne128:$Vt), 0)),
                     (ro.Xpat GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend)),
            (STRX (EXTRACT_SUBREG VecListOne128:$Vt, SubRegIdx),
                  GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend)>;
}

let AddedComplexity = 19 in {
  defm : VecROStoreLane0Pat<ro16, truncstorei16, v8i16, i32, hsub, STRHroW, STRHroX>;
  defm : VecROStoreLane0Pat<ro16,      store   , v8i16, i16, hsub, STRHroW, STRHroX>;
  defm : VecROStoreLane0Pat<ro32, truncstorei32, v4i32, i32, ssub, STRSroW, STRSroX>;
  defm : VecROStoreLane0Pat<ro32,      store   , v4i32, i32, ssub, STRSroW, STRSroX>;
  defm : VecROStoreLane0Pat<ro32,      store   , v4f32, f32, ssub, STRSroW, STRSroX>;
  defm : VecROStoreLane0Pat<ro64,      store   , v2i64, i64, dsub, STRDroW, STRDroX>;
  defm : VecROStoreLane0Pat<ro64,      store   , v2f64, f64, dsub, STRDroW, STRDroX>;
}

//---
// (unsigned immediate)
defm STRX : StoreUI<0b11, 0, 0b00, GPR64, uimm12s8, "str",
                   [(store GPR64:$Rt,
                            (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))]>;
defm STRW : StoreUI<0b10, 0, 0b00, GPR32, uimm12s4, "str",
                    [(store GPR32:$Rt,
                            (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset))]>;
defm STRB : StoreUI<0b00, 1, 0b00, FPR8, uimm12s1, "str",
                    [(store FPR8:$Rt,
                            (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))]>;
defm STRH : StoreUI<0b01, 1, 0b00, FPR16, uimm12s2, "str",
                    [(store (f16 FPR16:$Rt),
                            (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset))]>;
defm STRS : StoreUI<0b10, 1, 0b00, FPR32, uimm12s4, "str",
                    [(store (f32 FPR32:$Rt),
                            (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset))]>;
defm STRD : StoreUI<0b11, 1, 0b00, FPR64, uimm12s8, "str",
                    [(store (f64 FPR64:$Rt),
                            (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset))]>;
defm STRQ : StoreUI<0b00, 1, 0b10, FPR128, uimm12s16, "str", []>;

defm STRHH : StoreUI<0b01, 0, 0b00, GPR32, uimm12s2, "strh",
                     [(truncstorei16 GPR32:$Rt,
                                     (am_indexed16 GPR64sp:$Rn,
                                                   uimm12s2:$offset))]>;
defm STRBB : StoreUI<0b00, 0, 0b00, GPR32, uimm12s1,  "strb",
                     [(truncstorei8 GPR32:$Rt,
                                    (am_indexed8 GPR64sp:$Rn,
                                                 uimm12s1:$offset))]>;

// Match all store 64 bits width whose type is compatible with FPR64
let AddedComplexity = 10 in {
let Predicates = [IsLE] in {
  // We must use ST1 to store vectors in big-endian.
  def : Pat<(store (v2f32 FPR64:$Rt),
                   (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset)),
            (STRDui FPR64:$Rt, GPR64sp:$Rn, uimm12s8:$offset)>;
  def : Pat<(store (v8i8 FPR64:$Rt),
                   (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset)),
            (STRDui FPR64:$Rt, GPR64sp:$Rn, uimm12s8:$offset)>;
  def : Pat<(store (v4i16 FPR64:$Rt),
                   (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset)),
            (STRDui FPR64:$Rt, GPR64sp:$Rn, uimm12s8:$offset)>;
  def : Pat<(store (v2i32 FPR64:$Rt),
                   (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset)),
            (STRDui FPR64:$Rt, GPR64sp:$Rn, uimm12s8:$offset)>;
  def : Pat<(store (v4f16 FPR64:$Rt),
                   (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset)),
            (STRDui FPR64:$Rt, GPR64sp:$Rn, uimm12s8:$offset)>;
}
def : Pat<(store (v1f64 FPR64:$Rt),
                 (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset)),
          (STRDui FPR64:$Rt, GPR64sp:$Rn, uimm12s8:$offset)>;
def : Pat<(store (v1i64 FPR64:$Rt),
                 (am_indexed64 GPR64sp:$Rn, uimm12s8:$offset)),
          (STRDui FPR64:$Rt, GPR64sp:$Rn, uimm12s8:$offset)>;

// Match all store 128 bits width whose type is compatible with FPR128
let Predicates = [IsLE] in {
  // We must use ST1 to store vectors in big-endian.
  def : Pat<(store (v4f32 FPR128:$Rt),
                   (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset)),
            (STRQui FPR128:$Rt, GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(store (v2f64 FPR128:$Rt),
                   (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset)),
            (STRQui FPR128:$Rt, GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(store (v16i8 FPR128:$Rt),
                   (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset)),
            (STRQui FPR128:$Rt, GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(store (v8i16 FPR128:$Rt),
                   (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset)),
            (STRQui FPR128:$Rt, GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(store (v4i32 FPR128:$Rt),
                   (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset)),
            (STRQui FPR128:$Rt, GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(store (v2i64 FPR128:$Rt),
                   (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset)),
            (STRQui FPR128:$Rt, GPR64sp:$Rn, uimm12s16:$offset)>;
  def : Pat<(store (v8f16 FPR128:$Rt),
                   (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset)),
            (STRQui FPR128:$Rt, GPR64sp:$Rn, uimm12s16:$offset)>;
}
def : Pat<(store (f128  FPR128:$Rt),
                 (am_indexed128 GPR64sp:$Rn, uimm12s16:$offset)),
          (STRQui FPR128:$Rt, GPR64sp:$Rn, uimm12s16:$offset)>;

// truncstore i64
def : Pat<(truncstorei32 GPR64:$Rt,
                         (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset)),
  (STRWui (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$Rn, uimm12s4:$offset)>;
def : Pat<(truncstorei16 GPR64:$Rt,
                         (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset)),
  (STRHHui (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$Rn, uimm12s2:$offset)>;
def : Pat<(truncstorei8 GPR64:$Rt, (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset)),
  (STRBBui (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$Rn, uimm12s1:$offset)>;

} // AddedComplexity = 10

//---
// (unscaled immediate)
defm STURX : StoreUnscaled<0b11, 0, 0b00, GPR64, "stur",
                         [(store GPR64:$Rt,
                                 (am_unscaled64 GPR64sp:$Rn, simm9:$offset))]>;
defm STURW : StoreUnscaled<0b10, 0, 0b00, GPR32, "stur",
                         [(store GPR32:$Rt,
                                 (am_unscaled32 GPR64sp:$Rn, simm9:$offset))]>;
defm STURB : StoreUnscaled<0b00, 1, 0b00, FPR8, "stur",
                         [(store FPR8:$Rt,
                                 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))]>;
defm STURH : StoreUnscaled<0b01, 1, 0b00, FPR16, "stur",
                         [(store (f16 FPR16:$Rt),
                                 (am_unscaled16 GPR64sp:$Rn, simm9:$offset))]>;
defm STURS : StoreUnscaled<0b10, 1, 0b00, FPR32, "stur",
                         [(store (f32 FPR32:$Rt),
                                 (am_unscaled32 GPR64sp:$Rn, simm9:$offset))]>;
defm STURD : StoreUnscaled<0b11, 1, 0b00, FPR64, "stur",
                         [(store (f64 FPR64:$Rt),
                                 (am_unscaled64 GPR64sp:$Rn, simm9:$offset))]>;
defm STURQ : StoreUnscaled<0b00, 1, 0b10, FPR128, "stur",
                         [(store (f128 FPR128:$Rt),
                                 (am_unscaled128 GPR64sp:$Rn, simm9:$offset))]>;
defm STURHH : StoreUnscaled<0b01, 0, 0b00, GPR32, "sturh",
                         [(truncstorei16 GPR32:$Rt,
                                 (am_unscaled16 GPR64sp:$Rn, simm9:$offset))]>;
defm STURBB : StoreUnscaled<0b00, 0, 0b00, GPR32, "sturb",
                         [(truncstorei8 GPR32:$Rt,
                                  (am_unscaled8 GPR64sp:$Rn, simm9:$offset))]>;

// Match all store 64 bits width whose type is compatible with FPR64
let Predicates = [IsLE] in {
  // We must use ST1 to store vectors in big-endian.
  def : Pat<(store (v2f32 FPR64:$Rt),
                   (am_unscaled64 GPR64sp:$Rn, simm9:$offset)),
            (STURDi FPR64:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v8i8 FPR64:$Rt),
                   (am_unscaled64 GPR64sp:$Rn, simm9:$offset)),
            (STURDi FPR64:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v4i16 FPR64:$Rt),
                   (am_unscaled64 GPR64sp:$Rn, simm9:$offset)),
            (STURDi FPR64:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v2i32 FPR64:$Rt),
                   (am_unscaled64 GPR64sp:$Rn, simm9:$offset)),
            (STURDi FPR64:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v4f16 FPR64:$Rt),
                   (am_unscaled64 GPR64sp:$Rn, simm9:$offset)),
            (STURDi FPR64:$Rt, GPR64sp:$Rn, simm9:$offset)>;
}
def : Pat<(store (v1f64 FPR64:$Rt), (am_unscaled64 GPR64sp:$Rn, simm9:$offset)),
          (STURDi FPR64:$Rt, GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(store (v1i64 FPR64:$Rt), (am_unscaled64 GPR64sp:$Rn, simm9:$offset)),
          (STURDi FPR64:$Rt, GPR64sp:$Rn, simm9:$offset)>;

// Match all store 128 bits width whose type is compatible with FPR128
let Predicates = [IsLE] in {
  // We must use ST1 to store vectors in big-endian.
  def : Pat<(store (v4f32 FPR128:$Rt),
                   (am_unscaled128 GPR64sp:$Rn, simm9:$offset)),
            (STURQi FPR128:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v2f64 FPR128:$Rt),
                   (am_unscaled128 GPR64sp:$Rn, simm9:$offset)),
            (STURQi FPR128:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v16i8 FPR128:$Rt),
                   (am_unscaled128 GPR64sp:$Rn, simm9:$offset)),
            (STURQi FPR128:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v8i16 FPR128:$Rt),
                   (am_unscaled128 GPR64sp:$Rn, simm9:$offset)),
            (STURQi FPR128:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v4i32 FPR128:$Rt),
                   (am_unscaled128 GPR64sp:$Rn, simm9:$offset)),
            (STURQi FPR128:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v2i64 FPR128:$Rt),
                   (am_unscaled128 GPR64sp:$Rn, simm9:$offset)),
            (STURQi FPR128:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v2f64 FPR128:$Rt),
                   (am_unscaled128 GPR64sp:$Rn, simm9:$offset)),
            (STURQi FPR128:$Rt, GPR64sp:$Rn, simm9:$offset)>;
  def : Pat<(store (v8f16 FPR128:$Rt),
                   (am_unscaled128 GPR64sp:$Rn, simm9:$offset)),
            (STURQi FPR128:$Rt, GPR64sp:$Rn, simm9:$offset)>;
}

// unscaled i64 truncating stores
def : Pat<(truncstorei32 GPR64:$Rt, (am_unscaled32 GPR64sp:$Rn, simm9:$offset)),
  (STURWi (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(truncstorei16 GPR64:$Rt, (am_unscaled16 GPR64sp:$Rn, simm9:$offset)),
  (STURHHi (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$Rn, simm9:$offset)>;
def : Pat<(truncstorei8 GPR64:$Rt, (am_unscaled8 GPR64sp:$Rn, simm9:$offset)),
  (STURBBi (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$Rn, simm9:$offset)>;

//---
// STR mnemonics fall back to STUR for negative or unaligned offsets.
def : InstAlias<"str $Rt, [$Rn, $offset]",
                (STURXi GPR64:$Rt, GPR64sp:$Rn, simm9_offset_fb64:$offset), 0>;
def : InstAlias<"str $Rt, [$Rn, $offset]",
                (STURWi GPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb32:$offset), 0>;
def : InstAlias<"str $Rt, [$Rn, $offset]",
                (STURBi FPR8:$Rt, GPR64sp:$Rn, simm9_offset_fb8:$offset), 0>;
def : InstAlias<"str $Rt, [$Rn, $offset]",
                (STURHi FPR16:$Rt, GPR64sp:$Rn, simm9_offset_fb16:$offset), 0>;
def : InstAlias<"str $Rt, [$Rn, $offset]",
                (STURSi FPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb32:$offset), 0>;
def : InstAlias<"str $Rt, [$Rn, $offset]",
                (STURDi FPR64:$Rt, GPR64sp:$Rn, simm9_offset_fb64:$offset), 0>;
def : InstAlias<"str $Rt, [$Rn, $offset]",
                (STURQi FPR128:$Rt, GPR64sp:$Rn, simm9_offset_fb128:$offset), 0>;

def : InstAlias<"strb $Rt, [$Rn, $offset]",
                (STURBBi GPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb8:$offset), 0>;
def : InstAlias<"strh $Rt, [$Rn, $offset]",
                (STURHHi GPR32:$Rt, GPR64sp:$Rn, simm9_offset_fb16:$offset), 0>;

//---
// (unscaled immediate, unprivileged)
defm STTRW : StoreUnprivileged<0b10, 0, 0b00, GPR32, "sttr">;
defm STTRX : StoreUnprivileged<0b11, 0, 0b00, GPR64, "sttr">;

defm STTRH : StoreUnprivileged<0b01, 0, 0b00, GPR32, "sttrh">;
defm STTRB : StoreUnprivileged<0b00, 0, 0b00, GPR32, "sttrb">;

//---
// (immediate pre-indexed)
def STRWpre : StorePreIdx<0b10, 0, 0b00, GPR32, "str",  pre_store, i32>;
def STRXpre : StorePreIdx<0b11, 0, 0b00, GPR64, "str",  pre_store, i64>;
def STRBpre : StorePreIdx<0b00, 1, 0b00, FPR8,  "str",  pre_store, untyped>;
def STRHpre : StorePreIdx<0b01, 1, 0b00, FPR16, "str",  pre_store, f16>;
def STRSpre : StorePreIdx<0b10, 1, 0b00, FPR32, "str",  pre_store, f32>;
def STRDpre : StorePreIdx<0b11, 1, 0b00, FPR64, "str",  pre_store, f64>;
def STRQpre : StorePreIdx<0b00, 1, 0b10, FPR128, "str", pre_store, f128>;

def STRBBpre : StorePreIdx<0b00, 0, 0b00, GPR32, "strb", pre_truncsti8,  i32>;
def STRHHpre : StorePreIdx<0b01, 0, 0b00, GPR32, "strh", pre_truncsti16, i32>;

// truncstore i64
def : Pat<(pre_truncsti32 GPR64:$Rt, GPR64sp:$addr, simm9:$off),
  (STRWpre (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$addr,
           simm9:$off)>;
def : Pat<(pre_truncsti16 GPR64:$Rt, GPR64sp:$addr, simm9:$off),
  (STRHHpre (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$addr,
            simm9:$off)>;
def : Pat<(pre_truncsti8 GPR64:$Rt, GPR64sp:$addr, simm9:$off),
  (STRBBpre (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$addr,
            simm9:$off)>;

def : Pat<(pre_store (v8i8 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpre FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v4i16 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpre FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v2i32 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpre FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v2f32 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpre FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v1i64 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpre FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v1f64 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpre FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v4f16 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpre FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;

def : Pat<(pre_store (v16i8 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpre FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v8i16 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpre FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v4i32 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpre FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v4f32 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpre FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v2i64 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpre FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v2f64 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpre FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(pre_store (v8f16 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpre FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;

//---
// (immediate post-indexed)
def STRWpost : StorePostIdx<0b10, 0, 0b00, GPR32,  "str", post_store, i32>;
def STRXpost : StorePostIdx<0b11, 0, 0b00, GPR64,  "str", post_store, i64>;
def STRBpost : StorePostIdx<0b00, 1, 0b00, FPR8,   "str", post_store, untyped>;
def STRHpost : StorePostIdx<0b01, 1, 0b00, FPR16,  "str", post_store, f16>;
def STRSpost : StorePostIdx<0b10, 1, 0b00, FPR32,  "str", post_store, f32>;
def STRDpost : StorePostIdx<0b11, 1, 0b00, FPR64,  "str", post_store, f64>;
def STRQpost : StorePostIdx<0b00, 1, 0b10, FPR128, "str", post_store, f128>;

def STRBBpost : StorePostIdx<0b00, 0, 0b00, GPR32, "strb", post_truncsti8, i32>;
def STRHHpost : StorePostIdx<0b01, 0, 0b00, GPR32, "strh", post_truncsti16, i32>;

// truncstore i64
def : Pat<(post_truncsti32 GPR64:$Rt, GPR64sp:$addr, simm9:$off),
  (STRWpost (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$addr,
            simm9:$off)>;
def : Pat<(post_truncsti16 GPR64:$Rt, GPR64sp:$addr, simm9:$off),
  (STRHHpost (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$addr,
             simm9:$off)>;
def : Pat<(post_truncsti8 GPR64:$Rt, GPR64sp:$addr, simm9:$off),
  (STRBBpost (EXTRACT_SUBREG GPR64:$Rt, sub_32), GPR64sp:$addr,
             simm9:$off)>;

def : Pat<(post_store (v8i8 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpost FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v4i16 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpost FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v2i32 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpost FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v2f32 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpost FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v1i64 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpost FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v1f64 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpost FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v4f16 FPR64:$Rt), GPR64sp:$addr, simm9:$off),
          (STRDpost FPR64:$Rt, GPR64sp:$addr, simm9:$off)>;

def : Pat<(post_store (v16i8 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpost FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v8i16 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpost FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v4i32 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpost FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v4f32 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpost FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v2i64 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpost FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v2f64 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpost FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;
def : Pat<(post_store (v8f16 FPR128:$Rt), GPR64sp:$addr, simm9:$off),
          (STRQpost FPR128:$Rt, GPR64sp:$addr, simm9:$off)>;

//===----------------------------------------------------------------------===//
// Load/store exclusive instructions.
//===----------------------------------------------------------------------===//

def LDARW  : LoadAcquire   <0b10, 1, 1, 0, 1, GPR32, "ldar">;
def LDARX  : LoadAcquire   <0b11, 1, 1, 0, 1, GPR64, "ldar">;
def LDARB  : LoadAcquire   <0b00, 1, 1, 0, 1, GPR32, "ldarb">;
def LDARH  : LoadAcquire   <0b01, 1, 1, 0, 1, GPR32, "ldarh">;

def LDAXRW : LoadExclusive <0b10, 0, 1, 0, 1, GPR32, "ldaxr">;
def LDAXRX : LoadExclusive <0b11, 0, 1, 0, 1, GPR64, "ldaxr">;
def LDAXRB : LoadExclusive <0b00, 0, 1, 0, 1, GPR32, "ldaxrb">;
def LDAXRH : LoadExclusive <0b01, 0, 1, 0, 1, GPR32, "ldaxrh">;

def LDXRW  : LoadExclusive <0b10, 0, 1, 0, 0, GPR32, "ldxr">;
def LDXRX  : LoadExclusive <0b11, 0, 1, 0, 0, GPR64, "ldxr">;
def LDXRB  : LoadExclusive <0b00, 0, 1, 0, 0, GPR32, "ldxrb">;
def LDXRH  : LoadExclusive <0b01, 0, 1, 0, 0, GPR32, "ldxrh">;

def STLRW  : StoreRelease  <0b10, 1, 0, 0, 1, GPR32, "stlr">;
def STLRX  : StoreRelease  <0b11, 1, 0, 0, 1, GPR64, "stlr">;
def STLRB  : StoreRelease  <0b00, 1, 0, 0, 1, GPR32, "stlrb">;
def STLRH  : StoreRelease  <0b01, 1, 0, 0, 1, GPR32, "stlrh">;

def STLXRW : StoreExclusive<0b10, 0, 0, 0, 1, GPR32, "stlxr">;
def STLXRX : StoreExclusive<0b11, 0, 0, 0, 1, GPR64, "stlxr">;
def STLXRB : StoreExclusive<0b00, 0, 0, 0, 1, GPR32, "stlxrb">;
def STLXRH : StoreExclusive<0b01, 0, 0, 0, 1, GPR32, "stlxrh">;

def STXRW  : StoreExclusive<0b10, 0, 0, 0, 0, GPR32, "stxr">;
def STXRX  : StoreExclusive<0b11, 0, 0, 0, 0, GPR64, "stxr">;
def STXRB  : StoreExclusive<0b00, 0, 0, 0, 0, GPR32, "stxrb">;
def STXRH  : StoreExclusive<0b01, 0, 0, 0, 0, GPR32, "stxrh">;

def LDAXPW : LoadExclusivePair<0b10, 0, 1, 1, 1, GPR32, "ldaxp">;
def LDAXPX : LoadExclusivePair<0b11, 0, 1, 1, 1, GPR64, "ldaxp">;

def LDXPW  : LoadExclusivePair<0b10, 0, 1, 1, 0, GPR32, "ldxp">;
def LDXPX  : LoadExclusivePair<0b11, 0, 1, 1, 0, GPR64, "ldxp">;

def STLXPW : StoreExclusivePair<0b10, 0, 0, 1, 1, GPR32, "stlxp">;
def STLXPX : StoreExclusivePair<0b11, 0, 0, 1, 1, GPR64, "stlxp">;

def STXPW  : StoreExclusivePair<0b10, 0, 0, 1, 0, GPR32, "stxp">;
def STXPX  : StoreExclusivePair<0b11, 0, 0, 1, 0, GPR64, "stxp">;

let Predicates = [HasV8_1a] in {
  // v8.1a "Limited Order Region" extension load-acquire instructions
  def LDLARW  : LoadAcquire   <0b10, 1, 1, 0, 0, GPR32, "ldlar">;
  def LDLARX  : LoadAcquire   <0b11, 1, 1, 0, 0, GPR64, "ldlar">;
  def LDLARB  : LoadAcquire   <0b00, 1, 1, 0, 0, GPR32, "ldlarb">;
  def LDLARH  : LoadAcquire   <0b01, 1, 1, 0, 0, GPR32, "ldlarh">;

  // v8.1a "Limited Order Region" extension store-release instructions
  def STLLRW  : StoreRelease   <0b10, 1, 0, 0, 0, GPR32, "stllr">;
  def STLLRX  : StoreRelease   <0b11, 1, 0, 0, 0, GPR64, "stllr">;
  def STLLRB  : StoreRelease   <0b00, 1, 0, 0, 0, GPR32, "stllrb">;
  def STLLRH  : StoreRelease   <0b01, 1, 0, 0, 0, GPR32, "stllrh">;
}

//===----------------------------------------------------------------------===//
// Scaled floating point to integer conversion instructions.
//===----------------------------------------------------------------------===//

defm FCVTAS : FPToIntegerUnscaled<0b00, 0b100, "fcvtas", int_aarch64_neon_fcvtas>;
defm FCVTAU : FPToIntegerUnscaled<0b00, 0b101, "fcvtau", int_aarch64_neon_fcvtau>;
defm FCVTMS : FPToIntegerUnscaled<0b10, 0b000, "fcvtms", int_aarch64_neon_fcvtms>;
defm FCVTMU : FPToIntegerUnscaled<0b10, 0b001, "fcvtmu", int_aarch64_neon_fcvtmu>;
defm FCVTNS : FPToIntegerUnscaled<0b00, 0b000, "fcvtns", int_aarch64_neon_fcvtns>;
defm FCVTNU : FPToIntegerUnscaled<0b00, 0b001, "fcvtnu", int_aarch64_neon_fcvtnu>;
defm FCVTPS : FPToIntegerUnscaled<0b01, 0b000, "fcvtps", int_aarch64_neon_fcvtps>;
defm FCVTPU : FPToIntegerUnscaled<0b01, 0b001, "fcvtpu", int_aarch64_neon_fcvtpu>;
defm FCVTZS : FPToIntegerUnscaled<0b11, 0b000, "fcvtzs", fp_to_sint>;
defm FCVTZU : FPToIntegerUnscaled<0b11, 0b001, "fcvtzu", fp_to_uint>;
defm FCVTZS : FPToIntegerScaled<0b11, 0b000, "fcvtzs", fp_to_sint>;
defm FCVTZU : FPToIntegerScaled<0b11, 0b001, "fcvtzu", fp_to_uint>;

multiclass FPToIntegerIntPats<Intrinsic round, string INST> {
  def : Pat<(i32 (round f16:$Rn)), (!cast<Instruction>(INST # UWHr) $Rn)>;
  def : Pat<(i64 (round f16:$Rn)), (!cast<Instruction>(INST # UXHr) $Rn)>;
  def : Pat<(i32 (round f32:$Rn)), (!cast<Instruction>(INST # UWSr) $Rn)>;
  def : Pat<(i64 (round f32:$Rn)), (!cast<Instruction>(INST # UXSr) $Rn)>;
  def : Pat<(i32 (round f64:$Rn)), (!cast<Instruction>(INST # UWDr) $Rn)>;
  def : Pat<(i64 (round f64:$Rn)), (!cast<Instruction>(INST # UXDr) $Rn)>;

  def : Pat<(i32 (round (fmul f16:$Rn, fixedpoint_f16_i32:$scale))),
            (!cast<Instruction>(INST # SWHri) $Rn, $scale)>;
  def : Pat<(i64 (round (fmul f16:$Rn, fixedpoint_f16_i64:$scale))),
            (!cast<Instruction>(INST # SXHri) $Rn, $scale)>;
  def : Pat<(i32 (round (fmul f32:$Rn, fixedpoint_f32_i32:$scale))),
            (!cast<Instruction>(INST # SWSri) $Rn, $scale)>;
  def : Pat<(i64 (round (fmul f32:$Rn, fixedpoint_f32_i64:$scale))),
            (!cast<Instruction>(INST # SXSri) $Rn, $scale)>;
  def : Pat<(i32 (round (fmul f64:$Rn, fixedpoint_f64_i32:$scale))),
            (!cast<Instruction>(INST # SWDri) $Rn, $scale)>;
  def : Pat<(i64 (round (fmul f64:$Rn, fixedpoint_f64_i64:$scale))),
            (!cast<Instruction>(INST # SXDri) $Rn, $scale)>;
}

defm : FPToIntegerIntPats<int_aarch64_neon_fcvtzs, "FCVTZS">;
defm : FPToIntegerIntPats<int_aarch64_neon_fcvtzu, "FCVTZU">;

multiclass FPToIntegerPats<SDNode to_int, SDNode round, string INST> {
  def : Pat<(i32 (to_int (round f32:$Rn))),
            (!cast<Instruction>(INST # UWSr) f32:$Rn)>;
  def : Pat<(i64 (to_int (round f32:$Rn))),
            (!cast<Instruction>(INST # UXSr) f32:$Rn)>;
  def : Pat<(i32 (to_int (round f64:$Rn))),
            (!cast<Instruction>(INST # UWDr) f64:$Rn)>;
  def : Pat<(i64 (to_int (round f64:$Rn))),
            (!cast<Instruction>(INST # UXDr) f64:$Rn)>;
}

defm : FPToIntegerPats<fp_to_sint, fceil,  "FCVTPS">;
defm : FPToIntegerPats<fp_to_uint, fceil,  "FCVTPU">;
defm : FPToIntegerPats<fp_to_sint, ffloor, "FCVTMS">;
defm : FPToIntegerPats<fp_to_uint, ffloor, "FCVTMU">;
defm : FPToIntegerPats<fp_to_sint, ftrunc, "FCVTZS">;
defm : FPToIntegerPats<fp_to_uint, ftrunc, "FCVTZU">;
defm : FPToIntegerPats<fp_to_sint, frnd,   "FCVTAS">;
defm : FPToIntegerPats<fp_to_uint, frnd,   "FCVTAU">;

//===----------------------------------------------------------------------===//
// Scaled integer to floating point conversion instructions.
//===----------------------------------------------------------------------===//

defm SCVTF : IntegerToFP<0, "scvtf", sint_to_fp>;
defm UCVTF : IntegerToFP<1, "ucvtf", uint_to_fp>;

//===----------------------------------------------------------------------===//
// Unscaled integer to floating point conversion instruction.
//===----------------------------------------------------------------------===//

defm FMOV : UnscaledConversion<"fmov">;

// Add pseudo ops for FMOV 0 so we can mark them as isReMaterializable
let isReMaterializable = 1, isCodeGenOnly = 1 in {
def FMOVH0 : Pseudo<(outs FPR16:$Rd), (ins), [(set f16:$Rd, (fpimm0))]>,
    PseudoInstExpansion<(FMOVWSr FPR32:$Rd, WZR)>,
    Sched<[WriteF]>,
    Requires<[NoZCZ]>;
def FMOVS0 : Pseudo<(outs FPR32:$Rd), (ins), [(set f32:$Rd, (fpimm0))]>,
    PseudoInstExpansion<(FMOVWSr FPR32:$Rd, WZR)>,
    Sched<[WriteF]>,
    Requires<[NoZCZ]>;
def FMOVD0 : Pseudo<(outs FPR64:$Rd), (ins), [(set f64:$Rd, (fpimm0))]>,
    PseudoInstExpansion<(FMOVXDr FPR64:$Rd, XZR)>,
    Sched<[WriteF]>,
    Requires<[NoZCZ]>;
}

//===----------------------------------------------------------------------===//
// Floating point conversion instruction.
//===----------------------------------------------------------------------===//

defm FCVT : FPConversion<"fcvt">;

//===----------------------------------------------------------------------===//
// Floating point single operand instructions.
//===----------------------------------------------------------------------===//

defm FABS   : SingleOperandFPData<0b0001, "fabs", fabs>;
defm FMOV   : SingleOperandFPData<0b0000, "fmov">;
defm FNEG   : SingleOperandFPData<0b0010, "fneg", fneg>;
defm FRINTA : SingleOperandFPData<0b1100, "frinta", frnd>;
defm FRINTI : SingleOperandFPData<0b1111, "frinti", fnearbyint>;
defm FRINTM : SingleOperandFPData<0b1010, "frintm", ffloor>;
defm FRINTN : SingleOperandFPData<0b1000, "frintn", int_aarch64_neon_frintn>;
defm FRINTP : SingleOperandFPData<0b1001, "frintp", fceil>;

def : Pat<(v1f64 (int_aarch64_neon_frintn (v1f64 FPR64:$Rn))),
          (FRINTNDr FPR64:$Rn)>;

defm FRINTX : SingleOperandFPData<0b1110, "frintx", frint>;
defm FRINTZ : SingleOperandFPData<0b1011, "frintz", ftrunc>;

let SchedRW = [WriteFDiv] in {
defm FSQRT  : SingleOperandFPData<0b0011, "fsqrt", fsqrt>;
}

//===----------------------------------------------------------------------===//
// Floating point two operand instructions.
//===----------------------------------------------------------------------===//

defm FADD   : TwoOperandFPData<0b0010, "fadd", fadd>;
let SchedRW = [WriteFDiv] in {
defm FDIV   : TwoOperandFPData<0b0001, "fdiv", fdiv>;
}
defm FMAXNM : TwoOperandFPData<0b0110, "fmaxnm", fmaxnum>;
defm FMAX   : TwoOperandFPData<0b0100, "fmax", fmaxnan>;
defm FMINNM : TwoOperandFPData<0b0111, "fminnm", fminnum>;
defm FMIN   : TwoOperandFPData<0b0101, "fmin", fminnan>;
let SchedRW = [WriteFMul] in {
defm FMUL   : TwoOperandFPData<0b0000, "fmul", fmul>;
defm FNMUL  : TwoOperandFPDataNeg<0b1000, "fnmul", fmul>;
}
defm FSUB   : TwoOperandFPData<0b0011, "fsub", fsub>;

def : Pat<(v1f64 (fmaxnan (v1f64 FPR64:$Rn), (v1f64 FPR64:$Rm))),
          (FMAXDrr FPR64:$Rn, FPR64:$Rm)>;
def : Pat<(v1f64 (fminnan (v1f64 FPR64:$Rn), (v1f64 FPR64:$Rm))),
          (FMINDrr FPR64:$Rn, FPR64:$Rm)>;
def : Pat<(v1f64 (fmaxnum (v1f64 FPR64:$Rn), (v1f64 FPR64:$Rm))),
          (FMAXNMDrr FPR64:$Rn, FPR64:$Rm)>;
def : Pat<(v1f64 (fminnum (v1f64 FPR64:$Rn), (v1f64 FPR64:$Rm))),
          (FMINNMDrr FPR64:$Rn, FPR64:$Rm)>;

//===----------------------------------------------------------------------===//
// Floating point three operand instructions.
//===----------------------------------------------------------------------===//

defm FMADD  : ThreeOperandFPData<0, 0, "fmadd", fma>;
defm FMSUB  : ThreeOperandFPData<0, 1, "fmsub",
     TriOpFrag<(fma node:$LHS, (fneg node:$MHS), node:$RHS)> >;
defm FNMADD : ThreeOperandFPData<1, 0, "fnmadd",
     TriOpFrag<(fneg (fma node:$LHS, node:$MHS, node:$RHS))> >;
defm FNMSUB : ThreeOperandFPData<1, 1, "fnmsub",
     TriOpFrag<(fma node:$LHS, node:$MHS, (fneg node:$RHS))> >;

// The following def pats catch the case where the LHS of an FMA is negated.
// The TriOpFrag above catches the case where the middle operand is negated.

// N.b. FMSUB etc have the accumulator at the *end* of (outs), unlike
// the NEON variant.
def : Pat<(f32 (fma (fneg FPR32:$Rn), FPR32:$Rm, FPR32:$Ra)),
          (FMSUBSrrr FPR32:$Rn, FPR32:$Rm, FPR32:$Ra)>;

def : Pat<(f64 (fma (fneg FPR64:$Rn), FPR64:$Rm, FPR64:$Ra)),
          (FMSUBDrrr FPR64:$Rn, FPR64:$Rm, FPR64:$Ra)>;

// We handled -(a + b*c) for FNMADD above, now it's time for "(-a) + (-b)*c" and
// "(-a) + b*(-c)".
def : Pat<(f32 (fma (fneg FPR32:$Rn), FPR32:$Rm, (fneg FPR32:$Ra))),
          (FNMADDSrrr FPR32:$Rn, FPR32:$Rm, FPR32:$Ra)>;

def : Pat<(f64 (fma (fneg FPR64:$Rn), FPR64:$Rm, (fneg FPR64:$Ra))),
          (FNMADDDrrr FPR64:$Rn, FPR64:$Rm, FPR64:$Ra)>;

def : Pat<(f32 (fma FPR32:$Rn, (fneg FPR32:$Rm), (fneg FPR32:$Ra))),
          (FNMADDSrrr FPR32:$Rn, FPR32:$Rm, FPR32:$Ra)>;

def : Pat<(f64 (fma FPR64:$Rn, (fneg FPR64:$Rm), (fneg FPR64:$Ra))),
          (FNMADDDrrr FPR64:$Rn, FPR64:$Rm, FPR64:$Ra)>;

//===----------------------------------------------------------------------===//
// Floating point comparison instructions.
//===----------------------------------------------------------------------===//

defm FCMPE : FPComparison<1, "fcmpe">;
defm FCMP  : FPComparison<0, "fcmp", AArch64fcmp>;

//===----------------------------------------------------------------------===//
// Floating point conditional comparison instructions.
//===----------------------------------------------------------------------===//

defm FCCMPE : FPCondComparison<1, "fccmpe">;
defm FCCMP  : FPCondComparison<0, "fccmp", AArch64fccmp>;

//===----------------------------------------------------------------------===//
// Floating point conditional select instruction.
//===----------------------------------------------------------------------===//

defm FCSEL : FPCondSelect<"fcsel">;

// CSEL instructions providing f128 types need to be handled by a
// pseudo-instruction since the eventual code will need to introduce basic
// blocks and control flow.
def F128CSEL : Pseudo<(outs FPR128:$Rd),
                      (ins FPR128:$Rn, FPR128:$Rm, ccode:$cond),
                      [(set (f128 FPR128:$Rd),
                            (AArch64csel FPR128:$Rn, FPR128:$Rm,
                                       (i32 imm:$cond), NZCV))]> {
  let Uses = [NZCV];
  let usesCustomInserter = 1;
  let hasNoSchedulingInfo = 1;
}


//===----------------------------------------------------------------------===//
// Floating point immediate move.
//===----------------------------------------------------------------------===//

let isReMaterializable = 1 in {
defm FMOV : FPMoveImmediate<"fmov">;
}

//===----------------------------------------------------------------------===//
// Advanced SIMD two vector instructions.
//===----------------------------------------------------------------------===//

defm UABDL   : SIMDLongThreeVectorBHSabdl<1, 0b0111, "uabdl",
                                          int_aarch64_neon_uabd>;
// Match UABDL in log2-shuffle patterns.
def : Pat<(xor (v8i16 (AArch64vashr v8i16:$src, (i32 15))),
               (v8i16 (add (sub (zext (v8i8 V64:$opA)),
                                (zext (v8i8 V64:$opB))),
                           (AArch64vashr v8i16:$src, (i32 15))))),
          (UABDLv8i8_v8i16 V64:$opA, V64:$opB)>;
def : Pat<(xor (v8i16 (AArch64vashr v8i16:$src, (i32 15))),
               (v8i16 (add (sub (zext (extract_high_v16i8 V128:$opA)),
                                (zext (extract_high_v16i8 V128:$opB))),
                           (AArch64vashr v8i16:$src, (i32 15))))),
          (UABDLv16i8_v8i16 V128:$opA, V128:$opB)>;
def : Pat<(xor (v4i32 (AArch64vashr v4i32:$src, (i32 31))),
               (v4i32 (add (sub (zext (v4i16 V64:$opA)),
                                (zext (v4i16 V64:$opB))),
                           (AArch64vashr v4i32:$src, (i32 31))))),
          (UABDLv4i16_v4i32 V64:$opA, V64:$opB)>;
def : Pat<(xor (v4i32 (AArch64vashr v4i32:$src, (i32 31))),
               (v4i32 (add (sub (zext (extract_high_v8i16 V128:$opA)),
                                (zext (extract_high_v8i16 V128:$opB))),
                          (AArch64vashr v4i32:$src, (i32 31))))),
          (UABDLv8i16_v4i32 V128:$opA, V128:$opB)>;
def : Pat<(xor (v2i64 (AArch64vashr v2i64:$src, (i32 63))),
               (v2i64 (add (sub (zext (v2i32 V64:$opA)),
                                (zext (v2i32 V64:$opB))),
                           (AArch64vashr v2i64:$src, (i32 63))))),
          (UABDLv2i32_v2i64 V64:$opA, V64:$opB)>;
def : Pat<(xor (v2i64 (AArch64vashr v2i64:$src, (i32 63))),
               (v2i64 (add (sub (zext (extract_high_v4i32 V128:$opA)),
                                (zext (extract_high_v4i32 V128:$opB))),
                          (AArch64vashr v2i64:$src, (i32 63))))),
          (UABDLv4i32_v2i64 V128:$opA, V128:$opB)>;

defm ABS    : SIMDTwoVectorBHSD<0, 0b01011, "abs", int_aarch64_neon_abs>;
def : Pat<(xor (v8i8 (AArch64vashr V64:$src, (i32 7))),
               (v8i8 (add V64:$src, (AArch64vashr V64:$src, (i32 7))))),
          (ABSv8i8 V64:$src)>;
def : Pat<(xor (v4i16 (AArch64vashr V64:$src, (i32 15))),
               (v4i16 (add V64:$src, (AArch64vashr V64:$src, (i32 15))))),
          (ABSv4i16 V64:$src)>;
def : Pat<(xor (v2i32 (AArch64vashr V64:$src, (i32 31))),
               (v2i32 (add V64:$src, (AArch64vashr V64:$src, (i32 31))))),
          (ABSv2i32 V64:$src)>;
def : Pat<(xor (v16i8 (AArch64vashr V128:$src, (i32 7))),
               (v16i8 (add V128:$src, (AArch64vashr V128:$src, (i32 7))))),
          (ABSv16i8 V128:$src)>;
def : Pat<(xor (v8i16 (AArch64vashr V128:$src, (i32 15))),
               (v8i16 (add V128:$src, (AArch64vashr V128:$src, (i32 15))))),
          (ABSv8i16 V128:$src)>;
def : Pat<(xor (v4i32 (AArch64vashr V128:$src, (i32 31))),
               (v4i32 (add V128:$src, (AArch64vashr V128:$src, (i32 31))))),
          (ABSv4i32 V128:$src)>;
def : Pat<(xor (v2i64 (AArch64vashr V128:$src, (i32 63))),
               (v2i64 (add V128:$src, (AArch64vashr V128:$src, (i32 63))))),
          (ABSv2i64 V128:$src)>;

defm CLS    : SIMDTwoVectorBHS<0, 0b00100, "cls", int_aarch64_neon_cls>;
defm CLZ    : SIMDTwoVectorBHS<1, 0b00100, "clz", ctlz>;
defm CMEQ   : SIMDCmpTwoVector<0, 0b01001, "cmeq", AArch64cmeqz>;
defm CMGE   : SIMDCmpTwoVector<1, 0b01000, "cmge", AArch64cmgez>;
defm CMGT   : SIMDCmpTwoVector<0, 0b01000, "cmgt", AArch64cmgtz>;
defm CMLE   : SIMDCmpTwoVector<1, 0b01001, "cmle", AArch64cmlez>;
defm CMLT   : SIMDCmpTwoVector<0, 0b01010, "cmlt", AArch64cmltz>;
defm CNT    : SIMDTwoVectorB<0, 0b00, 0b00101, "cnt", ctpop>;
defm FABS   : SIMDTwoVectorFP<0, 1, 0b01111, "fabs", fabs>;

defm FCMEQ  : SIMDFPCmpTwoVector<0, 1, 0b01101, "fcmeq", AArch64fcmeqz>;
defm FCMGE  : SIMDFPCmpTwoVector<1, 1, 0b01100, "fcmge", AArch64fcmgez>;
defm FCMGT  : SIMDFPCmpTwoVector<0, 1, 0b01100, "fcmgt", AArch64fcmgtz>;
defm FCMLE  : SIMDFPCmpTwoVector<1, 1, 0b01101, "fcmle", AArch64fcmlez>;
defm FCMLT  : SIMDFPCmpTwoVector<0, 1, 0b01110, "fcmlt", AArch64fcmltz>;
defm FCVTAS : SIMDTwoVectorFPToInt<0,0,0b11100, "fcvtas",int_aarch64_neon_fcvtas>;
defm FCVTAU : SIMDTwoVectorFPToInt<1,0,0b11100, "fcvtau",int_aarch64_neon_fcvtau>;
defm FCVTL  : SIMDFPWidenTwoVector<0, 0, 0b10111, "fcvtl">;
def : Pat<(v4f32 (int_aarch64_neon_vcvthf2fp (v4i16 V64:$Rn))),
          (FCVTLv4i16 V64:$Rn)>;
def : Pat<(v4f32 (int_aarch64_neon_vcvthf2fp (extract_subvector (v8i16 V128:$Rn),
                                                              (i64 4)))),
          (FCVTLv8i16 V128:$Rn)>;
def : Pat<(v2f64 (fextend (v2f32 V64:$Rn))), (FCVTLv2i32 V64:$Rn)>;
def : Pat<(v2f64 (fextend (v2f32 (extract_subvector (v4f32 V128:$Rn),
                                                    (i64 2))))),
          (FCVTLv4i32 V128:$Rn)>;

def : Pat<(v4f32 (fextend (v4f16 V64:$Rn))), (FCVTLv4i16 V64:$Rn)>;
def : Pat<(v4f32 (fextend (v4f16 (extract_subvector (v8f16 V128:$Rn),
                                                    (i64 4))))),
          (FCVTLv8i16 V128:$Rn)>;

defm FCVTMS : SIMDTwoVectorFPToInt<0,0,0b11011, "fcvtms",int_aarch64_neon_fcvtms>;
defm FCVTMU : SIMDTwoVectorFPToInt<1,0,0b11011, "fcvtmu",int_aarch64_neon_fcvtmu>;
defm FCVTNS : SIMDTwoVectorFPToInt<0,0,0b11010, "fcvtns",int_aarch64_neon_fcvtns>;
defm FCVTNU : SIMDTwoVectorFPToInt<1,0,0b11010, "fcvtnu",int_aarch64_neon_fcvtnu>;
defm FCVTN  : SIMDFPNarrowTwoVector<0, 0, 0b10110, "fcvtn">;
def : Pat<(v4i16 (int_aarch64_neon_vcvtfp2hf (v4f32 V128:$Rn))),
          (FCVTNv4i16 V128:$Rn)>;
def : Pat<(concat_vectors V64:$Rd,
                          (v4i16 (int_aarch64_neon_vcvtfp2hf (v4f32 V128:$Rn)))),
          (FCVTNv8i16 (INSERT_SUBREG (IMPLICIT_DEF), V64:$Rd, dsub), V128:$Rn)>;
def : Pat<(v2f32 (fround (v2f64 V128:$Rn))), (FCVTNv2i32 V128:$Rn)>;
def : Pat<(v4f16 (fround (v4f32 V128:$Rn))), (FCVTNv4i16 V128:$Rn)>;
def : Pat<(concat_vectors V64:$Rd, (v2f32 (fround (v2f64 V128:$Rn)))),
          (FCVTNv4i32 (INSERT_SUBREG (IMPLICIT_DEF), V64:$Rd, dsub), V128:$Rn)>;
defm FCVTPS : SIMDTwoVectorFPToInt<0,1,0b11010, "fcvtps",int_aarch64_neon_fcvtps>;
defm FCVTPU : SIMDTwoVectorFPToInt<1,1,0b11010, "fcvtpu",int_aarch64_neon_fcvtpu>;
defm FCVTXN : SIMDFPInexactCvtTwoVector<1, 0, 0b10110, "fcvtxn",
                                        int_aarch64_neon_fcvtxn>;
defm FCVTZS : SIMDTwoVectorFPToInt<0, 1, 0b11011, "fcvtzs", fp_to_sint>;
defm FCVTZU : SIMDTwoVectorFPToInt<1, 1, 0b11011, "fcvtzu", fp_to_uint>;

def : Pat<(v4i16 (int_aarch64_neon_fcvtzs v4f16:$Rn)), (FCVTZSv4f16 $Rn)>;
def : Pat<(v8i16 (int_aarch64_neon_fcvtzs v8f16:$Rn)), (FCVTZSv8f16 $Rn)>;
def : Pat<(v2i32 (int_aarch64_neon_fcvtzs v2f32:$Rn)), (FCVTZSv2f32 $Rn)>;
def : Pat<(v4i32 (int_aarch64_neon_fcvtzs v4f32:$Rn)), (FCVTZSv4f32 $Rn)>;
def : Pat<(v2i64 (int_aarch64_neon_fcvtzs v2f64:$Rn)), (FCVTZSv2f64 $Rn)>;

def : Pat<(v4i16 (int_aarch64_neon_fcvtzu v4f16:$Rn)), (FCVTZUv4f16 $Rn)>;
def : Pat<(v8i16 (int_aarch64_neon_fcvtzu v8f16:$Rn)), (FCVTZUv8f16 $Rn)>;
def : Pat<(v2i32 (int_aarch64_neon_fcvtzu v2f32:$Rn)), (FCVTZUv2f32 $Rn)>;
def : Pat<(v4i32 (int_aarch64_neon_fcvtzu v4f32:$Rn)), (FCVTZUv4f32 $Rn)>;
def : Pat<(v2i64 (int_aarch64_neon_fcvtzu v2f64:$Rn)), (FCVTZUv2f64 $Rn)>;

defm FNEG   : SIMDTwoVectorFP<1, 1, 0b01111, "fneg", fneg>;
defm FRECPE : SIMDTwoVectorFP<0, 1, 0b11101, "frecpe", int_aarch64_neon_frecpe>;
defm FRINTA : SIMDTwoVectorFP<1, 0, 0b11000, "frinta", frnd>;
defm FRINTI : SIMDTwoVectorFP<1, 1, 0b11001, "frinti", fnearbyint>;
defm FRINTM : SIMDTwoVectorFP<0, 0, 0b11001, "frintm", ffloor>;
defm FRINTN : SIMDTwoVectorFP<0, 0, 0b11000, "frintn", int_aarch64_neon_frintn>;
defm FRINTP : SIMDTwoVectorFP<0, 1, 0b11000, "frintp", fceil>;
defm FRINTX : SIMDTwoVectorFP<1, 0, 0b11001, "frintx", frint>;
defm FRINTZ : SIMDTwoVectorFP<0, 1, 0b11001, "frintz", ftrunc>;
defm FRSQRTE: SIMDTwoVectorFP<1, 1, 0b11101, "frsqrte", int_aarch64_neon_frsqrte>;
defm FSQRT  : SIMDTwoVectorFP<1, 1, 0b11111, "fsqrt", fsqrt>;
defm NEG    : SIMDTwoVectorBHSD<1, 0b01011, "neg",
                               UnOpFrag<(sub immAllZerosV, node:$LHS)> >;
defm NOT    : SIMDTwoVectorB<1, 0b00, 0b00101, "not", vnot>;
// Aliases for MVN -> NOT.
def : InstAlias<"mvn{ $Vd.8b, $Vn.8b|.8b $Vd, $Vn}",
                (NOTv8i8 V64:$Vd, V64:$Vn)>;
def : InstAlias<"mvn{ $Vd.16b, $Vn.16b|.16b $Vd, $Vn}",
                (NOTv16i8 V128:$Vd, V128:$Vn)>;

def : Pat<(AArch64neg (v8i8  V64:$Rn)),  (NEGv8i8  V64:$Rn)>;
def : Pat<(AArch64neg (v16i8 V128:$Rn)), (NEGv16i8 V128:$Rn)>;
def : Pat<(AArch64neg (v4i16 V64:$Rn)),  (NEGv4i16 V64:$Rn)>;
def : Pat<(AArch64neg (v8i16 V128:$Rn)), (NEGv8i16 V128:$Rn)>;
def : Pat<(AArch64neg (v2i32 V64:$Rn)),  (NEGv2i32 V64:$Rn)>;
def : Pat<(AArch64neg (v4i32 V128:$Rn)), (NEGv4i32 V128:$Rn)>;
def : Pat<(AArch64neg (v2i64 V128:$Rn)), (NEGv2i64 V128:$Rn)>;

def : Pat<(AArch64not (v8i8 V64:$Rn)),   (NOTv8i8  V64:$Rn)>;
def : Pat<(AArch64not (v16i8 V128:$Rn)), (NOTv16i8 V128:$Rn)>;
def : Pat<(AArch64not (v4i16 V64:$Rn)),  (NOTv8i8  V64:$Rn)>;
def : Pat<(AArch64not (v8i16 V128:$Rn)), (NOTv16i8 V128:$Rn)>;
def : Pat<(AArch64not (v2i32 V64:$Rn)),  (NOTv8i8  V64:$Rn)>;
def : Pat<(AArch64not (v1i64 V64:$Rn)),  (NOTv8i8  V64:$Rn)>;
def : Pat<(AArch64not (v4i32 V128:$Rn)), (NOTv16i8 V128:$Rn)>;
def : Pat<(AArch64not (v2i64 V128:$Rn)), (NOTv16i8 V128:$Rn)>;

def : Pat<(vnot (v4i16 V64:$Rn)),  (NOTv8i8  V64:$Rn)>;
def : Pat<(vnot (v8i16 V128:$Rn)), (NOTv16i8 V128:$Rn)>;
def : Pat<(vnot (v2i32 V64:$Rn)),  (NOTv8i8  V64:$Rn)>;
def : Pat<(vnot (v4i32 V128:$Rn)), (NOTv16i8 V128:$Rn)>;
def : Pat<(vnot (v2i64 V128:$Rn)), (NOTv16i8 V128:$Rn)>;

defm RBIT   : SIMDTwoVectorB<1, 0b01, 0b00101, "rbit", int_aarch64_neon_rbit>;
defm REV16  : SIMDTwoVectorB<0, 0b00, 0b00001, "rev16", AArch64rev16>;
defm REV32  : SIMDTwoVectorBH<1, 0b00000, "rev32", AArch64rev32>;
defm REV64  : SIMDTwoVectorBHS<0, 0b00000, "rev64", AArch64rev64>;
defm SADALP : SIMDLongTwoVectorTied<0, 0b00110, "sadalp",
       BinOpFrag<(add node:$LHS, (int_aarch64_neon_saddlp node:$RHS))> >;
defm SADDLP : SIMDLongTwoVector<0, 0b00010, "saddlp", int_aarch64_neon_saddlp>;
defm SCVTF  : SIMDTwoVectorIntToFP<0, 0, 0b11101, "scvtf", sint_to_fp>;
defm SHLL   : SIMDVectorLShiftLongBySizeBHS;
defm SQABS  : SIMDTwoVectorBHSD<0, 0b00111, "sqabs", int_aarch64_neon_sqabs>;
defm SQNEG  : SIMDTwoVectorBHSD<1, 0b00111, "sqneg", int_aarch64_neon_sqneg>;
defm SQXTN  : SIMDMixedTwoVector<0, 0b10100, "sqxtn", int_aarch64_neon_sqxtn>;
defm SQXTUN : SIMDMixedTwoVector<1, 0b10010, "sqxtun", int_aarch64_neon_sqxtun>;
defm SUQADD : SIMDTwoVectorBHSDTied<0, 0b00011, "suqadd",int_aarch64_neon_suqadd>;
defm UADALP : SIMDLongTwoVectorTied<1, 0b00110, "uadalp",
       BinOpFrag<(add node:$LHS, (int_aarch64_neon_uaddlp node:$RHS))> >;
defm UADDLP : SIMDLongTwoVector<1, 0b00010, "uaddlp",
                    int_aarch64_neon_uaddlp>;
defm UCVTF  : SIMDTwoVectorIntToFP<1, 0, 0b11101, "ucvtf", uint_to_fp>;
defm UQXTN  : SIMDMixedTwoVector<1, 0b10100, "uqxtn", int_aarch64_neon_uqxtn>;
defm URECPE : SIMDTwoVectorS<0, 1, 0b11100, "urecpe", int_aarch64_neon_urecpe>;
defm URSQRTE: SIMDTwoVectorS<1, 1, 0b11100, "ursqrte", int_aarch64_neon_ursqrte>;
defm USQADD : SIMDTwoVectorBHSDTied<1, 0b00011, "usqadd",int_aarch64_neon_usqadd>;
defm XTN    : SIMDMixedTwoVector<0, 0b10010, "xtn", trunc>;

def : Pat<(v4f16 (AArch64rev32 V64:$Rn)), (REV32v4i16 V64:$Rn)>;
def : Pat<(v4f16 (AArch64rev64 V64:$Rn)), (REV64v4i16 V64:$Rn)>;
def : Pat<(v8f16 (AArch64rev32 V128:$Rn)), (REV32v8i16 V128:$Rn)>;
def : Pat<(v8f16 (AArch64rev64 V128:$Rn)), (REV64v8i16 V128:$Rn)>;
def : Pat<(v2f32 (AArch64rev64 V64:$Rn)), (REV64v2i32 V64:$Rn)>;
def : Pat<(v4f32 (AArch64rev64 V128:$Rn)), (REV64v4i32 V128:$Rn)>;

// Patterns for vector long shift (by element width). These need to match all
// three of zext, sext and anyext so it's easier to pull the patterns out of the
// definition.
multiclass SIMDVectorLShiftLongBySizeBHSPats<SDPatternOperator ext> {
  def : Pat<(AArch64vshl (v8i16 (ext (v8i8 V64:$Rn))), (i32 8)),
            (SHLLv8i8 V64:$Rn)>;
  def : Pat<(AArch64vshl (v8i16 (ext (extract_high_v16i8 V128:$Rn))), (i32 8)),
            (SHLLv16i8 V128:$Rn)>;
  def : Pat<(AArch64vshl (v4i32 (ext (v4i16 V64:$Rn))), (i32 16)),
            (SHLLv4i16 V64:$Rn)>;
  def : Pat<(AArch64vshl (v4i32 (ext (extract_high_v8i16 V128:$Rn))), (i32 16)),
            (SHLLv8i16 V128:$Rn)>;
  def : Pat<(AArch64vshl (v2i64 (ext (v2i32 V64:$Rn))), (i32 32)),
            (SHLLv2i32 V64:$Rn)>;
  def : Pat<(AArch64vshl (v2i64 (ext (extract_high_v4i32 V128:$Rn))), (i32 32)),
            (SHLLv4i32 V128:$Rn)>;
}

defm : SIMDVectorLShiftLongBySizeBHSPats<anyext>;
defm : SIMDVectorLShiftLongBySizeBHSPats<zext>;
defm : SIMDVectorLShiftLongBySizeBHSPats<sext>;

//===----------------------------------------------------------------------===//
// Advanced SIMD three vector instructions.
//===----------------------------------------------------------------------===//

def SVEAddrModeRegReg8  : ComplexPattern<i64, 2, "SelectSVERegRegAddrMode<0>", []>;
def SVEAddrModeRegReg16 : ComplexPattern<i64, 2, "SelectSVERegRegAddrMode<1>", []>;
def SVEAddrModeRegReg32 : ComplexPattern<i64, 2, "SelectSVERegRegAddrMode<2>", []>;
def SVEAddrModeRegReg64 : ComplexPattern<i64, 2, "SelectSVERegRegAddrMode<3>", []>;

def nxv2i64LslBy1 :ComplexPattern<nxv2i64, 1, "SelectVectorLslImm<1>", []>;
def nxv2i64LslBy2 :ComplexPattern<nxv2i64, 1, "SelectVectorLslImm<2>", []>;
def nxv2i64LslBy3 :ComplexPattern<nxv2i64, 1, "SelectVectorLslImm<3>", []>;

def SVE8BitLslImm : ComplexPattern<i32, 2, "Select8BitLslImm", [imm]>;

def nxv2i64UxtwLslBy3 :ComplexPattern<nxv2i64, 1, "SelectVectorUxtwLslImm<3>", []>;

def SVEUIntArithImm8 : ComplexPattern<i32, 2, "SelectSVEUIntArithImm<MVT::i8>", []>;
def SVEUIntArithImm16 : ComplexPattern<i32, 2, "SelectSVEUIntArithImm<MVT::i16>", []>;
def SVEUIntArithImm32 : ComplexPattern<i32, 2, "SelectSVEUIntArithImm<MVT::i32>", []>;
def SVEUIntArithImm64 : ComplexPattern<i32, 2, "SelectSVEUIntArithImm<MVT::i64>", []>;

def SVELogicalImm8 : ComplexPattern<i64, 1, "SelectSVELogicalImm<MVT::i8>", []>;
def SVELogicalImm16 : ComplexPattern<i64, 1, "SelectSVELogicalImm<MVT::i16>", []>;
def SVELogicalImm32 : ComplexPattern<i64, 1, "SelectSVELogicalImm<MVT::i32>", []>;
def SVELogicalImm64 : ComplexPattern<i64, 1, "SelectSVELogicalImm<MVT::i64>", []>;

def SVELShiftImm64 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<0, 64>", []>;
def SVERShiftImm64 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<1, 65>", []>;

// Wide pseudo-immediates for pattern matching to shift-by-immediate
def SVEWideLShiftImm8  : ComplexPattern<i32, 1, "SelectSVEShiftImm64<0,7>", []>;
def SVEWideLShiftImm16 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<0,15>", []>;
def SVEWideLShiftImm32 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<0,31>", []>;

def SVEWideRShiftImm8  : ComplexPattern<i32, 1, "SelectSVEShiftImm64<1,8>", []>;
def SVEWideRShiftImm16 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<1,16>", []>;
def SVEWideRShiftImm32 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<1,32>", []>;

multiclass SVEExtLoad<ValueType vt, SDPatternOperator operator,
                      Instruction load, Instruction load_imm, Instruction ptrue,
                      ComplexPattern CP> {
  def : Pat<(vt (operator (CP GPR64:$base, GPR64:$offset))),
            (load (ptrue 31), GPR64:$base, GPR64:$offset)>;
  def : Pat<(vt (operator GPR64:$base)),
            (load_imm (ptrue 31), GPR64:$base, (i64 0))>;
}

let AddedComplexity = 1 in {
 class LD1RPat<ValueType vt, SDPatternOperator operator,
               Instruction load, Instruction ptrue, ValueType index_vt, ComplexPattern CP, Operand immtype> :
       Pat<(vt (AArch64dup (index_vt (operator (CP GPR64:$base, immtype:$offset))))),
           (load (ptrue 31), GPR64:$base, immtype:$offset)>;
}

multiclass SVETruncStore<ValueType vt, SDPatternOperator operator,
                         Instruction store, Instruction store_imm,
                         Instruction ptrue, ComplexPattern CP> {
  def : Pat<(operator (vt ZPR:$val), (CP GPR64:$base, GPR64:$offset)),
            (store ZPR:$val, (ptrue 31), GPR64:$base, GPR64:$offset)>;
  def : Pat<(operator (vt ZPR:$val), GPR64:$base),
            (store_imm ZPR:$val, (ptrue 31), GPR64:$base, (i64 0))>;
}

def SDT_AArch64DUP_PRED  : SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCisSameAs<0,1>, SDTCisVec<2>, SDTCVecEltisVT<2,i1>]>;
def AArch64dup_pred : SDNode<"AArch64ISD::DUP_PRED", SDT_AArch64DUP_PRED>;

def SDT_AArch64Insr  : SDTypeProfile<1, 2, [SDTCisVec<0>]>;
def AArch64insr      : SDNode<"AArch64ISD::INSR", SDT_AArch64Insr>;

def SDT_AArch64PTest : SDTypeProfile<0, 2, [SDTCisVec<0>, SDTCisSameAs<0,1>]>;
def AArch64ptest     : SDNode<"AArch64ISD::PTEST", SDT_AArch64PTest>;

def SDT_AArch64RDFFR : SDTypeProfile<1, 0, [SDTCisVec<0>, SDTCVecEltisVT<0,i1>]>;
def AArch64rdffr     : SDNode<"AArch64ISD::RDFFR", SDT_AArch64RDFFR, [SDNPHasChain]>;

def SDT_AArch64RDFFR_PRED : SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisSameAs<0,1>, SDTCVecEltisVT<0,i1>]>;
def AArch64rdffr_pred     : SDNode<"AArch64ISD::RDFFR_PRED", SDT_AArch64RDFFR_PRED, [SDNPHasChain]>;

def SDT_AArch64WRFFR : SDTypeProfile<0, 1, [SDTCisVT<0, nxv16i1>]>;
def AArch64wrffr     : SDNode<"AArch64ISD::WRFFR", SDT_AArch64WRFFR, [SDNPHasChain, SDNPOutGlue]>;

def SDT_AArch64SETFFR : SDTypeProfile<0, 0, []>;
def AArch64setffr     : SDNode<"AArch64ISD::SETFFR", SDT_AArch64SETFFR, [SDNPHasChain, SDNPOutGlue]>;

def SDT_AArch64Rev   : SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisSameAs<0,1>]>;
def AArch64rev       : SDNode<"AArch64ISD::REV", SDT_AArch64Rev>;

def SDT_AArch64BRKA  : SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCisSameAs<0,1>,
                                            SDTCisSameAs<0,2>, SDTCVecEltisVT<0,i1>]>;
def AArch64brka      : SDNode<"AArch64ISD::BRKA", SDT_AArch64BRKA>;

def reinterpret_cast : SDNode<"AArch64ISD::REINTERPRET_CAST", SDTUnaryOp>;

def SDT_AArch64ReduceWithInit : SDTypeProfile<1, 3, [SDTCisVec<1>, SDTCisVec<3>]>;
def AArch64clasta_n   : SDNode<"AArch64ISD::CLASTA_N",   SDT_AArch64ReduceWithInit>;
def AArch64clastb_n   : SDNode<"AArch64ISD::CLASTB_N",   SDT_AArch64ReduceWithInit>;
def AArch64fadda_pred : SDNode<"AArch64ISD::FADDA_PRED", SDT_AArch64ReduceWithInit>;

def SDT_AArch64Reduce : SDTypeProfile<1, 2, [SDTCisVec<1>, SDTCisVec<2>]>;
def AArch64andv_pred    : SDNode<"AArch64ISD::ANDV_PRED",    SDT_AArch64Reduce>;
def AArch64eorv_pred    : SDNode<"AArch64ISD::EORV_PRED",    SDT_AArch64Reduce>;
def AArch64faddv_pred   : SDNode<"AArch64ISD::FADDV_PRED",   SDT_AArch64Reduce>;
def AArch64fmaxv_pred   : SDNode<"AArch64ISD::FMAXV_PRED",   SDT_AArch64Reduce>;
def AArch64fmaxnmv_pred : SDNode<"AArch64ISD::FMAXNMV_PRED", SDT_AArch64Reduce>;
def AArch64fminv_pred   : SDNode<"AArch64ISD::FMINV_PRED",   SDT_AArch64Reduce>;
def AArch64fminnmv_pred : SDNode<"AArch64ISD::FMINNMV_PRED", SDT_AArch64Reduce>;
def AArch64lasta        : SDNode<"AArch64ISD::LASTA",        SDT_AArch64Reduce>;
def AArch64lastb        : SDNode<"AArch64ISD::LASTB",        SDT_AArch64Reduce>;
def AArch64orv_pred     : SDNode<"AArch64ISD::ORV_PRED",     SDT_AArch64Reduce>;
def AArch64saddv_pred   : SDNode<"AArch64ISD::SADDV_PRED",   SDT_AArch64Reduce>;
def AArch64smaxv_pred   : SDNode<"AArch64ISD::SMAXV_PRED",   SDT_AArch64Reduce>;
def AArch64sminv_pred   : SDNode<"AArch64ISD::SMINV_PRED",   SDT_AArch64Reduce>;
def AArch64uaddv_pred   : SDNode<"AArch64ISD::UADDV_PRED",   SDT_AArch64Reduce>;
def AArch64umaxv_pred   : SDNode<"AArch64ISD::UMAXV_PRED",   SDT_AArch64Reduce>;
def AArch64uminv_pred   : SDNode<"AArch64ISD::UMINV_PRED",   SDT_AArch64Reduce>;

def SDT_AArch64FMinMax :SDTypeProfile<1, 3, [SDTCisVec<1>, SDTCisVec<2>,
                                             SDTCisSameAs<2, 3>]>;
def AArch64fmin_pred    : SDNode<"AArch64ISD::FMIN_PRED", SDT_AArch64FMinMax>;
def AArch64fminnm_pred  : SDNode<"AArch64ISD::FMINNM_PRED", SDT_AArch64FMinMax>;
def AArch64fmax_pred    : SDNode<"AArch64ISD::FMAX_PRED", SDT_AArch64FMinMax>;
def AArch64fmaxnm_pred  : SDNode<"AArch64ISD::FMAXNM_PRED", SDT_AArch64FMinMax>; 

def SDTFPToIntOpInreg : SDTypeProfile<1, 2, [
  SDTCisInt<0>, SDTCisFP<1>, SDTCisVT<2, OtherVT>,
  SDTCisVTSmallerThanOp<2, 0>
]>;
def fp_to_sint_inreg : SDNode<"AArch64ISD::FP_TO_SINT_INREG" , SDTFPToIntOpInreg>;
def fp_to_uint_inreg : SDNode<"AArch64ISD::FP_TO_UINT_INREG" , SDTFPToIntOpInreg>;

def SDT_AArch64_LDFF1 : SDTypeProfile<1, 2, [
  SDTCisVec<0>, SDTCisVec<1>, SDTCisPtrTy<2>,
  SDTCVecEltisVT<1,i1>, SDTCisSameNumEltsAs<0,1>
]>;
def AArch64ldff1b : SDNode<"AArch64ISD::LDFF1B", SDT_AArch64_LDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1h : SDNode<"AArch64ISD::LDFF1H", SDT_AArch64_LDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1w : SDNode<"AArch64ISD::LDFF1W", SDT_AArch64_LDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1d : SDNode<"AArch64ISD::LDFF1D", SDT_AArch64_LDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;

def SDT_AArch64_LDNT1 : SDTypeProfile<1, 3, [
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisVec<2>, SDTCisSameAs<0,3>,
  SDTCVecEltisVT<2,i1>, SDTCisSameNumEltsAs<0,2>
]>;
def AArch64ldnt1  : SDNode<"AArch64ISD::LDNT1",  SDT_AArch64_LDNT1, [SDNPHasChain, SDNPMayLoad]>;

def SDT_AArch64_STNT1 : SDTypeProfile<0, 3, [
  SDTCisPtrTy<0>, SDTCisVec<1>, SDTCisVec<2>,
  SDTCVecEltisVT<1,i1>, SDTCisSameNumEltsAs<1,2>
]>;
def AArch64stnt1 : SDNode<"AArch64ISD::STNT1", SDT_AArch64_STNT1, [SDNPHasChain, SDNPMayStore]>;

let Predicates = [HasSVE] in {
  defm ADD_ZZZ   : sve_int_bin_cons_arit_0<0b000, "add", add>;
  defm SUB_ZZZ   : sve_int_bin_cons_arit_0<0b001, "sub", sub>;
  defm SQADD_ZZZ : sve_int_bin_cons_arit_0<0b100, "sqadd", int_aarch64_sve_sqadd>;
  defm UQADD_ZZZ : sve_int_bin_cons_arit_0<0b101, "uqadd", int_aarch64_sve_uqadd>;
  defm SQSUB_ZZZ : sve_int_bin_cons_arit_0<0b110, "sqsub", int_aarch64_sve_sqsub>;
  defm UQSUB_ZZZ : sve_int_bin_cons_arit_0<0b111, "uqsub", int_aarch64_sve_uqsub>;

  defm ADD_ZI   : sve_int_arith_imm0<0b000, "add">;
  defm SUB_ZI   : sve_int_arith_imm0<0b001, "sub">;
  defm SUBR_ZI  : sve_int_arith_imm0<0b011, "subr">;
  defm SQADD_ZI : sve_int_arith_imm0<0b100, "sqadd">;
  defm UQADD_ZI : sve_int_arith_imm0<0b101, "uqadd">;
  defm SQSUB_ZI : sve_int_arith_imm0<0b110, "sqsub">;
  defm UQSUB_ZI : sve_int_arith_imm0<0b111, "uqsub">;

  multiclass sve_int_arith_immediates<string I, SDPatternOperator op> {
    def : Pat<(nxv16i8 (op (nxv16i8 ZPR:$Zs1),
                           (nxv16i8 (AArch64dup (i32 (SVEUIntArithImm8 i32:$imm, i32:$shift)))))),
              (!cast<Instruction>(I # "_B") ZPR:$Zs1, i32:$imm, i32:$shift)>;
    def : Pat<(nxv8i16 (op (nxv8i16 ZPR:$Zs1),
                           (nxv8i16 (AArch64dup (i32 (SVEUIntArithImm16 i32:$imm, i32:$shift)))))),
              (!cast<Instruction>(I # "_H") ZPR:$Zs1, i32:$imm, i32:$shift)>;
    def : Pat<(nxv4i32 (op (nxv4i32 ZPR:$Zs1),
                           (nxv4i32 (AArch64dup (i32 (SVEUIntArithImm32 i32:$imm, i32:$shift)))))),
              (!cast<Instruction>(I # "_S") ZPR:$Zs1, i32:$imm, i32:$shift)>;
    def : Pat<(nxv2i64 (op (nxv2i64 ZPR:$Zs1),
                           (nxv2i64 (AArch64dup (i64 (SVEUIntArithImm64 i32:$imm, i32:$shift)))))),
              (!cast<Instruction>(I # "_D") ZPR:$Zs1, i32:$imm, i32:$shift)>;
  }

  defm : sve_int_arith_immediates<"ADD_ZI", add>;
  defm : sve_int_arith_immediates<"SUB_ZI", sub>;
  // Skipping subr?
  defm : sve_int_arith_immediates<"SQADD_ZI", int_aarch64_sve_sqadd>;
  defm : sve_int_arith_immediates<"SQSUB_ZI", int_aarch64_sve_sqsub>;
  defm : sve_int_arith_immediates<"UQADD_ZI", int_aarch64_sve_uqadd>;
  defm : sve_int_arith_immediates<"UQSUB_ZI", int_aarch64_sve_uqsub>;


  // TODO: simm8 gives a slightly odd error message
  defm SMAX_ZI   : sve_int_arith_imm1<0b000, "smax", simm8>;
  defm SMIN_ZI   : sve_int_arith_imm1<0b010, "smin", simm8>;
  defm UMAX_ZI   : sve_int_arith_imm1<0b001, "umax", imm0_255dec>;
  defm UMIN_ZI   : sve_int_arith_imm1<0b011, "umin", imm0_255dec>;

  defm MUL_ZI    : sve_int_arith_imm2<0b000, "mul">;

  def AND_ZZZ : sve_int_bin_cons_log<0b00100, "and">;
  def ORR_ZZZ : sve_int_bin_cons_log<0b01100, "orr">;
  def EOR_ZZZ : sve_int_bin_cons_log<0b10100, "eor">;
  def BIC_ZZZ : sve_int_bin_cons_log<0b11100, "bic">;


  // TODO: Binopfrag?
  def : Pat<(and (nxv16i8 ZPR:$Zs1), (xor (nxv16i8 ZPR:$Zs2),
                                          (nxv16i8 (AArch64dup (i32 -1))))),
            (BIC_ZZZ ZPR:$Zs1, ZPR:$Zs2)>;

  def : Pat<(and (nxv8i16 ZPR:$Zs1), (xor (nxv8i16 ZPR:$Zs2),
                                          (nxv8i16 (AArch64dup (i32 -1))))),
            (BIC_ZZZ ZPR:$Zs1, ZPR:$Zs2)>;

  def : Pat<(and (nxv4i32 ZPR:$Zs1), (xor (nxv4i32 ZPR:$Zs2),
                                          (nxv4i32 (AArch64dup (i32 -1))))),
            (BIC_ZZZ ZPR:$Zs1, ZPR:$Zs2)>;

  def : Pat<(and (nxv2i64 ZPR:$Zs1), (xor (nxv2i64 ZPR:$Zs2),
                                          (nxv2i64 (AArch64dup (i64 -1))))),
            (BIC_ZZZ ZPR:$Zs1, ZPR:$Zs2)>;


  defm ORR_ZI : sve_int_log_imm<0b00, "orr", or,  "orn">;
  defm EOR_ZI : sve_int_log_imm<0b01, "eor", xor, "eon">;
  defm AND_ZI : sve_int_log_imm<0b10, "and", and, "bic">;

  multiclass sve_int_logical_immediates<Instruction Inst, SDPatternOperator op> {
    def : Pat<(nxv16i8 (op (nxv16i8 ZPR:$Zs1),
                           (nxv16i8 (AArch64dup (i32 (SVELogicalImm8 i64:$imm)))))),
              (Inst ZPR:$Zs1, i64:$imm)>;
    def : Pat<(nxv8i16 (op (nxv8i16 ZPR:$Zs1),
                           (nxv8i16 (AArch64dup (i32 (SVELogicalImm16 i64:$imm)))))),
              (Inst ZPR:$Zs1, i64:$imm)>;
    def : Pat<(nxv4i32 (op (nxv4i32 ZPR:$Zs1),
                           (nxv4i32 (AArch64dup (i32 (SVELogicalImm32 i64:$imm)))))),
              (Inst ZPR:$Zs1, i64:$imm)>;
    def : Pat<(nxv2i64 (op (nxv2i64 ZPR:$Zs1),
                           (nxv2i64 (AArch64dup (i64 (SVELogicalImm64 i64:$imm)))))),
              (Inst ZPR:$Zs1, i64:$imm)>;
  }

  defm : sve_int_logical_immediates<AND_ZI, and>;
  defm : sve_int_logical_immediates<EOR_ZI, xor>;
  defm : sve_int_logical_immediates<ORR_ZI, or>;

  defm ORR_ZPmZ : sve_int_bin_pred_log<0b000, "orr", int_aarch64_sve_orr>;
  defm EOR_ZPmZ : sve_int_bin_pred_log<0b001, "eor", int_aarch64_sve_eor>;
  defm AND_ZPmZ : sve_int_bin_pred_log<0b010, "and", int_aarch64_sve_and>;
  defm BIC_ZPmZ : sve_int_bin_pred_log<0b011, "bic", int_aarch64_sve_bic>;

  defm SXTB_ZPmZ : sve_int_un_pred_arit_0_h<0b000, "sxtb", int_aarch64_sve_sxtb>;
  defm UXTB_ZPmZ : sve_int_un_pred_arit_0_h<0b001, "uxtb", int_aarch64_sve_uxtb>;
  defm SXTH_ZPmZ : sve_int_un_pred_arit_0_w<0b010, "sxth", int_aarch64_sve_sxth>;
  defm UXTH_ZPmZ : sve_int_un_pred_arit_0_w<0b011, "uxth", int_aarch64_sve_uxth>;
  defm SXTW_ZPmZ : sve_int_un_pred_arit_0_d<0b100, "sxtw", int_aarch64_sve_sxtw>;
  defm UXTW_ZPmZ : sve_int_un_pred_arit_0_d<0b101, "uxtw", int_aarch64_sve_uxtw>;
  defm ABS_ZPmZ  : sve_int_un_pred_arit_0<  0b110, "abs",  int_aarch64_sve_abs>;
  defm NEG_ZPmZ  : sve_int_un_pred_arit_0<  0b111, "neg",  int_aarch64_sve_neg>;

  def : Pat<(sext_inreg (nxv2i64 ZPR:$Zs), nxv2i32), (SXTW_ZPmZ_D (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv2i64 ZPR:$Zs), nxv2i16), (SXTH_ZPmZ_D (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv2i64 ZPR:$Zs), nxv2i8),  (SXTB_ZPmZ_D (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv4i32 ZPR:$Zs), nxv4i16), (SXTH_ZPmZ_S (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv4i32 ZPR:$Zs), nxv4i8),  (SXTB_ZPmZ_S (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv8i16 ZPR:$Zs), nxv8i8),  (SXTB_ZPmZ_H (IMPLICIT_DEF), (PTRUE_H 31), ZPR:$Zs)>;

  // zext_inreg - 8,16,32 -> 64 // NOTE: covered by general AND of immediate
  def : Pat<(and (nxv2i64 ZPR:$Zs), (nxv2i64 (AArch64dup (i64 logical_imm64:$imms1)))),
            (AND_ZI ZPR:$Zs, logical_imm64:$imms1)>;

  // zext_inreg - 16 -> 32
  def : Pat<(and (nxv4i32 ZPR:$Zs), (nxv4i32 (AArch64dup (i32 0xFFFF)))),
            (AND_ZI ZPR:$Zs, (logical_imm64_XFORM (i64 0x0000FFFF0000FFFF)))>;

  // zext_inreg - 8 -> 32
  def : Pat<(and (nxv4i32 ZPR:$Zs), (nxv4i32 (AArch64dup (i32 0xFF)))),
            (AND_ZI ZPR:$Zs, (logical_imm64_XFORM (i64 0x000000FF000000FF)))>;

  // zext_inreg - 8 -> 16
  def : Pat<(and (nxv8i16 ZPR:$Zs), (nxv8i16 (AArch64dup (i32 0xFF)))),
            (AND_ZI ZPR:$Zs, (logical_imm64_XFORM (i64 0x00FF00FF00FF00FF)))>;

  defm ADD_ZPmZ  : sve_int_bin_pred_arit_0<0b000, "add",  int_aarch64_sve_add>;
  defm SUB_ZPmZ  : sve_int_bin_pred_arit_0<0b001, "sub",  int_aarch64_sve_sub>;
  defm SUBR_ZPmZ : sve_int_bin_pred_arit_0<0b011, "subr", int_aarch64_sve_subr>;

  class AddSubFoldPattern<ValueType Zty, ValueType PTy, ValueType ITy,
                          SDNode op, string I, string size>
    : Pat<(op (Zty ZPR:$Za),
              (vselect (PTy PPR:$gp), (Zty ZPR:$Zb),
                       (Zty (AArch64dup (ITy 0))))),
          (!cast<Instruction>(I # "_ZPmZZ_" # size) PPR:$gp, ZPR:$Za, ZPR:$Zb)>;
  multiclass add_sub_folds<SDNode Op, string I> {
  def : AddSubFoldPattern<nxv16i8, nxv16i1, i32, Op, I, "B">;
  def : AddSubFoldPattern<nxv8i16, nxv8i1, i32, Op, I, "H">;
  def : AddSubFoldPattern<nxv4i32, nxv4i1, i32, Op, I, "S">;
  def : AddSubFoldPattern<nxv2i64, nxv2i1, i64, Op, I, "D">;
  }
  defm : add_sub_folds<add, "ADD">;
  defm : add_sub_folds<sub, "SUB">;

  defm SMAX_ZPmZ : sve_int_bin_pred_arit_1<0b000, "smax", int_aarch64_sve_smax>;
  defm UMAX_ZPmZ : sve_int_bin_pred_arit_1<0b001, "umax", int_aarch64_sve_umax>;
  defm SMIN_ZPmZ : sve_int_bin_pred_arit_1<0b010, "smin", int_aarch64_sve_smin>;
  defm UMIN_ZPmZ : sve_int_bin_pred_arit_1<0b011, "umin", int_aarch64_sve_umin>;
  defm SABD_ZPmZ : sve_int_bin_pred_arit_1<0b100, "sabd", int_aarch64_sve_sabd>;
  defm UABD_ZPmZ : sve_int_bin_pred_arit_1<0b101, "uabd", int_aarch64_sve_uabd>;

  // min and max fold like this:
  // select($gp AND ($a > $b), $a, $b) => max($gp, $b, $a)
  class MinMaxFoldPattern1<ValueType ZTy, ValueType PTy, CondCode Op, string I,
                          string size>
    : Pat<(ZTy (vselect (and (PTy PPR:$gp),
                             (setcc (ZTy ZPR:$Zs1), (ZTy ZPR:$Zs2), Op)),
                        (ZTy ZPR:$Zs1), (ZTy ZPR:$Zs2))),
           (!cast<Instruction>(I # "_ZPmZZ_" # size) PPR:$gp, ZPR:$Zs2, ZPR:$Zs1)>;
  // Same as above but for inverted operands and condition code.
  class MinMaxFoldPattern2<ValueType ZTy, ValueType PTy, CondCode Op, string I,
                          string size>
    : Pat<(ZTy (vselect (and (PTy PPR:$gp),
                             (setcc (ZTy ZPR:$Zs1), (ZTy ZPR:$Zs2), Op)),
                        (ZTy ZPR:$Zs2), (ZTy ZPR:$Zs1))),
           (!cast<Instruction>(I # "_ZPmZZ_" # size) PPR:$gp, ZPR:$Zs1, ZPR:$Zs2)>;
  multiclass min_max_folds<CondCode Op1, CondCode Op2, string I> {
  def : MinMaxFoldPattern1<nxv16i8, nxv16i1, Op1, I, "B">;
  def : MinMaxFoldPattern1<nxv8i16, nxv8i1, Op1, I, "H">;
  def : MinMaxFoldPattern1<nxv4i32, nxv4i1, Op1, I, "S">;
  def : MinMaxFoldPattern1<nxv2i64, nxv2i1, Op1, I, "D">;
  def : MinMaxFoldPattern2<nxv16i8, nxv16i1, Op2, I, "B">;
  def : MinMaxFoldPattern2<nxv8i16, nxv8i1, Op2, I, "H">;
  def : MinMaxFoldPattern2<nxv4i32, nxv4i1, Op2, I, "S">;
  def : MinMaxFoldPattern2<nxv2i64, nxv2i1, Op2, I, "D">;
  }
  defm : min_max_folds<SETGT, SETLT, "SMAX">;
  defm : min_max_folds<SETUGT, SETULT, "UMAX">;
  defm : min_max_folds<SETLT, SETGT, "SMIN">;
  defm : min_max_folds<SETULT, SETUGT, "UMIN">;

  defm ASR_ZPmI  : sve_int_bin_pred_shift_0_right<0b000, "asr">;
  defm LSR_ZPmI  : sve_int_bin_pred_shift_0_right<0b001, "lsr">;
  defm LSL_ZPmI  : sve_int_bin_pred_shift_0_left< 0b011, "lsl">;
  defm ASRD_ZPmI : sve_int_bin_pred_shift_0_right<0b100, "asrd", int_aarch64_sve_asrd>;

  defm ASR_ZPmZ  : sve_int_bin_pred_shift_1<0b000, "asr", int_aarch64_sve_asr>;
  defm LSR_ZPmZ  : sve_int_bin_pred_shift_1<0b001, "lsr", int_aarch64_sve_lsr>;
  defm LSL_ZPmZ  : sve_int_bin_pred_shift_1<0b011, "lsl", int_aarch64_sve_lsl>;
  defm ASRR_ZPmZ : sve_int_bin_pred_shift_1<0b100, "asrr">;
  defm LSRR_ZPmZ : sve_int_bin_pred_shift_1<0b101, "lsrr">;
  defm LSLR_ZPmZ : sve_int_bin_pred_shift_1<0b111, "lslr">;

  defm ASR_WIDE_ZPmZ : sve_int_bin_pred_shift_2<0b000, "asr", int_aarch64_sve_asr_wide>;
  defm LSR_WIDE_ZPmZ : sve_int_bin_pred_shift_2<0b001, "lsr", int_aarch64_sve_lsr_wide>;
  defm LSL_WIDE_ZPmZ : sve_int_bin_pred_shift_2<0b011, "lsl", int_aarch64_sve_lsl_wide>;

  defm ASR_WIDE_ZZZ : sve_int_bin_cons_shift_a<0b00, "asr">;
  defm LSR_WIDE_ZZZ : sve_int_bin_cons_shift_a<0b01, "lsr">;
  defm LSL_WIDE_ZZZ : sve_int_bin_cons_shift_a<0b11, "lsl">;

  defm MUL_ZPmZ   : sve_int_bin_pred_arit_2<0b000, "mul",   int_aarch64_sve_mul>;
  defm SMULH_ZPmZ : sve_int_bin_pred_arit_2<0b010, "smulh", int_aarch64_sve_smulh>;
  defm UMULH_ZPmZ : sve_int_bin_pred_arit_2<0b011, "umulh", int_aarch64_sve_umulh>;

  // SVE predicated integer multiply add/sub
  defm MAD_ZPmZZ : sve_int_mladdsub_vvv_pred<0b0, "mad", int_aarch64_sve_mad>;
  defm MSB_ZPmZZ : sve_int_mladdsub_vvv_pred<0b1, "msb", int_aarch64_sve_msb>;
  defm MLA_ZPmZZ : sve_int_mlas_vvv_pred<0b0, "mla", int_aarch64_sve_mla>;
  defm MLS_ZPmZZ : sve_int_mlas_vvv_pred<0b1, "mls", int_aarch64_sve_mls>;

  class MLASPattern<ValueType ZTy, SDNode op, string I, string size>
    : Pat<(ZTy (op (ZTy ZPR:$Zs3), (mul (ZTy ZPR:$Zs1), (ZTy ZPR:$Zs2)))),
          (!cast<Instruction>(I # "_ZPmZZ_" # size)
                (!cast<Instruction>("PTRUE_" ## size) 31), ZPR:$Zs3, ZPR:$Zs1, ZPR:$Zs2)>;
  multiclass mlas_folds<SDNode op, string I> {
  def : MLASPattern<nxv16i8, op, I, "B">;
  def : MLASPattern<nxv8i16, op, I, "H">;
  def : MLASPattern<nxv4i32, op, I, "S">;
  def : MLASPattern<nxv2i64, op, I, "D">;
  }
  defm : mlas_folds<add, "MLA">;
  defm : mlas_folds<sub, "MLS">;

  // SVE predicated integer reductions.
  defm SADDV_VPZ : sve_int_reduce_0_saddv<0b000, "saddv", AArch64saddv_pred>;
  defm UADDV_VPZ : sve_int_reduce_0<0b001, "uaddv", AArch64uaddv_pred>;
  defm SMAXV_VPZ : sve_int_reduce_1<0b000, "smaxv", AArch64smaxv_pred>;
  defm UMAXV_VPZ : sve_int_reduce_1<0b001, "umaxv", AArch64umaxv_pred>;
  defm SMINV_VPZ : sve_int_reduce_1<0b010, "sminv", AArch64sminv_pred>;
  defm UMINV_VPZ : sve_int_reduce_1<0b011, "uminv", AArch64uminv_pred>;
  defm ORV_VPZ   : sve_int_reduce_2<0b000, "orv",   AArch64orv_pred>;
  defm EORV_VPZ  : sve_int_reduce_2<0b001, "eorv",  AArch64eorv_pred>;
  defm ANDV_VPZ  : sve_int_reduce_2<0b010, "andv",  AArch64andv_pred>;

  def EXT_ZZI : sve_int_perm_extract_i<"ext", AArch64ext>;

  // SVE floating point reductions.
  defm FADDA_VPZ   : sve_fp_2op_p_vd<0b000, "fadda",   AArch64fadda_pred>;
  defm FADDV_VPZ   : sve_fp_fast_red<0b000, "faddv",   AArch64faddv_pred>;
  defm FMAXNMV_VPZ : sve_fp_fast_red<0b100, "fmaxnmv", AArch64fmaxnmv_pred>;
  defm FMINNMV_VPZ : sve_fp_fast_red<0b101, "fminnmv", AArch64fminnmv_pred>;
  defm FMAXV_VPZ   : sve_fp_fast_red<0b110, "fmaxv",   AArch64fmaxv_pred>;
  defm FMINV_VPZ   : sve_fp_fast_red<0b111, "fminv",   AArch64fminv_pred>;

  def CTERMEQ_WW : sve_int_cterm<0b0, 0b0, "ctermeq", GPR32>;
  def CTERMNE_WW : sve_int_cterm<0b0, 0b1, "ctermne", GPR32>;
  def CTERMEQ_XX : sve_int_cterm<0b1, 0b0, "ctermeq", GPR64>;
  def CTERMNE_XX : sve_int_cterm<0b1, 0b1, "ctermne", GPR64>;

  defm WHILELT_PWW : sve_int_while4_rr<0b010, "whilelt", int_aarch64_sve_whilelt>;
  defm WHILELE_PWW : sve_int_while4_rr<0b011, "whilele", int_aarch64_sve_whilele>;
  defm WHILELO_PWW : sve_int_while4_rr<0b110, "whilelo", int_aarch64_sve_whilelo>;
  defm WHILELS_PWW : sve_int_while4_rr<0b111, "whilels", int_aarch64_sve_whilels>;

  defm WHILELT_PXX : sve_int_while8_rr<0b010, "whilelt", int_aarch64_sve_whilelt>;
  defm WHILELE_PXX : sve_int_while8_rr<0b011, "whilele", int_aarch64_sve_whilele>;
  defm WHILELO_PXX : sve_int_while8_rr<0b110, "whilelo", int_aarch64_sve_whilelo>;
  defm WHILELS_PXX : sve_int_while8_rr<0b111, "whilels", int_aarch64_sve_whilels>;

  multiclass unpred_from_pred_two_op<SDNode N, string I> {
  def : Pat<(nxv16i8 (N (nxv16i8 ZPR:$Zs1), (nxv16i8 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_B") (PTRUE_B 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv8i16 (N (nxv8i16 ZPR:$Zs1), (nxv8i16 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_H") (PTRUE_H 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv4i32 (N (nxv4i32 ZPR:$Zs1), (nxv4i32 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_S") (PTRUE_S 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i64 (N (nxv2i64 ZPR:$Zs1), (nxv2i64 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_D") (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;
  }
  defm : unpred_from_pred_two_op<mul,  "MUL_ZPmZ">;
  defm : unpred_from_pred_two_op<shl,  "LSL_ZPmZ">;
  defm : unpred_from_pred_two_op<sra,  "ASR_ZPmZ">;
  defm : unpred_from_pred_two_op<srl,  "LSR_ZPmZ">;

  defm SDIV_ZPmZ  : sve_int_bin_pred_arit_2_div<0b100, "sdiv",  int_aarch64_sve_sdiv>;
  defm UDIV_ZPmZ  : sve_int_bin_pred_arit_2_div<0b101, "udiv",  int_aarch64_sve_udiv>;
  defm SDIVR_ZPmZ : sve_int_bin_pred_arit_2_div<0b110, "sdivr", int_aarch64_sve_sdivr>;
  defm UDIVR_ZPmZ : sve_int_bin_pred_arit_2_div<0b111, "udivr", int_aarch64_sve_udivr>;

  multiclass unpred_from_pred_two_op_div<SDNode N, string I> {
  def : Pat<(nxv4i32 (N (nxv4i32 ZPR:$Zs1), (nxv4i32 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_S") (PTRUE_S 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i64 (N (nxv2i64 ZPR:$Zs1), (nxv2i64 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_D") (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;
  }
  defm : unpred_from_pred_two_op_div<sdiv, "SDIV_ZPmZZ">;
  defm : unpred_from_pred_two_op_div<udiv, "UDIV_ZPmZZ">;

  defm LDR_ZXI : sve_mem_32b_fill<"ldr">;
  defm STR_ZXI : sve_mem_spill<"str">;

  // Pseudo instructions representing unpredicated LDR and STR for ZPR2,3,4.
  // These later get expanded to PTRUE of ST2/LD2 etc
  let mayLoad = 1, hasSideEffects = 0 in {
  def LDR_ZZXI   : Pseudo<(outs   ZZ_b:$Zd), (ins GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  def LDR_ZZZXI  : Pseudo<(outs  ZZZ_b:$Zd), (ins GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  def LDR_ZZZZXI : Pseudo<(outs ZZZZ_b:$Zd), (ins GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  }
  let mayStore = 1, hasSideEffects = 0 in {
  def STR_ZZXI   : Pseudo<(outs), (ins   ZZ_b:$Zs, GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  def STR_ZZZXI  : Pseudo<(outs), (ins  ZZZ_b:$Zs, GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  def STR_ZZZZXI : Pseudo<(outs), (ins ZZZZ_b:$Zs, GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  }

  foreach type = ["nxv16i8", "nxv8i16", "nxv4i32", "nxv2i64"] in {
    def : Pat<(and (!cast<ValueType>(type) ZPR:$src1),
                   (!cast<ValueType>(type) ZPR:$src2)),
              (AND_ZZZ ZPR:$src1, ZPR:$src2)>;
    def : Pat<(or (!cast<ValueType>(type) ZPR:$src1),
                  (!cast<ValueType>(type) ZPR:$src2)),
              (ORR_ZZZ ZPR:$src1, ZPR:$src2)>;
    def : Pat<(xor (!cast<ValueType>(type) ZPR:$src1),
                   (!cast<ValueType>(type) ZPR:$src2)),
              (EOR_ZZZ ZPR:$src1, ZPR:$src2)>;
  }

  // LD1B...
  defm LD1B    : sve_mem_cld_ss_b<0b0000, "ld1b",  "b">;
  defm LD1B_H  : sve_mem_cld_ss_b<0b0001, "ld1b",  "h">;
  defm LD1B_S  : sve_mem_cld_ss_b<0b0010, "ld1b",  "s">;
  defm LD1B_D  : sve_mem_cld_ss_b<0b0011, "ld1b",  "d">;
  defm LD1SW_D : sve_mem_cld_ss<  0b0100, "ld1sw", "d", ", lsl #2">;
  defm LD1H    : sve_mem_cld_ss<  0b0101, "ld1h",  "h", ", lsl #1">;
  defm LD1H_S  : sve_mem_cld_ss<  0b0110, "ld1h",  "s", ", lsl #1">;
  defm LD1H_D  : sve_mem_cld_ss<  0b0111, "ld1h",  "d", ", lsl #1">;
  defm LD1SH_D : sve_mem_cld_ss<  0b1000, "ld1sh", "d", ", lsl #1">;
  defm LD1SH_S : sve_mem_cld_ss<  0b1001, "ld1sh", "s", ", lsl #1">;
  defm LD1W    : sve_mem_cld_ss<  0b1010, "ld1w",  "s", ", lsl #2">;
  defm LD1W_D  : sve_mem_cld_ss<  0b1011, "ld1w",  "d", ", lsl #2">;
  defm LD1SB_D : sve_mem_cld_ss_b<0b1100, "ld1sb", "d">;
  defm LD1SB_S : sve_mem_cld_ss_b<0b1101, "ld1sb", "s">;
  defm LD1SB_H : sve_mem_cld_ss_b<0b1110, "ld1sb", "h">;
  defm LD1D    : sve_mem_cld_ss<  0b1111, "ld1d",  "d", ", lsl #3">;

  // continuous load with reg+immediate
  defm LD1B_B_IMM  : sve_mem_cld_si<0b0000, "ld1b",  "b">;
  defm LD1B_H_IMM  : sve_mem_cld_si<0b0001, "ld1b",  "h">;
  defm LD1B_S_IMM  : sve_mem_cld_si<0b0010, "ld1b",  "s">;
  defm LD1B_D_IMM  : sve_mem_cld_si<0b0011, "ld1b",  "d">;
  defm LD1SB_H_IMM : sve_mem_cld_si<0b1110, "ld1sb", "h">;
  defm LD1SB_S_IMM : sve_mem_cld_si<0b1101, "ld1sb", "s">;
  defm LD1SB_D_IMM : sve_mem_cld_si<0b1100, "ld1sb", "d">;
  defm LD1H_H_IMM  : sve_mem_cld_si<0b0101, "ld1h",  "h">;
  defm LD1H_S_IMM  : sve_mem_cld_si<0b0110, "ld1h",  "s">;
  defm LD1H_D_IMM  : sve_mem_cld_si<0b0111, "ld1h",  "d">;
  defm LD1SH_S_IMM : sve_mem_cld_si<0b1001, "ld1sh", "s">;
  defm LD1SH_D_IMM : sve_mem_cld_si<0b1000, "ld1sh", "d">;
  defm LD1W_S_IMM  : sve_mem_cld_si<0b1010, "ld1w",  "s">;
  defm LD1W_D_IMM  : sve_mem_cld_si<0b1011, "ld1w",  "d">;
  defm LD1SW_D_IMM : sve_mem_cld_si<0b0100, "ld1sw", "d">;
  defm LD1D_D_IMM  : sve_mem_cld_si<0b1111, "ld1d",  "d">;

  // non-faulting continuous load with reg+immediate
  defm LDNF1B_B_IMM  : sve_mem_cld_si_nf<0b0000, "ldnf1b",  "b">;
  defm LDNF1B_H_IMM  : sve_mem_cld_si_nf<0b0001, "ldnf1b",  "h">;
  defm LDNF1B_S_IMM  : sve_mem_cld_si_nf<0b0010, "ldnf1b",  "s">;
  defm LDNF1B_D_IMM  : sve_mem_cld_si_nf<0b0011, "ldnf1b",  "d">;
  defm LDNF1SB_H_IMM : sve_mem_cld_si_nf<0b1110, "ldnf1sb", "h">;
  defm LDNF1SB_S_IMM : sve_mem_cld_si_nf<0b1101, "ldnf1sb", "s">;
  defm LDNF1SB_D_IMM : sve_mem_cld_si_nf<0b1100, "ldnf1sb", "d">;
  defm LDNF1H_H_IMM  : sve_mem_cld_si_nf<0b0101, "ldnf1h",  "h">;
  defm LDNF1H_S_IMM  : sve_mem_cld_si_nf<0b0110, "ldnf1h",  "s">;
  defm LDNF1H_D_IMM  : sve_mem_cld_si_nf<0b0111, "ldnf1h",  "d">;
  defm LDNF1SH_S_IMM : sve_mem_cld_si_nf<0b1001, "ldnf1sh", "s">;
  defm LDNF1SH_D_IMM : sve_mem_cld_si_nf<0b1000, "ldnf1sh", "d">;
  defm LDNF1W_S_IMM  : sve_mem_cld_si_nf<0b1010, "ldnf1w",  "s">;
  defm LDNF1W_D_IMM  : sve_mem_cld_si_nf<0b1011, "ldnf1w",  "d">;
  defm LDNF1SW_D_IMM : sve_mem_cld_si_nf<0b0100, "ldnf1sw", "d">;
  defm LDNF1D_D_IMM  : sve_mem_cld_si_nf<0b1111, "ldnf1d",  "d">;

  // LD1R loads (splat scalar to vector)
  defm LD1RB    : sve_mem_ld_dup<0b00, 0b00, "ld1rb",  "b", uimm6b>;
  defm LD1RB_H  : sve_mem_ld_dup<0b00, 0b01, "ld1rb",  "h", uimm6b>;
  defm LD1RB_S  : sve_mem_ld_dup<0b00, 0b10, "ld1rb",  "s", uimm6b>;
  defm LD1RB_D  : sve_mem_ld_dup<0b00, 0b11, "ld1rb",  "d", uimm6b>;
  defm LD1RSB_H : sve_mem_ld_dup<0b11, 0b10, "ld1rsb", "h", uimm6b>;
  defm LD1RSB_S : sve_mem_ld_dup<0b11, 0b01, "ld1rsb", "s", uimm6b>;
  defm LD1RSB_D : sve_mem_ld_dup<0b11, 0b00, "ld1rsb", "d", uimm6b>;
  defm LD1RH    : sve_mem_ld_dup<0b01, 0b01, "ld1rh",  "h", uimm6h>;
  defm LD1RH_S  : sve_mem_ld_dup<0b01, 0b10, "ld1rh",  "s", uimm6h>;
  defm LD1RH_D  : sve_mem_ld_dup<0b01, 0b11, "ld1rh",  "d", uimm6h>;
  defm LD1RSH_S : sve_mem_ld_dup<0b10, 0b01, "ld1rsh", "s", uimm6h>;
  defm LD1RSH_D : sve_mem_ld_dup<0b10, 0b00, "ld1rsh", "d", uimm6h>;
  defm LD1RW    : sve_mem_ld_dup<0b10, 0b10, "ld1rw",  "s", uimm6w>;
  defm LD1RW_D  : sve_mem_ld_dup<0b10, 0b11, "ld1rw",  "d", uimm6w>;
  defm LD1RSW   : sve_mem_ld_dup<0b01, 0b00, "ld1rsw", "d", uimm6w>;
  defm LD1RD    : sve_mem_ld_dup<0b11, 0b11, "ld1rd",  "d", uimm6d>;

  // LDR1 of 8-bit data
  def : LD1RPat<nxv16i8, azextloadi8, LD1RB   , PTRUE_B, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv8i16, azextloadi8, LD1RB_H , PTRUE_H, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv4i32, azextloadi8, LD1RB_S , PTRUE_S, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv2i64, azextloadi8, LD1RB_D , PTRUE_D, i64, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv8i16, sextloadi8,  LD1RSB_H, PTRUE_H, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv4i32, sextloadi8,  LD1RSB_S, PTRUE_S, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv2i64, sextloadi8,  LD1RSB_D, PTRUE_D, i64, am_indexed8_6b, uimm6b>;

  // LDR1 of 16-bit data
  def : LD1RPat<nxv8i16, azextloadi16, LD1RH   , PTRUE_H, i32, am_indexed16_6b, uimm6h>;
  def : LD1RPat<nxv4i32, azextloadi16, LD1RH_S , PTRUE_S, i32, am_indexed16_6b, uimm6h>;
  def : LD1RPat<nxv2i64, azextloadi16, LD1RH_D , PTRUE_D, i64, am_indexed16_6b, uimm6h>;
  def : LD1RPat<nxv4i32, sextloadi16,  LD1RSH_S, PTRUE_S, i32, am_indexed16_6b, uimm6h>;
  def : LD1RPat<nxv2i64, sextloadi16,  LD1RSH_D, PTRUE_D, i64, am_indexed16_6b, uimm6h>;

  // LDR1 of 32-bit data
  def : LD1RPat<nxv4i32, load        , LD1RW   , PTRUE_S, i32, am_indexed32_6b, uimm6w>;
  def : LD1RPat<nxv2i64, azextloadi32, LD1RW_D , PTRUE_D, i64, am_indexed32_6b, uimm6w>;
  def : LD1RPat<nxv2i64, sextloadi32,  LD1RSW  , PTRUE_D, i64, am_indexed32_6b, uimm6w>;

  // LDR1 of 64-bit data
  def : LD1RPat<nxv2i64, load , LD1RD   , PTRUE_D, i64, am_indexed64_6b, uimm6d>;

  // LD1R of FP data
  def : Pat<(nxv4f32 (AArch64dup (f32 (load (am_indexed32_6b GPR64:$Rn, uimm6w:$offset))))),
            (LD1RW (PTRUE_S 31), GPR64:$Rn, uimm6w:$offset)>;
  def : Pat<(nxv2f32 (AArch64dup (f32 (load (am_indexed32_6b GPR64:$Rn, uimm6w:$offset))))),
            (LD1RW_D (PTRUE_D 31), GPR64:$Rn, uimm6w:$offset)>;
  def : Pat<(nxv2f64 (AArch64dup (f64 (load (am_indexed64_6b GPR64:$Rn, uimm6d:$offset))))),
            (LD1RD (PTRUE_D 31), GPR64:$Rn, uimm6d:$offset)>;

  // LDFF1B...
  defm LDFF1B    : sve_mem_cld_ss_ff_b<0b0000, "ldff1b",  "b">;
  defm LDFF1B_H  : sve_mem_cld_ss_ff_b<0b0001, "ldff1b",  "h">;
  defm LDFF1B_S  : sve_mem_cld_ss_ff_b<0b0010, "ldff1b",  "s">;
  defm LDFF1B_D  : sve_mem_cld_ss_ff_b<0b0011, "ldff1b",  "d">;
  defm LDFF1SW_D : sve_mem_cld_ss_ff<  0b0100, "ldff1sw", "d", ", lsl #2">;
  defm LDFF1H    : sve_mem_cld_ss_ff<  0b0101, "ldff1h",  "h", ", lsl #1">;
  defm LDFF1H_S  : sve_mem_cld_ss_ff<  0b0110, "ldff1h",  "s", ", lsl #1">;
  defm LDFF1H_D  : sve_mem_cld_ss_ff<  0b0111, "ldff1h",  "d", ", lsl #1">;
  defm LDFF1SH_D : sve_mem_cld_ss_ff<  0b1000, "ldff1sh", "d", ", lsl #1">;
  defm LDFF1SH_S : sve_mem_cld_ss_ff<  0b1001, "ldff1sh", "s", ", lsl #1">;
  defm LDFF1W    : sve_mem_cld_ss_ff<  0b1010, "ldff1w",  "s", ", lsl #2">;
  defm LDFF1W_D  : sve_mem_cld_ss_ff<  0b1011, "ldff1w",  "d", ", lsl #2">;
  defm LDFF1SB_D : sve_mem_cld_ss_ff_b<0b1100, "ldff1sb", "d">;
  defm LDFF1SB_S : sve_mem_cld_ss_ff_b<0b1101, "ldff1sb", "s">;
  defm LDFF1SB_H : sve_mem_cld_ss_ff_b<0b1110, "ldff1sb", "h">;
  defm LDFF1D    : sve_mem_cld_ss_ff<  0b1111, "ldff1d",  "d", ", lsl #3">;

  // LD{2,3,4}{B,H,W,D} with reg+immediate
  defm LD2B_IMM : sve_mem_eld_si<0b00, 0b01, ZZ_b,   "ld2b", simm4Scale2MulVl>;
  defm LD2H_IMM : sve_mem_eld_si<0b01, 0b01, ZZ_h,   "ld2h", simm4Scale2MulVl>;
  defm LD2W_IMM : sve_mem_eld_si<0b10, 0b01, ZZ_s,   "ld2w", simm4Scale2MulVl>;
  defm LD2D_IMM : sve_mem_eld_si<0b11, 0b01, ZZ_d,   "ld2d", simm4Scale2MulVl>;
  defm LD3B_IMM : sve_mem_eld_si<0b00, 0b10, ZZZ_b,  "ld3b", simm4Scale3MulVl>;
  defm LD3H_IMM : sve_mem_eld_si<0b01, 0b10, ZZZ_h,  "ld3h", simm4Scale3MulVl>;
  defm LD3W_IMM : sve_mem_eld_si<0b10, 0b10, ZZZ_s,  "ld3w", simm4Scale3MulVl>;
  defm LD3D_IMM : sve_mem_eld_si<0b11, 0b10, ZZZ_d,  "ld3d", simm4Scale3MulVl>;
  defm LD4B_IMM : sve_mem_eld_si<0b00, 0b11, ZZZZ_b, "ld4b", simm4Scale4MulVl>;
  defm LD4H_IMM : sve_mem_eld_si<0b01, 0b11, ZZZZ_h, "ld4h", simm4Scale4MulVl>;
  defm LD4W_IMM : sve_mem_eld_si<0b10, 0b11, ZZZZ_s, "ld4w", simm4Scale4MulVl>;
  defm LD4D_IMM : sve_mem_eld_si<0b11, 0b11, ZZZZ_d, "ld4d", simm4Scale4MulVl>;

  // LD{2,3,4}{B,H,W,D} with reg+reg
  def LD2B : sve_mem_eld_ss_b<0b00, 0b01, ZZ_b,   "ld2b">;
  def LD2H : sve_mem_eld_ss<  0b01, 0b01, ZZ_h,   "ld2h", ", lsl #1">;
  def LD2W : sve_mem_eld_ss<  0b10, 0b01, ZZ_s,   "ld2w", ", lsl #2">;
  def LD2D : sve_mem_eld_ss<  0b11, 0b01, ZZ_d,   "ld2d", ", lsl #3">;
  def LD3B : sve_mem_eld_ss_b<0b00, 0b10, ZZZ_b,  "ld3b">;
  def LD3H : sve_mem_eld_ss<  0b01, 0b10, ZZZ_h,  "ld3h", ", lsl #1">;
  def LD3W : sve_mem_eld_ss<  0b10, 0b10, ZZZ_s,  "ld3w", ", lsl #2">;
  def LD3D : sve_mem_eld_ss<  0b11, 0b10, ZZZ_d,  "ld3d", ", lsl #3">;
  def LD4B : sve_mem_eld_ss_b<0b00, 0b11, ZZZZ_b, "ld4b">;
  def LD4H : sve_mem_eld_ss<  0b01, 0b11, ZZZZ_h, "ld4h", ", lsl #1">;
  def LD4W : sve_mem_eld_ss<  0b10, 0b11, ZZZZ_s, "ld4w", ", lsl #2">;
  def LD4D : sve_mem_eld_ss<  0b11, 0b11, ZZZZ_d, "ld4d", ", lsl #3">;

  // GLD1B_S_UXTW, GLD1B_S_SXTW...
  defm GLD1SB_S : sve_mem_32b_gld_vs_32_unscaled<0b000, "ld1sb">;
  defm GLD1B_S  : sve_mem_32b_gld_vs_32_unscaled<0b001, "ld1b">;
  defm GLD1SH_S : sve_mem_32b_gld_vs_32_unscaled<0b010, "ld1sh">;
  defm GLD1H_S  : sve_mem_32b_gld_vs_32_unscaled<0b011, "ld1h">;
  defm GLD1W    : sve_mem_32b_gld_vs_32_unscaled<0b101, "ld1w">;

  // GLDFF1B_S_UXTW, GLDFF1B_S_SXTW...
  defm GLDFF1SB_S : sve_mem_32b_gld_vs_32_unscaled_ff<0b000, "ldff1sb">;
  defm GLDFF1B_S  : sve_mem_32b_gld_vs_32_unscaled_ff<0b001, "ldff1b">;
  defm GLDFF1SH_S : sve_mem_32b_gld_vs_32_unscaled_ff<0b010, "ldff1sh">;
  defm GLDFF1H_S  : sve_mem_32b_gld_vs_32_unscaled_ff<0b011, "ldff1h">;
  defm GLDFF1W    : sve_mem_32b_gld_vs_32_unscaled_ff<0b101, "ldff1w">;

  // GLD1B_S_UXTW_SCALED, GLD1B_S_SXTW_SCALED...
  defm GLD1SH_S : sve_mem_32b_gld_sv_32_scaled<0b010, "ld1sh", "1">;
  defm GLD1H_S  : sve_mem_32b_gld_sv_32_scaled<0b011, "ld1h",  "1">;
  defm GLD1W    : sve_mem_32b_gld_sv_32_scaled<0b101, "ld1w",  "2">;

  // GLDFF1B_S_UXTW_SCALED, GLDFF1B_S_SXTW_SCALED...
  defm GLDFF1SH_S : sve_mem_32b_gld_sv_32_scaled_ff<0b010, "ldff1sh", "1">;
  defm GLDFF1H_S  : sve_mem_32b_gld_sv_32_scaled_ff<0b011, "ldff1h",  "1">;
  defm GLDFF1W    : sve_mem_32b_gld_sv_32_scaled_ff<0b101, "ldff1w",  "2">;

  // GLD1SB_D_IMM...
  defm GLD1SB_S : sve_mem_32b_gld_vi_32_ptrs<0b000, "ld1sb", imm0_31>;
  defm GLD1B_S  : sve_mem_32b_gld_vi_32_ptrs<0b001, "ld1b",  imm0_31>;
  defm GLD1SH_S : sve_mem_32b_gld_vi_32_ptrs<0b010, "ld1sh", uimm5s2>;
  defm GLD1H_S  : sve_mem_32b_gld_vi_32_ptrs<0b011, "ld1h",  uimm5s2>;
  defm GLD1W    : sve_mem_32b_gld_vi_32_ptrs<0b101, "ld1w",  uimm5s4>;

  // GLDFF1SB_D_IMM...
  defm GLDFF1SB_S : sve_mem_32b_gld_vi_32_ptrs_ff<0b000, "ldff1sb", imm0_31>;
  defm GLDFF1B_S  : sve_mem_32b_gld_vi_32_ptrs_ff<0b001, "ldff1b",  imm0_31>;
  defm GLDFF1SH_S : sve_mem_32b_gld_vi_32_ptrs_ff<0b010, "ldff1sh", uimm5s2>;
  defm GLDFF1H_S  : sve_mem_32b_gld_vi_32_ptrs_ff<0b011, "ldff1h",  uimm5s2>;
  defm GLDFF1W    : sve_mem_32b_gld_vi_32_ptrs_ff<0b101, "ldff1w",  uimm5s4>;

  // GLD1B_D...
  defm GLD1SB_D : sve_mem_64b_gld_vs2_64_unscaled<0b000, "ld1sb">;
  defm GLD1B_D  : sve_mem_64b_gld_vs2_64_unscaled<0b001, "ld1b">;
  defm GLD1SH_D : sve_mem_64b_gld_vs2_64_unscaled<0b010, "ld1sh">;
  defm GLD1H_D  : sve_mem_64b_gld_vs2_64_unscaled<0b011, "ld1h">;
  defm GLD1SW_D : sve_mem_64b_gld_vs2_64_unscaled<0b100, "ld1sw">;
  defm GLD1W_D  : sve_mem_64b_gld_vs2_64_unscaled<0b101, "ld1w">;
  defm GLD1D    : sve_mem_64b_gld_vs2_64_unscaled<0b111, "ld1d">;

  // GLDFF1B_D...
  defm GLDFF1SB_D : sve_mem_64b_gld_vs2_64_unscaled_ff<0b000, "ldff1sb">;
  defm GLDFF1B_D  : sve_mem_64b_gld_vs2_64_unscaled_ff<0b001, "ldff1b">;
  defm GLDFF1SH_D : sve_mem_64b_gld_vs2_64_unscaled_ff<0b010, "ldff1sh">;
  defm GLDFF1H_D  : sve_mem_64b_gld_vs2_64_unscaled_ff<0b011, "ldff1h">;
  defm GLDFF1SW_D : sve_mem_64b_gld_vs2_64_unscaled_ff<0b100, "ldff1sw">;
  defm GLDFF1W_D  : sve_mem_64b_gld_vs2_64_unscaled_ff<0b101, "ldff1w">;
  defm GLDFF1D    : sve_mem_64b_gld_vs2_64_unscaled_ff<0b111, "ldff1d">;

  // GLD1SH_D_SCALED...
  defm GLD1SH_D : sve_mem_64b_gld_sv2_64_scaled<0b010, "ld1sh", "1">;
  defm GLD1H_D  : sve_mem_64b_gld_sv2_64_scaled<0b011, "ld1h",  "1">;
  defm GLD1SW_D : sve_mem_64b_gld_sv2_64_scaled<0b100, "ld1sw", "2">;
  defm GLD1W_D  : sve_mem_64b_gld_sv2_64_scaled<0b101, "ld1w",  "2">;
  defm GLD1D    : sve_mem_64b_gld_sv2_64_scaled<0b111, "ld1d",  "3">;

  // GLDFF1SH_D_SCALED...
  defm GLDFF1SH_D : sve_mem_64b_gld_sv2_64_scaled_ff<0b010, "ldff1sh", "1">;
  defm GLDFF1H_D  : sve_mem_64b_gld_sv2_64_scaled_ff<0b011, "ldff1h",  "1">;
  defm GLDFF1SW_D : sve_mem_64b_gld_sv2_64_scaled_ff<0b100, "ldff1sw", "2">;
  defm GLDFF1W_D  : sve_mem_64b_gld_sv2_64_scaled_ff<0b101, "ldff1w",  "2">;
  defm GLDFF1D    : sve_mem_64b_gld_sv2_64_scaled_ff<0b111, "ldff1d",  "3">;

  // GLD1B_D_SXTW, GLD1B_D_UXTW...
  defm GLD1SB_D : sve_mem_64b_gld_vs_32_unscaled<0b000, "ld1sb">;
  defm GLD1B_D  : sve_mem_64b_gld_vs_32_unscaled<0b001, "ld1b">;
  defm GLD1SH_D : sve_mem_64b_gld_vs_32_unscaled<0b010, "ld1sh">;
  defm GLD1H_D  : sve_mem_64b_gld_vs_32_unscaled<0b011, "ld1h">;
  defm GLD1SW_D : sve_mem_64b_gld_vs_32_unscaled<0b100, "ld1sw">;
  defm GLD1W_D  : sve_mem_64b_gld_vs_32_unscaled<0b101, "ld1w">;
  defm GLD1D    : sve_mem_64b_gld_vs_32_unscaled<0b111, "ld1d">;

  // GLDFF1B_D_SXTW, GLDFF1B_D_UXTW...
  defm GLDFF1SB_D : sve_mem_64b_gld_vs_32_unscaled_ff<0b000, "ldff1sb">;
  defm GLDFF1B_D  : sve_mem_64b_gld_vs_32_unscaled_ff<0b001, "ldff1b">;
  defm GLDFF1SH_D : sve_mem_64b_gld_vs_32_unscaled_ff<0b010, "ldff1sh">;
  defm GLDFF1H_D  : sve_mem_64b_gld_vs_32_unscaled_ff<0b011, "ldff1h">;
  defm GLDFF1SW_D : sve_mem_64b_gld_vs_32_unscaled_ff<0b100, "ldff1sw">;
  defm GLDFF1W_D  : sve_mem_64b_gld_vs_32_unscaled_ff<0b101, "ldff1w">;
  defm GLDFF1D    : sve_mem_64b_gld_vs_32_unscaled_ff<0b111, "ldff1d">;

  // GLD1SH_D_SXTW_SCALED, GLD1SH_D_UXTW_SCALED...
  defm GLD1SH_D : sve_mem_64b_gld_sv_32_scaled<0b010, "ld1sh", "1">;
  defm GLD1H_D  : sve_mem_64b_gld_sv_32_scaled<0b011, "ld1h",  "1">;
  defm GLD1SW_D : sve_mem_64b_gld_sv_32_scaled<0b100, "ld1sw", "2">;
  defm GLD1W_D  : sve_mem_64b_gld_sv_32_scaled<0b101, "ld1w",  "2">;
  defm GLD1D    : sve_mem_64b_gld_sv_32_scaled<0b111, "ld1d",  "3">;

  // GLDFF1SH_D_SXTW_SCALED, GLDFF1SH_D_UXTW_SCALED...
  defm GLDFF1SH_D : sve_mem_64b_gld_sv_32_scaled_ff<0b010, "ldff1sh", "1">;
  defm GLDFF1H_D  : sve_mem_64b_gld_sv_32_scaled_ff<0b011, "ldff1h",  "1">;
  defm GLDFF1SW_D : sve_mem_64b_gld_sv_32_scaled_ff<0b100, "ldff1sw", "2">;
  defm GLDFF1W_D  : sve_mem_64b_gld_sv_32_scaled_ff<0b101, "ldff1w",  "2">;
  defm GLDFF1D    : sve_mem_64b_gld_sv_32_scaled_ff<0b111, "ldff1d",  "3">;

  // GLD1SB_D_IMM...
  defm GLD1SB_D : sve_mem_64b_gld_vi_64_ptrs<0b000, "ld1sb", imm0_31>;
  defm GLD1B_D  : sve_mem_64b_gld_vi_64_ptrs<0b001, "ld1b",  imm0_31>;
  defm GLD1SH_D : sve_mem_64b_gld_vi_64_ptrs<0b010, "ld1sh", uimm5s2>;
  defm GLD1H_D  : sve_mem_64b_gld_vi_64_ptrs<0b011, "ld1h",  uimm5s2>;
  defm GLD1SW_D : sve_mem_64b_gld_vi_64_ptrs<0b100, "ld1sw", uimm5s4>;
  defm GLD1W_D  : sve_mem_64b_gld_vi_64_ptrs<0b101, "ld1w",  uimm5s4>;
  defm GLD1D    : sve_mem_64b_gld_vi_64_ptrs<0b111, "ld1d",  uimm5s8>;

  // GLDFF1SB_D_IMM...
  defm GLDFF1SB_D : sve_mem_64b_gld_vi_64_ptrs_ff<0b000, "ldff1sb", imm0_31>;
  defm GLDFF1B_D  : sve_mem_64b_gld_vi_64_ptrs_ff<0b001, "ldff1b",  imm0_31>;
  defm GLDFF1SH_D : sve_mem_64b_gld_vi_64_ptrs_ff<0b010, "ldff1sh", uimm5s2>;
  defm GLDFF1H_D  : sve_mem_64b_gld_vi_64_ptrs_ff<0b011, "ldff1h",  uimm5s2>;
  defm GLDFF1SW_D : sve_mem_64b_gld_vi_64_ptrs_ff<0b100, "ldff1sw", uimm5s4>;
  defm GLDFF1W_D  : sve_mem_64b_gld_vi_64_ptrs_ff<0b101, "ldff1w",  uimm5s4>;
  defm GLDFF1D    : sve_mem_64b_gld_vi_64_ptrs_ff<0b111, "ldff1d",  uimm5s8>;

  defm : SVEExtLoad<nxv8i16, sextloadvi8,  LD1SB_H, LD1SB_H_IMM, PTRUE_H, SVEAddrModeRegReg8>;
  defm : SVEExtLoad<nxv4i32, sextloadvi8,  LD1SB_S, LD1SB_S_IMM, PTRUE_S, SVEAddrModeRegReg8>;
  defm : SVEExtLoad<nxv2i64, sextloadvi8,  LD1SB_D, LD1SB_D_IMM, PTRUE_D, SVEAddrModeRegReg8>;
  defm : SVEExtLoad<nxv4i32, sextloadvi16, LD1SH_S, LD1SH_S_IMM, PTRUE_S, SVEAddrModeRegReg16>;
  defm : SVEExtLoad<nxv2i64, sextloadvi16, LD1SH_D, LD1SH_D_IMM, PTRUE_D, SVEAddrModeRegReg16>;
  defm : SVEExtLoad<nxv2i64, sextloadvi32, LD1SW_D, LD1SW_D_IMM, PTRUE_D, SVEAddrModeRegReg32>;

  // It doesn't matter whether we use sign- or zero-extending loads
  // for any_extend, but we have to pick one.
  defm : SVEExtLoad<nxv8i16, azextloadvi8,  LD1B_H, LD1B_H_IMM, PTRUE_H, SVEAddrModeRegReg8>;
  defm : SVEExtLoad<nxv4i32, azextloadvi8,  LD1B_S, LD1B_S_IMM, PTRUE_S, SVEAddrModeRegReg8>;
  defm : SVEExtLoad<nxv2i64, azextloadvi8,  LD1B_D, LD1B_D_IMM, PTRUE_D, SVEAddrModeRegReg8>;
  defm : SVEExtLoad<nxv4i32, azextloadvi16, LD1H_S, LD1H_S_IMM, PTRUE_S, SVEAddrModeRegReg16>;
  defm : SVEExtLoad<nxv2i64, azextloadvi16, LD1H_D, LD1H_D_IMM, PTRUE_D, SVEAddrModeRegReg16>;
  defm : SVEExtLoad<nxv2i64, azextloadvi32, LD1W_D, LD1W_D_IMM, PTRUE_D, SVEAddrModeRegReg32>;

  // ST1B...
  defm ST1B   : sve_mem_cst_ss_b<0b0000, 1, "st1b", "b">;
  defm ST1B_H : sve_mem_cst_ss_b<0b0001, 1, "st1b", "h">;
  defm ST1B_S : sve_mem_cst_ss_b<0b0010, 1, "st1b", "s">;
  defm ST1B_D : sve_mem_cst_ss_b<0b0011, 1, "st1b", "d">;
  defm ST1H   : sve_mem_cst_ss<  0b0101, 1, "st1h", "h", ", lsl #1">;
  defm ST1H_S : sve_mem_cst_ss<  0b0110, 1, "st1h", "s", ", lsl #1">;
  defm ST1H_D : sve_mem_cst_ss<  0b0111, 1, "st1h", "d", ", lsl #1">;
  defm ST1W   : sve_mem_cst_ss<  0b1010, 1, "st1w", "s", ", lsl #2">;
  defm ST1W_D : sve_mem_cst_ss<  0b1011, 1, "st1w", "d", ", lsl #2">;
  defm ST1D   : sve_mem_cst_ss<  0b1111, 1, "st1d", "d", ", lsl #3">;

  // continuous store with immediates
  defm ST1B_B_IMM : sve_mem_cst_si<0b00, 0b00, "st1b", "b">;
  defm ST1B_H_IMM : sve_mem_cst_si<0b00, 0b01, "st1b", "h">;
  defm ST1B_S_IMM : sve_mem_cst_si<0b00, 0b10, "st1b", "s">;
  defm ST1B_D_IMM : sve_mem_cst_si<0b00, 0b11, "st1b", "d">;
  defm ST1H_H_IMM : sve_mem_cst_si<0b01, 0b01, "st1h", "h">;
  defm ST1H_S_IMM : sve_mem_cst_si<0b01, 0b10, "st1h", "s">;
  defm ST1H_D_IMM : sve_mem_cst_si<0b01, 0b11, "st1h", "d">;
  defm ST1W_S_IMM : sve_mem_cst_si<0b10, 0b10, "st1w", "s">;
  defm ST1W_D_IMM : sve_mem_cst_si<0b10, 0b11, "st1w", "d">;
  defm ST1D_D_IMM : sve_mem_cst_si<0b11, 0b11, "st1d", "d">;

  // SST1B_D_SXTW, SST1B_D_UXTW...
  defm SST1B_D : sve_mem_sst_vs_32_unscaled<0b000, "st1b", "d">;
  defm SST1B_S : sve_mem_sst_vs_32_unscaled<0b001, "st1b", "s">;
  defm SST1H_D : sve_mem_sst_vs_32_unscaled<0b010, "st1h", "d">;
  defm SST1H_S : sve_mem_sst_vs_32_unscaled<0b011, "st1h", "s">;
  defm SST1W_D : sve_mem_sst_vs_32_unscaled<0b100, "st1w", "d">;
  defm SST1W   : sve_mem_sst_vs_32_unscaled<0b101, "st1w", "s">;
  defm SST1D   : sve_mem_sst_vs_32_unscaled<0b110, "st1d", "d">;

  // SST1B_D_SXTW_SCALED, SST1B_D_UXTW_SCALED...
  defm SST1H_D : sve_mem_sst_sv_32_scaled<0b010, "st1h", "d", "1">;
  defm SST1H_S : sve_mem_sst_sv_32_scaled<0b011, "st1h", "s", "1">;
  defm SST1W_D : sve_mem_sst_sv_32_scaled<0b100, "st1w", "d", "2">;
  defm SST1W   : sve_mem_sst_sv_32_scaled<0b101, "st1w", "s", "2">;
  defm SST1D   : sve_mem_sst_sv_32_scaled<0b110, "st1d", "d", "3">;

  // SST1B_D...
  defm SST1B_D : sve_mem_sst_vs2_64_unscaled<0b00, "st1b">;
  defm SST1H_D : sve_mem_sst_vs2_64_unscaled<0b01, "st1h">;
  defm SST1W_D : sve_mem_sst_vs2_64_unscaled<0b10, "st1w">;
  defm SST1D   : sve_mem_sst_vs2_64_unscaled<0b11, "st1d">;

  // SST1H_D_SCALED...
  defm SST1H_D_SCALED : sve_mem_sst_sv2_64_scaled<0b01, "st1h", "1">;
  defm SST1W_D_SCALED : sve_mem_sst_sv2_64_scaled<0b10, "st1w", "2">;
  defm SST1D_SCALED   : sve_mem_sst_sv2_64_scaled<0b11, "st1d", "3">;

  // SST1B_D_IMM...
  defm SST1B_D : sve_mem_sst_vi_ptrs<0b000, "st1b", "d", imm0_31>;
  defm SST1B_S : sve_mem_sst_vi_ptrs<0b001, "st1b", "s", imm0_31>;
  defm SST1H_D : sve_mem_sst_vi_ptrs<0b010, "st1h", "d", uimm5s2>;
  defm SST1H_S : sve_mem_sst_vi_ptrs<0b011, "st1h", "s", uimm5s2>;
  defm SST1W_D : sve_mem_sst_vi_ptrs<0b100, "st1w", "d", uimm5s4>;
  defm SST1W   : sve_mem_sst_vi_ptrs<0b101, "st1w", "s", uimm5s4>;
  defm SST1D   : sve_mem_sst_vi_ptrs<0b110, "st1d", "d", uimm5s8>;

  // ST{2,3,4}{B,H,W,D} with immediate
  defm ST2B_IMM : sve_mem_est_si<0b00, 0b01, ZZ_b,   "st2b", simm4Scale2MulVl>;
  defm ST2H_IMM : sve_mem_est_si<0b01, 0b01, ZZ_h,   "st2h", simm4Scale2MulVl>;
  defm ST2W_IMM : sve_mem_est_si<0b10, 0b01, ZZ_s,   "st2w", simm4Scale2MulVl>;
  defm ST2D_IMM : sve_mem_est_si<0b11, 0b01, ZZ_d,   "st2d", simm4Scale2MulVl>;
  defm ST3B_IMM : sve_mem_est_si<0b00, 0b10, ZZZ_b,  "st3b", simm4Scale3MulVl>;
  defm ST3H_IMM : sve_mem_est_si<0b01, 0b10, ZZZ_h,  "st3h", simm4Scale3MulVl>;
  defm ST3W_IMM : sve_mem_est_si<0b10, 0b10, ZZZ_s,  "st3w", simm4Scale3MulVl>;
  defm ST3D_IMM : sve_mem_est_si<0b11, 0b10, ZZZ_d,  "st3d", simm4Scale3MulVl>;
  defm ST4B_IMM : sve_mem_est_si<0b00, 0b11, ZZZZ_b, "st4b", simm4Scale4MulVl>;
  defm ST4H_IMM : sve_mem_est_si<0b01, 0b11, ZZZZ_h, "st4h", simm4Scale4MulVl>;
  defm ST4W_IMM : sve_mem_est_si<0b10, 0b11, ZZZZ_s, "st4w", simm4Scale4MulVl>;
  defm ST4D_IMM : sve_mem_est_si<0b11, 0b11, ZZZZ_d, "st4d", simm4Scale4MulVl>;

  // ST{2,3,4}{B,H,W,D} with reg+reg
  def ST2B : sve_mem_est_ss_b<0b00, 0b01, ZZ_b,   "st2b">;
  def ST2H : sve_mem_est_ss<  0b01, 0b01, ZZ_h,   "st2h", ", lsl #1">;
  def ST2W : sve_mem_est_ss<  0b10, 0b01, ZZ_s,   "st2w", ", lsl #2">;
  def ST2D : sve_mem_est_ss<  0b11, 0b01, ZZ_d,   "st2d", ", lsl #3">;
  def ST3B : sve_mem_est_ss_b<0b00, 0b10, ZZZ_b,  "st3b">;
  def ST3H : sve_mem_est_ss<  0b01, 0b10, ZZZ_h,  "st3h", ", lsl #1">;
  def ST3W : sve_mem_est_ss<  0b10, 0b10, ZZZ_s,  "st3w", ", lsl #2">;
  def ST3D : sve_mem_est_ss<  0b11, 0b10, ZZZ_d,  "st3d", ", lsl #3">;
  def ST4B : sve_mem_est_ss_b<0b00, 0b11, ZZZZ_b, "st4b">;
  def ST4H : sve_mem_est_ss<  0b01, 0b11, ZZZZ_h, "st4h", ", lsl #1">;
  def ST4W : sve_mem_est_ss<  0b10, 0b11, ZZZZ_s, "st4w", ", lsl #2">;
  def ST4D : sve_mem_est_ss<  0b11, 0b11, ZZZZ_d, "st4d", ", lsl #3">;

  defm : SVETruncStore<nxv8i16, truncstorevi8,  ST1B_H, ST1B_H_IMM, PTRUE_H, SVEAddrModeRegReg8>;
  defm : SVETruncStore<nxv4i32, truncstorevi8,  ST1B_S, ST1B_S_IMM, PTRUE_S, SVEAddrModeRegReg8>;
  defm : SVETruncStore<nxv2i64, truncstorevi8,  ST1B_D, ST1B_D_IMM, PTRUE_D, SVEAddrModeRegReg8>;
  defm : SVETruncStore<nxv4i32, truncstorevi16, ST1H_S, ST1H_S_IMM, PTRUE_S, SVEAddrModeRegReg16>;
  defm : SVETruncStore<nxv2i64, truncstorevi16, ST1H_D, ST1H_D_IMM, PTRUE_D, SVEAddrModeRegReg16>;
  defm : SVETruncStore<nxv2i64, truncstorevi32, ST1W_D, ST1W_D_IMM, PTRUE_D, SVEAddrModeRegReg32>;

  defm TBL_ZZZ  : sve_int_perm_tbl<"tbl", AArch64TBL>;
  defm ZIP1_ZZZ : sve_int_perm_bin_perm_zz<0b000, "zip1", AArch64zip1>;
  defm ZIP2_ZZZ : sve_int_perm_bin_perm_zz<0b001, "zip2", AArch64zip2>;
  defm UZP1_ZZZ : sve_int_perm_bin_perm_zz<0b010, "uzp1", AArch64uzp1>;
  defm UZP2_ZZZ : sve_int_perm_bin_perm_zz<0b011, "uzp2", AArch64uzp2>;
  defm TRN1_ZZZ : sve_int_perm_bin_perm_zz<0b100, "trn1", AArch64trn1>;
  defm TRN2_ZZZ : sve_int_perm_bin_perm_zz<0b101, "trn2", AArch64trn2>;

  defm ZIP1_PPP : sve_int_perm_bin_perm_pp<0b000, "zip1", AArch64zip1>;
  defm ZIP2_PPP : sve_int_perm_bin_perm_pp<0b001, "zip2", AArch64zip2>;
  defm UZP1_PPP : sve_int_perm_bin_perm_pp<0b010, "uzp1", AArch64uzp1>;
  defm UZP2_PPP : sve_int_perm_bin_perm_pp<0b011, "uzp2", AArch64uzp2>;
  defm TRN1_PPP : sve_int_perm_bin_perm_pp<0b100, "trn1", AArch64trn1>;
  defm TRN2_PPP : sve_int_perm_bin_perm_pp<0b101, "trn2", AArch64trn2>;

  defm CPY_ZPmR : sve_int_perm_cpy_r<"cpy", AArch64dup_pred>;
  defm CPY_ZPmV : sve_int_perm_cpy_v<"cpy", AArch64dup_pred>;

  defm CPY_ZPmI : sve_int_dup_imm_pred_merge<"cpy">;
  defm CPY_ZPzI : sve_int_dup_imm_pred_zero<"cpy">;

  defm FCPY_ZI   : sve_int_dup_fpimm<0b000, "fdup">;
  defm FCPY_ZPmI : sve_int_dup_fpimm_pred<"fcpy">;

  defm COMPACT_ZPZ : sve_int_perm_compact<"compact", int_aarch64_sve_compact>;

  defm DUP_ZR  : sve_int_perm_dup_r<"dup">;
  defm DUP_ZZI : sve_int_perm_dup_i<"dup">;
  defm DUP_ZI  : sve_int_dup_imm<0b00, "dup">;

  defm DUPM_ZI : sve_int_dup_mask_imm<"dupm">;
  def : Pat<(nxv2i64 (AArch64dup (i64 logical_imm64:$imms1))),
            (DUPM_ZI logical_imm64:$imms1)>;

  defm CLASTA_RPZ : sve_int_perm_clast_rz<0, "clasta", AArch64clasta_n>;
  defm CLASTB_RPZ : sve_int_perm_clast_rz<1, "clastb", AArch64clastb_n>;
  defm CLASTA_VPZ : sve_int_perm_clast_vz<0, "clasta", AArch64clasta_n>;
  defm CLASTB_VPZ : sve_int_perm_clast_vz<1, "clastb", AArch64clastb_n>;
  defm CLASTA_ZPZ : sve_int_perm_clast_zz<0, "clasta", int_aarch64_sve_clasta>;
  defm CLASTB_ZPZ : sve_int_perm_clast_zz<1, "clastb", int_aarch64_sve_clastb>;

  defm LASTA_RPZ : sve_int_perm_last_r<0, "lasta", AArch64lasta>;
  defm LASTB_RPZ : sve_int_perm_last_r<1, "lastb", AArch64lastb>;
  defm LASTA_VPZ : sve_int_perm_last_v<0, "lasta", AArch64lasta>;
  defm LASTB_VPZ : sve_int_perm_last_v<1, "lastb", AArch64lastb>;

  def RDVLI_XI  : sve_int_read_vl_a<0b011111, "rdvl">;
  def ADDVL_XXI : sve_int_arith_vl<0b0, "addvl">;
  def ADDPL_XXI : sve_int_arith_vl<0b1, "addpl">;

  defm CNTB_XPiI : sve_int_count<0b000, "cntb", int_aarch64_sve_cntb>;
  defm CNTH_XPiI : sve_int_count<0b010, "cnth", int_aarch64_sve_cnth>;
  defm CNTW_XPiI : sve_int_count<0b100, "cntw", int_aarch64_sve_cntw>;
  defm CNTD_XPiI : sve_int_count<0b110, "cntd", int_aarch64_sve_cntd>;

  defm SQINCH_ZPiI : sve_int_countvlv<0b01000, "sqinch", ".h", int_aarch64_sve_sqinch, nxv8i16>;
  defm UQINCH_ZPiI : sve_int_countvlv<0b01001, "uqinch", ".h", int_aarch64_sve_uqinch, nxv8i16>;
  defm SQDECH_ZPiI : sve_int_countvlv<0b01010, "sqdech", ".h", int_aarch64_sve_sqdech, nxv8i16>;
  defm UQDECH_ZPiI : sve_int_countvlv<0b01011, "uqdech", ".h", int_aarch64_sve_uqdech, nxv8i16>;
  defm INCH_ZPiI   : sve_int_countvlv<0b01100, "inch",   ".h">;
  defm DECH_ZPiI   : sve_int_countvlv<0b01101, "dech",   ".h">;
  defm SQINCW_ZPiI : sve_int_countvlv<0b10000, "sqincw", ".s", int_aarch64_sve_sqincw, nxv4i32>;
  defm UQINCW_ZPiI : sve_int_countvlv<0b10001, "uqincw", ".s", int_aarch64_sve_uqincw, nxv4i32>;
  defm SQDECW_ZPiI : sve_int_countvlv<0b10010, "sqdecw", ".s", int_aarch64_sve_sqdecw, nxv4i32>;
  defm UQDECW_ZPiI : sve_int_countvlv<0b10011, "uqdecw", ".s", int_aarch64_sve_uqdecw, nxv4i32>;
  defm INCW_ZPiI   : sve_int_countvlv<0b10100, "incw",   ".s">;
  defm DECW_ZPiI   : sve_int_countvlv<0b10101, "decw",   ".s">;
  defm SQINCD_ZPiI : sve_int_countvlv<0b11000, "sqincd", ".d", int_aarch64_sve_sqincd, nxv2i64>;
  defm UQINCD_ZPiI : sve_int_countvlv<0b11001, "uqincd", ".d", int_aarch64_sve_uqincd, nxv2i64>;
  defm SQDECD_ZPiI : sve_int_countvlv<0b11010, "sqdecd", ".d", int_aarch64_sve_sqdecd, nxv2i64>;
  defm UQDECD_ZPiI : sve_int_countvlv<0b11011, "uqdecd", ".d", int_aarch64_sve_uqdecd, nxv2i64>;
  defm INCD_ZPiI   : sve_int_countvlv<0b11100, "incd",   ".d">;
  defm DECD_ZPiI   : sve_int_countvlv<0b11101, "decd",   ".d">;

  defm INCB_XPiI : sve_int_pred_pattern_a<0b000, "incb">;
  defm DECB_XPiI : sve_int_pred_pattern_a<0b001, "decb">;
  defm INCH_XPiI : sve_int_pred_pattern_a<0b010, "inch">;
  defm DECH_XPiI : sve_int_pred_pattern_a<0b011, "dech">;
  defm INCW_XPiI : sve_int_pred_pattern_a<0b100, "incw">;
  defm DECW_XPiI : sve_int_pred_pattern_a<0b101, "decw">;
  defm INCD_XPiI : sve_int_pred_pattern_a<0b110, "incd">;
  defm DECD_XPiI : sve_int_pred_pattern_a<0b111, "decd">;

  defm SQINCB_XPiWdI : sve_int_pred_pattern_b_s32<0b00000, "sqincb", int_aarch64_sve_sqincb_n32>;
  defm UQINCB_WPiI   : sve_int_pred_pattern_b_u32<0b00001, "uqincb", int_aarch64_sve_uqincb_n32>;
  defm SQDECB_XPiWdI : sve_int_pred_pattern_b_s32<0b00010, "sqdecb", int_aarch64_sve_sqdecb_n32>;
  defm UQDECB_WPiI   : sve_int_pred_pattern_b_u32<0b00011, "uqdecb", int_aarch64_sve_uqdecb_n32>;
  defm SQINCB_XPiI   : sve_int_pred_pattern_b_x64<0b00100, "sqincb", int_aarch64_sve_sqincb_n64>;
  defm UQINCB_XPiI   : sve_int_pred_pattern_b_x64<0b00101, "uqincb", int_aarch64_sve_uqincb_n64>;
  defm SQDECB_XPiI   : sve_int_pred_pattern_b_x64<0b00110, "sqdecb", int_aarch64_sve_sqdecb_n64>;
  defm UQDECB_XPiI   : sve_int_pred_pattern_b_x64<0b00111, "uqdecb", int_aarch64_sve_uqdecb_n64>;

  defm SQINCH_XPiWdI : sve_int_pred_pattern_b_s32<0b01000, "sqinch", int_aarch64_sve_sqinch_n32>;
  defm UQINCH_WPiI   : sve_int_pred_pattern_b_u32<0b01001, "uqinch", int_aarch64_sve_uqinch_n32>;
  defm SQDECH_XPiWdI : sve_int_pred_pattern_b_s32<0b01010, "sqdech", int_aarch64_sve_sqdech_n32>;
  defm UQDECH_WPiI   : sve_int_pred_pattern_b_u32<0b01011, "uqdech", int_aarch64_sve_uqdech_n32>;
  defm SQINCH_XPiI   : sve_int_pred_pattern_b_x64<0b01100, "sqinch", int_aarch64_sve_sqinch_n64>;
  defm UQINCH_XPiI   : sve_int_pred_pattern_b_x64<0b01101, "uqinch", int_aarch64_sve_uqinch_n64>;
  defm SQDECH_XPiI   : sve_int_pred_pattern_b_x64<0b01110, "sqdech", int_aarch64_sve_sqdech_n64>;
  defm UQDECH_XPiI   : sve_int_pred_pattern_b_x64<0b01111, "uqdech", int_aarch64_sve_uqdech_n64>;

  defm SQINCW_XPiWdI : sve_int_pred_pattern_b_s32<0b10000, "sqincw", int_aarch64_sve_sqincw_n32>;
  defm UQINCW_WPiI   : sve_int_pred_pattern_b_u32<0b10001, "uqincw", int_aarch64_sve_uqincw_n32>;
  defm SQDECW_XPiWdI : sve_int_pred_pattern_b_s32<0b10010, "sqdecw", int_aarch64_sve_sqdecw_n32>;
  defm UQDECW_WPiI   : sve_int_pred_pattern_b_u32<0b10011, "uqdecw", int_aarch64_sve_uqdecw_n32>;
  defm SQINCW_XPiI   : sve_int_pred_pattern_b_x64<0b10100, "sqincw", int_aarch64_sve_sqincw_n64>;
  defm UQINCW_XPiI   : sve_int_pred_pattern_b_x64<0b10101, "uqincw", int_aarch64_sve_uqincw_n64>;
  defm SQDECW_XPiI   : sve_int_pred_pattern_b_x64<0b10110, "sqdecw", int_aarch64_sve_sqdecw_n64>;
  defm UQDECW_XPiI   : sve_int_pred_pattern_b_x64<0b10111, "uqdecw", int_aarch64_sve_uqdecw_n64>;

  defm SQINCD_XPiWdI : sve_int_pred_pattern_b_s32<0b11000, "sqincd", int_aarch64_sve_sqincd_n32>;
  defm UQINCD_WPiI   : sve_int_pred_pattern_b_u32<0b11001, "uqincd", int_aarch64_sve_uqincd_n32>;
  defm SQDECD_XPiWdI : sve_int_pred_pattern_b_s32<0b11010, "sqdecd", int_aarch64_sve_sqdecd_n32>;
  defm UQDECD_WPiI   : sve_int_pred_pattern_b_u32<0b11011, "uqdecd", int_aarch64_sve_uqdecd_n32>;
  defm SQINCD_XPiI   : sve_int_pred_pattern_b_x64<0b11100, "sqincd", int_aarch64_sve_sqincd_n64>;
  defm UQINCD_XPiI   : sve_int_pred_pattern_b_x64<0b11101, "uqincd", int_aarch64_sve_uqincd_n64>;
  defm SQDECD_XPiI   : sve_int_pred_pattern_b_x64<0b11110, "sqdecd", int_aarch64_sve_sqdecd_n64>;
  defm UQDECD_XPiI   : sve_int_pred_pattern_b_x64<0b11111, "uqdecd", int_aarch64_sve_uqdecd_n64>;

  defm SQINCP_XPWd : sve_int_count_r_s32<0b00000, "sqincp", int_aarch64_sve_sqincp_n32>;
  defm SQINCP_XP   : sve_int_count_r_x64<0b00010, "sqincp", int_aarch64_sve_sqincp_n64>;
  defm UQINCP_WP   : sve_int_count_r_u32<0b00100, "uqincp", int_aarch64_sve_uqincp_n32>;
  defm UQINCP_XP   : sve_int_count_r_x64<0b00110, "uqincp", int_aarch64_sve_uqincp_n64>;
  defm SQDECP_XPWd : sve_int_count_r_s32<0b01000, "sqdecp", int_aarch64_sve_sqdecp_n32>;
  defm SQDECP_XP   : sve_int_count_r_x64<0b01010, "sqdecp", int_aarch64_sve_sqdecp_n64>;
  defm UQDECP_WP   : sve_int_count_r_u32<0b01100, "uqdecp", int_aarch64_sve_uqdecp_n32>;
  defm UQDECP_XP   : sve_int_count_r_x64<0b01110, "uqdecp", int_aarch64_sve_uqdecp_n64>;
  defm INCP_XP     : sve_int_count_r_x64<0b10000, "incp">;
  defm DECP_XP     : sve_int_count_r_x64<0b10100, "decp">;

  defm SQINCP_ZP   : sve_int_count_v<0b00000, "sqincp", int_aarch64_sve_sqincp>;
  defm UQINCP_ZP   : sve_int_count_v<0b00100, "uqincp", int_aarch64_sve_uqincp>;
  defm SQDECP_ZP   : sve_int_count_v<0b01000, "sqdecp", int_aarch64_sve_sqdecp>;
  defm UQDECP_ZP   : sve_int_count_v<0b01100, "uqdecp", int_aarch64_sve_uqdecp>;
  defm INCP_ZP     : sve_int_count_v<0b10000, "incp">;
  defm DECP_ZP     : sve_int_count_v<0b10100, "decp">;

  defm INSR_ZR : sve_int_perm_insrs<"insr", AArch64insr>;
  defm INSR_ZV : sve_int_perm_insrv<"insr", AArch64insr>;

  defm PUNPKLO_PP : sve_int_perm_punpk<0b0, "punpklo", int_aarch64_sve_punpklo>;
  defm PUNPKHI_PP : sve_int_perm_punpk<0b1, "punpkhi", int_aarch64_sve_punpkhi>;

  defm REV_PP : sve_int_perm_reverse_p<"rev", AArch64rev>;
  defm REV_ZZ : sve_int_perm_reverse_z<"rev", AArch64rev>;

  defm RBIT_ZPmZ : sve_int_perm_rev_rbit<"rbit", int_aarch64_sve_rbit>;
  defm REVB_ZPmZ : sve_int_perm_rev_revb<"revb", int_aarch64_sve_revb, bswap>;
  defm REVH_ZPmZ : sve_int_perm_rev_revh<"revh", int_aarch64_sve_revh>;
  defm REVW_ZPmZ : sve_int_perm_rev_revw<"revw", int_aarch64_sve_revw>;

  defm SPLICE_ZPZ : sve_int_perm_splice<"splice", int_aarch64_sve_splice>;

  defm SUNPKLO_ZZ : sve_int_perm_unpk<0b00, "sunpklo", AArch64sunpklo>;
  defm SUNPKHI_ZZ : sve_int_perm_unpk<0b01, "sunpkhi", AArch64sunpkhi>;
  defm UUNPKLO_ZZ : sve_int_perm_unpk<0b10, "uunpklo", AArch64uunpklo>;
  defm UUNPKHI_ZZ : sve_int_perm_unpk<0b11, "uunpkhi", AArch64uunpkhi>;

  defm SEL_ZPZZ : sve_int_sel_vvv<"sel", vselect>;

  defm INDEX_RR : sve_int_index_rr<"index", series_vector>;
  defm INDEX_IR : sve_int_index_ir<"index", series_vector>;
  defm INDEX_RI : sve_int_index_ri<"index", series_vector>;
  defm INDEX_II : sve_int_index_ii<"index", series_vector>;

  defm CNTP_XPP : sve_int_pcount_pred<0b0000, "cntp", int_aarch64_sve_cntp, int_ctvpop>;
  def : Pat<(i64 (add GPR64:$Xd, (int_ctvpop (nxv16i1 PPR:$Ps)))),
            (INCP_XP_B $Ps, $Xd)>;

  def : Pat<(element_count nxv16i8), (RDVLI_XI 1)>;
  def : Pat<(srl (element_count nxv16i8), (i64 1)), (CNTH_XPiI 31, 1)>;
  def : Pat<(srl (element_count nxv16i8), (i64 2)), (CNTW_XPiI 31, 1)>;
  def : Pat<(srl (element_count nxv16i8), (i64 3)), (CNTD_XPiI 31, 1)>;

  def : Pat<(add GPR64:$op, (element_count nxv16i8)),
            (ADDVL_XXI GPR64:$op, 1)>;
  def : Pat<(add GPR64:$op, (shl (element_count nxv16i8), (i64 1))),
            (ADDVL_XXI GPR64:$op, 2)>;

  def : Pat<(sub GPR64:$op, (element_count nxv16i8)),
            (ADDVL_XXI GPR64:$op, -1)>;
  def : Pat<(sub GPR64:$op, (shl (element_count nxv16i8), (i64 1))),
            (ADDVL_XXI GPR64:$op, -2)>;

  def : Pat<(add GPR64:$op, (srl (element_count nxv16i8), (i64 1))),
            (INCH_XPiI GPR64:$op, 31, 1)>;
  def : Pat<(add GPR64:$op, (srl (element_count nxv16i8), (i64 2))),
            (INCW_XPiI GPR64:$op, 31, 1)>;
  def : Pat<(add GPR64:$op, (srl (element_count nxv16i8), (i64 3))),
            (INCD_XPiI GPR64:$op, 31, 1)>;

  def : Pat<(sub GPR64:$op, (srl (element_count nxv16i8), (i64 1))),
            (DECH_XPiI GPR64:$op, 31, 1)>;
  def : Pat<(sub GPR64:$op, (srl (element_count nxv16i8), (i64 2))),
            (DECW_XPiI GPR64:$op, 31, 1)>;
  def : Pat<(sub GPR64:$op, (srl (element_count nxv16i8), (i64 3))),
            (DECD_XPiI GPR64:$op, 31, 1)>;

  defm LDR_PXI : sve_mem_32b_pfill<"ldr">;
  defm STR_PXI : sve_mem_pspill<"str">;

  defm CMPHS_PPzZZ : sve_int_cmp_0<0b000, "cmphs", int_aarch64_sve_cmphs, SETUGE>;
  defm CMPHI_PPzZZ : sve_int_cmp_0<0b001, "cmphi", int_aarch64_sve_cmphi, SETUGT>;
  defm CMPGE_PPzZZ : sve_int_cmp_0<0b100, "cmpge", int_aarch64_sve_cmpge, SETGE>;
  defm CMPGT_PPzZZ : sve_int_cmp_0<0b101, "cmpgt", int_aarch64_sve_cmpgt, SETGT>;
  defm CMPEQ_PPzZZ : sve_int_cmp_0<0b110, "cmpeq", int_aarch64_sve_cmpeq, SETEQ>;
  defm CMPNE_PPzZZ : sve_int_cmp_0<0b111, "cmpne", int_aarch64_sve_cmpne, SETNE>;

  defm CMPEQ_WIDE_PPzZZ : sve_int_cmp_0_wide<0b010, "cmpeq", int_aarch64_sve_cmpeq_wide>;
  defm CMPNE_WIDE_PPzZZ : sve_int_cmp_0_wide<0b011, "cmpne", int_aarch64_sve_cmpne_wide>;
  defm CMPGE_WIDE_PPzZZ : sve_int_cmp_1_wide<0b000, "cmpge", int_aarch64_sve_cmpge_wide>;
  defm CMPGT_WIDE_PPzZZ : sve_int_cmp_1_wide<0b001, "cmpgt", int_aarch64_sve_cmpgt_wide>;
  defm CMPLT_WIDE_PPzZZ : sve_int_cmp_1_wide<0b010, "cmplt", int_aarch64_sve_cmplt_wide>;
  defm CMPLE_WIDE_PPzZZ : sve_int_cmp_1_wide<0b011, "cmple", int_aarch64_sve_cmple_wide>;
  defm CMPHS_WIDE_PPzZZ : sve_int_cmp_1_wide<0b100, "cmphs", int_aarch64_sve_cmphs_wide>;
  defm CMPHI_WIDE_PPzZZ : sve_int_cmp_1_wide<0b101, "cmphi", int_aarch64_sve_cmphi_wide>;
  defm CMPLO_WIDE_PPzZZ : sve_int_cmp_1_wide<0b110, "cmplo", int_aarch64_sve_cmplo_wide>;
  defm CMPLS_WIDE_PPzZZ : sve_int_cmp_1_wide<0b111, "cmpls", int_aarch64_sve_cmpls_wide>;

  defm CMPGE_PPzZI : sve_int_scmp_vi<0b000, "cmpge", SETGE, int_aarch64_sve_cmpge>;
  defm CMPGT_PPzZI : sve_int_scmp_vi<0b001, "cmpgt", SETGT, int_aarch64_sve_cmpgt>;
  defm CMPLT_PPzZI : sve_int_scmp_vi<0b010, "cmplt", SETLT, null_frag, int_aarch64_sve_cmpgt>;
  defm CMPLE_PPzZI : sve_int_scmp_vi<0b011, "cmple", SETLE, null_frag, int_aarch64_sve_cmpge>;
  defm CMPEQ_PPzZI : sve_int_scmp_vi<0b100, "cmpeq", SETEQ, int_aarch64_sve_cmpeq>;
  defm CMPNE_PPzZI : sve_int_scmp_vi<0b101, "cmpne", SETNE, int_aarch64_sve_cmpne>;
  defm CMPHS_PPzZI : sve_int_ucmp_vi<0b00, "cmphs", SETUGE, int_aarch64_sve_cmphs>;
  defm CMPHI_PPzZI : sve_int_ucmp_vi<0b01, "cmphi", SETUGT, int_aarch64_sve_cmphi>;
  defm CMPLO_PPzZI : sve_int_ucmp_vi<0b10, "cmplo", SETULT, null_frag, int_aarch64_sve_cmphi>;
  defm CMPLS_PPzZI : sve_int_ucmp_vi<0b11, "cmpls", SETULE, null_frag, int_aarch64_sve_cmphs>;

  def  PFIRST : sve_int_pfirst_next<0b01, 0b00000, "pfirst", ".b", nxv16i1, int_aarch64_sve_pfirst>;
  defm PNEXT  : sve_int_pfirst_next<0b00110, "pnext", int_aarch64_sve_pnext>;

  def PFALSE : sve_int_pfalse<0b000000, "pfalse">;

  def RDFFR_PPz  : sve_int_rdffr<0b0000000, "rdffr">;
  def RDFFRS_PPz : sve_int_rdffr<0b0100000, "rdffrs">;
  def : Pat<(nxv16i1 (AArch64rdffr_pred (nxv16i1 PPR:$Pg))), (RDFFR_PPz PPR:$Pg)>;
  def : Pat<(nxv8i1  (AArch64rdffr_pred (nxv8i1  PPR:$Pg))), (RDFFR_PPz PPR:$Pg)>;
  def : Pat<(nxv4i1  (AArch64rdffr_pred (nxv4i1  PPR:$Pg))), (RDFFR_PPz PPR:$Pg)>;
  def : Pat<(nxv2i1  (AArch64rdffr_pred (nxv2i1  PPR:$Pg))), (RDFFR_PPz PPR:$Pg)>;

  defm RDFFR_P : sve_int_rdffr_2<0b000000, "rdffr", AArch64rdffr>;

  def SETFFR : sve_int_setffr<"setffr", AArch64setffr>;

  def WRFFR : sve_int_wrffr<"wrffr", AArch64wrffr>;

  def PTEST_PP : sve_int_ptest<0b010000, "ptest">;

  defm BRKA_PPzP  : sve_int_break_z<0b000000, "brka",  int_aarch64_sve_brka_z>;
  defm BRKA_PPmP  : sve_int_break_m<0b000001, "brka",  int_aarch64_sve_brka>;
  defm BRKAS_PPzP : sve_int_break_z<0b010000, "brkas", null_frag>;
  defm BRKB_PPzP  : sve_int_break_z<0b100000, "brkb",  int_aarch64_sve_brkb_z>;
  defm BRKB_PPmP  : sve_int_break_m<0b100001, "brkb",  int_aarch64_sve_brkb>;
  defm BRKBS_PPzP : sve_int_break_z<0b110000, "brkbs", null_frag>;

  defm BRKN_PPzP  : sve_int_brkn<0b0000000, "brkn",  int_aarch64_sve_brkn_z>;
  defm BRKNS_PPzP : sve_int_brkn<0b0100000, "brkns", null_frag>;

  defm BRKPA_PPzPP  : sve_int_brkp<0b0000, "brkpa",  int_aarch64_sve_brkpa_z>;
  defm BRKPAS_PPzPP : sve_int_brkp<0b0100, "brkpas", null_frag>;
  defm BRKPB_PPzPP  : sve_int_brkp<0b0001, "brkpb",  int_aarch64_sve_brkpb_z>;
  defm BRKPBS_PPzPP : sve_int_brkp<0b0101, "brkpbs", null_frag>;

  defm AND_PPzPP   : sve_int_pred_log<0b0000, "and",  int_aarch64_sve_and_z>;
  defm BIC_PPzPP   : sve_int_pred_log<0b0001, "bic",  int_aarch64_sve_bic_z>;
  defm EOR_PPzPP   : sve_int_pred_log<0b0010, "eor",  int_aarch64_sve_eor_z>;
  defm SEL_PPPP    : sve_int_pred_log<0b0011, "sel",  vselect>;
  defm ANDS_PPzPP  : sve_int_pred_log<0b0100, "ands">;
  defm BICS_PPzPP  : sve_int_pred_log<0b0101, "bics">;
  defm EORS_PPzPP  : sve_int_pred_log<0b0110, "eors">;
  defm ORR_PPzPP   : sve_int_pred_log<0b1000, "orr",  int_aarch64_sve_orr_z>;
  defm ORN_PPzPP   : sve_int_pred_log<0b1001, "orn",  int_aarch64_sve_orn_z>;
  defm NOR_PPzPP   : sve_int_pred_log<0b1010, "nor",  int_aarch64_sve_nor_z>;
  defm NAND_PPzPP  : sve_int_pred_log<0b1011, "nand", int_aarch64_sve_nand_z>;
  defm ORRS_PPzPP  : sve_int_pred_log<0b1100, "orrs">;
  defm ORNS_PPzPP  : sve_int_pred_log<0b1101, "orns">;
  defm NORS_PPzPP  : sve_int_pred_log<0b1110, "nors">;
  defm NANDS_PPzPP : sve_int_pred_log<0b1111, "nands">;

  multiclass unpred_from_pred_one_op<SDNode N, string I> {
  def : Pat<(nxv16i8 (N (nxv16i8 ZPR:$Zs))),
            (!cast<Instruction>(I # "_B") (IMPLICIT_DEF), (PTRUE_B 31), ZPR:$Zs)>;
  def : Pat<(nxv8i16 (N (nxv8i16 ZPR:$Zs))),
            (!cast<Instruction>(I # "_H") (IMPLICIT_DEF), (PTRUE_H 31), ZPR:$Zs)>;
  def : Pat<(nxv4i32 (N (nxv4i32 ZPR:$Zs))),
            (!cast<Instruction>(I # "_S") (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (N (nxv2i64 ZPR:$Zs))),
            (!cast<Instruction>(I # "_D") (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  }
  defm CLS_ZPmZ  : sve_int_un_pred_arit_1<   0b000, "cls",  int_aarch64_sve_cls>;
  defm CLZ_ZPmZ  : sve_int_un_pred_arit_1<   0b001, "clz",  int_aarch64_sve_clz>;
  defm CNT_ZPmZ  : sve_int_un_pred_arit_1<   0b010, "cnt",  int_aarch64_sve_cnt>;
  defm CNOT_ZPmZ : sve_int_un_pred_arit_1<   0b011, "cnot", int_aarch64_sve_cnot>;
  defm NOT_ZPmZ  : sve_int_un_pred_arit_1<   0b110, "not",  int_aarch64_sve_not>;
  defm FABS_ZPmZ : sve_int_un_pred_arit_1_fp<0b100, "fabs", int_aarch64_sve_abs>;
  defm FNEG_ZPmZ : sve_int_un_pred_arit_1_fp<0b101, "fneg", int_aarch64_sve_neg>;

  defm : unpred_from_pred_one_op<ctpop,   "CNT_ZPmZ">;
  def : SVE_3_Op_Pat<nxv8i16, int_aarch64_sve_cnt, nxv8i16, nxv8i1, nxv8f16, CNT_ZPmZ_H>;
  def : SVE_3_Op_Pat<nxv4i32, int_aarch64_sve_cnt, nxv4i32, nxv4i1, nxv4f32, CNT_ZPmZ_S>;
  def : SVE_3_Op_Pat<nxv2i64, int_aarch64_sve_cnt, nxv2i64, nxv2i1, nxv2f64, CNT_ZPmZ_D>;

  defm FRINTN_ZPmZ : sve_fp_2op_p_zd_SD<0b00000, "frintn", int_aarch64_sve_rintn>;
  defm FRINTP_ZPmZ : sve_fp_2op_p_zd_SD<0b00001, "frintp", int_aarch64_sve_rintp>;
  defm FRINTM_ZPmZ : sve_fp_2op_p_zd_SD<0b00010, "frintm", int_aarch64_sve_rintm>;
  defm FRINTZ_ZPmZ : sve_fp_2op_p_zd_SD<0b00011, "frintz", int_aarch64_sve_rintz>;
  defm FRINTA_ZPmZ : sve_fp_2op_p_zd_SD<0b00100, "frinta", int_aarch64_sve_rinta>;
  defm FRINTX_ZPmZ : sve_fp_2op_p_zd_SD<0b00110, "frintx", int_aarch64_sve_rintx>;
  defm FRINTI_ZPmZ : sve_fp_2op_p_zd_SD<0b00111, "frinti", int_aarch64_sve_rinti>;
  defm FRECPX_ZPmZ : sve_fp_2op_p_zd_SD<0b01100, "frecpx", int_aarch64_sve_recpx>;
  defm FSQRT_ZPmZ  : sve_fp_2op_p_zd_SD<0b01101, "fsqrt",  int_aarch64_sve_sqrt>;

  defm FCVT_ZPmZ_StoH   : sve_fp_2op_p_zd<0b001000, "fcvt",   ".s", ".h", int_aarch64_sve_fcvt_f16f32,    nxv8f16, nxv16i1, nxv4f32>;
  defm FCVT_ZPmZ_HtoS   : sve_fp_2op_p_zd<0b001001, "fcvt",   ".h", ".s", int_aarch64_sve_fcvt_f32f16,    nxv4f32, nxv16i1, nxv8f16>;
  defm SCVTF_ZPmZ_StoS  : sve_fp_2op_p_zd<0b010100, "scvtf",  ".s", ".s", int_aarch64_sve_scvtf,          nxv4f32, nxv4i1,  nxv4i32>;
  defm UCVTF_ZPmZ_StoS  : sve_fp_2op_p_zd<0b010101, "ucvtf",  ".s", ".s", int_aarch64_sve_ucvtf,          nxv4f32, nxv4i1,  nxv4i32>;
  defm FCVTZS_ZPmZ_StoS : sve_fp_2op_p_zd<0b011100, "fcvtzs", ".s", ".s", int_aarch64_sve_fcvtzs,         nxv4i32, nxv4i1,  nxv4f32>;
  defm FCVTZU_ZPmZ_StoS : sve_fp_2op_p_zd<0b011101, "fcvtzu", ".s", ".s", int_aarch64_sve_fcvtzu,         nxv4i32, nxv4i1,  nxv4f32>;
  defm FCVT_ZPmZ_DtoH   : sve_fp_2op_p_zd<0b101000, "fcvt",   ".d", ".h", int_aarch64_sve_fcvt_f16f64,    nxv8f16, nxv16i1, nxv2f64>;
  defm FCVT_ZPmZ_HtoD   : sve_fp_2op_p_zd<0b101001, "fcvt",   ".h", ".d", int_aarch64_sve_fcvt_f64f16,    nxv2f64, nxv16i1, nxv8f16>;
  defm FCVT_ZPmZ_DtoS   : sve_fp_2op_p_zd<0b101010, "fcvt",   ".d", ".s", int_aarch64_sve_fcvt_f32f64,    nxv4f32, nxv16i1, nxv2f64>;
  defm FCVT_ZPmZ_StoD   : sve_fp_2op_p_zd<0b101011, "fcvt",   ".s", ".d", int_aarch64_sve_fcvt_f64f32,    nxv2f64, nxv16i1, nxv4f32>;
  defm SCVTF_ZPmZ_StoD  : sve_fp_2op_p_zd<0b110000, "scvtf",  ".s", ".d", int_aarch64_sve_scvtf_f64i32,   nxv2f64, nxv16i1, nxv4i32>;
  defm UCVTF_ZPmZ_StoD  : sve_fp_2op_p_zd<0b110001, "ucvtf",  ".s", ".d", int_aarch64_sve_ucvtf_f64i32,   nxv2f64, nxv16i1, nxv4i32>;
  defm SCVTF_ZPmZ_DtoS  : sve_fp_2op_p_zd<0b110100, "scvtf",  ".d", ".s", int_aarch64_sve_scvtf_f32i64,   nxv4f32, nxv16i1, nxv2i64>;
  defm UCVTF_ZPmZ_DtoS  : sve_fp_2op_p_zd<0b110101, "ucvtf",  ".d", ".s", int_aarch64_sve_ucvtf_f32i64,   nxv4f32, nxv16i1, nxv2i64>;
  defm SCVTF_ZPmZ_DtoD  : sve_fp_2op_p_zd<0b110110, "scvtf",  ".d", ".d", int_aarch64_sve_scvtf,          nxv2f64, nxv2i1,  nxv2i64>;
  defm UCVTF_ZPmZ_DtoD  : sve_fp_2op_p_zd<0b110111, "ucvtf",  ".d", ".d", int_aarch64_sve_ucvtf,          nxv2f64, nxv2i1,  nxv2i64>;
  defm FCVTZS_ZPmZ_DtoS : sve_fp_2op_p_zd<0b111000, "fcvtzs", ".d", ".s", int_aarch64_sve_fcvtzs_i32f64,  nxv4i32, nxv16i1, nxv2f64>;
  defm FCVTZU_ZPmZ_DtoS : sve_fp_2op_p_zd<0b111001, "fcvtzu", ".d", ".s", int_aarch64_sve_fcvtzu_i32f64,  nxv4i32, nxv16i1, nxv2f64>;
  defm FCVTZS_ZPmZ_StoD : sve_fp_2op_p_zd<0b111100, "fcvtzs", ".s", ".d", int_aarch64_sve_fcvtzs_i64f32,  nxv2i64, nxv16i1, nxv4f32>;
  defm FCVTZU_ZPmZ_StoD : sve_fp_2op_p_zd<0b111101, "fcvtzu", ".s", ".d", int_aarch64_sve_fcvtzu_i64f32,  nxv2i64, nxv16i1, nxv4f32>;
  defm FCVTZS_ZPmZ_DtoD : sve_fp_2op_p_zd<0b111110, "fcvtzs", ".d", ".d", int_aarch64_sve_fcvtzs,         nxv2i64, nxv2i1,  nxv2f64>;
  defm FCVTZU_ZPmZ_DtoD : sve_fp_2op_p_zd<0b111111, "fcvtzu", ".d", ".d", int_aarch64_sve_fcvtzu,         nxv2i64, nxv2i1,  nxv2f64>;

  defm FADD_ZZZ    : sve_fp_3op_u_zd<0b000, "fadd", fadd>;
  defm FSUB_ZZZ    : sve_fp_3op_u_zd<0b001, "fsub", fsub>;
  defm FMUL_ZZZ    : sve_fp_3op_u_zd<0b010, "fmul", fmul>;
  defm FTSMUL_ZZZ  : sve_fp_3op_u_zd_ftsmul<0b011, "ftsmul", int_aarch64_sve_tsmul>;
  defm FRECPS_ZZZ  : sve_fp_3op_u_zd<0b110, "frecps", int_aarch64_sve_recps>;
  defm FRSQRTS_ZZZ : sve_fp_3op_u_zd<0b111, "frsqrts", int_aarch64_sve_rsqrts>;

  defm FMLA_ZPmZZ  : sve_fp_3op_p_zds_a<0b00, "fmla",  int_aarch64_sve_mla>;
  defm FMLS_ZPmZZ  : sve_fp_3op_p_zds_a<0b01, "fmls",  int_aarch64_sve_mls>;
  defm FNMLA_ZPmZZ : sve_fp_3op_p_zds_a<0b10, "fnmla", int_aarch64_sve_nmla>;
  defm FNMLS_ZPmZZ : sve_fp_3op_p_zds_a<0b11, "fnmls", int_aarch64_sve_nmls>;

  defm FMAD_ZPmZZ  : sve_fp_3op_p_zds_b<0b00, "fmad",  int_aarch64_sve_mad>;
  defm FMSB_ZPmZZ  : sve_fp_3op_p_zds_b<0b01, "fmsb",  int_aarch64_sve_msb>;
  defm FNMAD_ZPmZZ : sve_fp_3op_p_zds_b<0b10, "fnmad", int_aarch64_sve_nmad>;
  defm FNMSB_ZPmZZ : sve_fp_3op_p_zds_b<0b11, "fnmsb", int_aarch64_sve_nmsb>;

  defm FADD_ZPmI    : sve_fp_2op_i_p_zds<0b000, "fadd", sve_fpimm_half_one>;
  defm FSUB_ZPmI    : sve_fp_2op_i_p_zds<0b001, "fsub", sve_fpimm_half_one>;
  defm FMUL_ZPmI    : sve_fp_2op_i_p_zds<0b010, "fmul", sve_fpimm_half_two>;
  defm FSUBR_ZPmI   : sve_fp_2op_i_p_zds<0b011, "fsubr", sve_fpimm_half_one>;
  defm FMAXNM_ZPmI  : sve_fp_2op_i_p_zds<0b100, "fmaxnm", sve_fpimm_zero_one>;
  defm FMINNM_ZPmI  : sve_fp_2op_i_p_zds<0b101, "fminnm", sve_fpimm_zero_one>;
  defm FMAX_ZPmI    : sve_fp_2op_i_p_zds<0b110, "fmax", sve_fpimm_zero_one>;
  defm FMIN_ZPmI    : sve_fp_2op_i_p_zds<0b111, "fmin", sve_fpimm_zero_one>;

  defm FADD_ZPmZ   : sve_fp_2op_p_zds<0b0000, "fadd",   int_aarch64_sve_add>;
  defm FSUB_ZPmZ   : sve_fp_2op_p_zds<0b0001, "fsub",   int_aarch64_sve_sub>;
  defm FMUL_ZPmZ   : sve_fp_2op_p_zds<0b0010, "fmul",   int_aarch64_sve_mul>;
  defm FSUBR_ZPmZ  : sve_fp_2op_p_zds<0b0011, "fsubr",  int_aarch64_sve_subr>;
  defm FMAXNM_ZPmZ : sve_fp_2op_p_zds<0b0100, "fmaxnm", AArch64fmaxnm_pred>;
  defm FMINNM_ZPmZ : sve_fp_2op_p_zds<0b0101, "fminnm", AArch64fminnm_pred>;
  defm FMAX_ZPmZ   : sve_fp_2op_p_zds<0b0110, "fmax",   AArch64fmax_pred>;
  defm FMIN_ZPmZ   : sve_fp_2op_p_zds<0b0111, "fmin",   AArch64fmin_pred>;
  defm FABD_ZPmZ   : sve_fp_2op_p_zds<0b1000, "fabd",   int_aarch64_sve_abd>;
  defm FSCALE_ZPmZ : sve_fp_2op_p_zds_fscale<0b1001, "fscale", int_aarch64_sve_scale>;
  defm FMULX_ZPmZ  : sve_fp_2op_p_zds<0b1010, "fmulx",  int_aarch64_sve_mulx>;
  defm FDIVR_ZPmZ  : sve_fp_2op_p_zds<0b1100, "fdivr",  int_aarch64_sve_divr>;
  defm FDIV_ZPmZ   : sve_fp_2op_p_zds<0b1101, "fdiv",   int_aarch64_sve_div>;

  let hasNoSchedulingInfo = 1 in {
    class PredSelZeroOpPseudo
    : Pseudo<(outs ZPROp:$Zd), (ins PPRROp:$Pg, ZPROp:$Zs1, ZPROp:$Zs2), []>;
  }

  multiclass selzero {
    def _B : PredSelZeroOpPseudo;
    def _H : PredSelZeroOpPseudo;
    def _S : PredSelZeroOpPseudo;
    def _D : PredSelZeroOpPseudo;

    def : Pat<(vselect nxv16i1:$Op1, nxv16i8:$Op2, (nxv16i8 (AArch64dup (i32 0)))),
              (!cast<Pseudo>(NAME # "_B") $Op1, $Op2, (DUP_ZI_B 0, 0))>;
    def : Pat<(vselect nxv8i1:$Op1, nxv8i16:$Op2, (nxv8i16 (AArch64dup (i32 0)))),
              (!cast<Pseudo>(NAME # "_H") $Op1, $Op2, (DUP_ZI_H 0, 0))>;
    def : Pat<(vselect nxv4i1:$Op1, nxv4i32:$Op2, (nxv4i32 (AArch64dup (i32 0)))),
              (!cast<Pseudo>(NAME # "_S") $Op1, $Op2, (DUP_ZI_S 0, 0))>;
    def : Pat<(vselect nxv2i1:$Op1, nxv2i64:$Op2, (nxv2i64 (AArch64dup (i64 0)))),
              (!cast<Pseudo>(NAME # "_D") $Op1, $Op2, (DUP_ZI_D 0, 0))>;
    def : Pat<(vselect nxv8i1:$Op1, nxv8f16:$Op2, (nxv8f16 (AArch64dup (f16 fpimm0)))),
              (!cast<Pseudo>(NAME # "_H") $Op1, $Op2, (DUP_ZI_H 0, 0))>;
    def : Pat<(vselect nxv4i1:$Op1, nxv4f32:$Op2, (nxv4f32 (AArch64dup (f32 fpimm0)))),
              (!cast<Pseudo>(NAME # "_S") $Op1, $Op2, (DUP_ZI_S 0, 0))>;
    def : Pat<(vselect nxv2i1:$Op1, nxv2f64:$Op2, (nxv2f64 (AArch64dup (f64 fpimm0)))),
              (!cast<Pseudo>(NAME # "_D") $Op1, $Op2, (DUP_ZI_D 0, 0))>;
  }

  defm SELZERO : selzero;

  multiclass unpred_from_pred_2op_destructive_fp<SDNode N, string I> {
    def : Pat<(nxv2f32 (N (nxv2f32 ZPR:$Zs1), (nxv2f32 ZPR:$Zs2))),
              (!cast<Instruction>(I # "_S") (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;
    def : Pat<(nxv4f32 (N (nxv4f32 ZPR:$Zs1), (nxv4f32 ZPR:$Zs2))),
              (!cast<Instruction>(I # "_S") (PTRUE_S 31), ZPR:$Zs1, ZPR:$Zs2)>;
    def : Pat<(nxv2f64 (N (nxv2f64 ZPR:$Zs1), (nxv2f64 ZPR:$Zs2))),
              (!cast<Instruction>(I # "_D") (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;
  }

  defm : unpred_from_pred_2op_destructive_fp<fdiv, "FDIV_ZPmZZ">;

  def FMLA_ZPZZZ_S  : PredThreeOpPseudo;
  def FMLA_ZPZZZ_D  : PredThreeOpPseudo;
  def FMLS_ZPZZZ_S  : PredThreeOpPseudo;
  def FMLS_ZPZZZ_D  : PredThreeOpPseudo;
  def FNMLA_ZPZZZ_S : PredThreeOpPseudo;
  def FNMLA_ZPZZZ_D : PredThreeOpPseudo;
  def FNMLS_ZPZZZ_S : PredThreeOpPseudo;
  def FNMLS_ZPZZZ_D : PredThreeOpPseudo;

  defm FTMAD_ZZI : sve_fp_ftmad<"ftmad", int_aarch64_sve_tmad>;

  defm MOVPRFX_ZPzZ : sve_int_movprfx_pred<0b000, "movprfx", "/z">;
  defm MOVPRFX_ZPmZ : sve_int_movprfx_pred<0b001, "movprfx", "/m">;

  defm FTSSEL_ZZZ : sve_int_bin_cons_misc_0_b<0b10, "ftssel", int_aarch64_sve_tssel>;

  def MOVPRFX_ZZ : sve_int_bin_cons_misc_0_c<0b00000001, "movprfx", "">;
  def FEXPA_ZZ_S : sve_int_bin_cons_misc_0_c<0b10000000, "fexpa", ".s">;
  def FEXPA_ZZ_D : sve_int_bin_cons_misc_0_c<0b11000000, "fexpa", ".d">;
  def : SVE_1_Op_Pat<nxv4f32, int_aarch64_sve_expa, nxv4i32, FEXPA_ZZ_S>;
  def : SVE_1_Op_Pat<nxv2f64, int_aarch64_sve_expa, nxv2i64, FEXPA_ZZ_D>;

  defm FRECPE_ZZ  : sve_fp_2op_u_zd<0b110, "frecpe", int_aarch64_sve_recpe>;
  defm FRSQRTE_ZZ : sve_fp_2op_u_zd<0b111, "frsqrte", int_aarch64_sve_rsqrte>;

  multiclass unpred_from_pred_one_op_fp<SDNode N, string I> {
  def : Pat<(nxv2f32 (N (nxv2f32 ZPR:$Zs))),
            (!cast<Instruction>(I # "_S") (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv4f32 (N (nxv4f32 ZPR:$Zs))),
            (!cast<Instruction>(I # "_S") (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (N (nxv2f64 ZPR:$Zs))),
            (!cast<Instruction>(I # "_D") (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  }
  defm : unpred_from_pred_one_op_fp<fabs,   "FABS_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<fceil,  "FRINTP_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<ffloor, "FRINTM_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<ftrunc, "FRINTZ_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<fneg,   "FNEG_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<frint,  "FRINTX_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<fsqrt,  "FSQRT_ZPmZ">;

  // Use the standard packed operations on our unpacked types
  // TODO: if/when we care about FP exceptions these must use predication
  def : Pat<(nxv2f32 (fadd (nxv2f32 ZPR:$Zs1), (nxv2f32 ZPR:$Zs2))),
            (FADD_ZZZ_S ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f32 (fsub (nxv2f32 ZPR:$Zs1), (nxv2f32 ZPR:$Zs2))),
            (FSUB_ZZZ_S ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f32 (fmul (nxv2f32 ZPR:$Zs1), (nxv2f32 ZPR:$Zs2))),
            (FMUL_ZZZ_S ZPR:$Zs1, ZPR:$Zs2)>;

  // Zd = Za + Zn * Zm
  def : Pat<(nxv4f32 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)),
            (FMLA_ZPZZZ_S (PTRUE_S 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f32 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)),
            (FMLA_ZPZZZ_S (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f64 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)),
            (FMLA_ZPZZZ_D (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zd = Za + -Zn * Zm
  def : Pat<(nxv4f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)),
            (FMLS_ZPZZZ_S (PTRUE_S 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)),
            (FMLS_ZPZZZ_S (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f64 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)),
            (FMLS_ZPZZZ_D (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zd = -Za + Zn * Zm
  def : Pat<(nxv4f32 (fma ZPR:$Zn, ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLS_ZPZZZ_S (PTRUE_S 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f32 (fma ZPR:$Zn, ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLS_ZPZZZ_S (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f64 (fma ZPR:$Zn, ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLS_ZPZZZ_D (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zd = -Za + -Zn * Zm
  def : Pat<(nxv4f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLA_ZPZZZ_S (PTRUE_S 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLA_ZPZZZ_S (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f64 (fma (fneg ZPR:$Zn), ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLA_ZPZZZ_D (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zda = Zda + Zn * Zm
  def : Pat<(vselect (nxv4i1 PPR:$Pg), (nxv4f32 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLA_ZPmZZ_S PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(vselect (nxv2i1 PPR:$Pg), (nxv2f32 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLA_ZPmZZ_S PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(vselect (nxv2i1 PPR:$Pg), (nxv2f64 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLA_ZPmZZ_D PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zda = Zda + -Zn * Zm
  def : Pat<(vselect (nxv4i1 PPR:$Pg), (nxv4f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLS_ZPmZZ_S PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(vselect (nxv2i1 PPR:$Pg), (nxv2f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLS_ZPmZZ_S PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(vselect (nxv2i1 PPR:$Pg), (nxv2f64 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLS_ZPmZZ_D PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // as above but with the resulting compare operands switched
  multiclass SVEInvCmpPat<CondCode IN_CMP, string OUT_CMP > {
    def : Pat<(nxv16i8 (setcc (nxv16i8 ZPR:$Zs1), (nxv16i8 ZPR:$Zs2), IN_CMP)),
              (CPY_ZPzI_B (!cast<Instruction>(!strconcat(OUT_CMP, "_B"))
                          (PTRUE_B 31), ZPR:$Zs2, ZPR:$Zs1), -1, 0)>;

    def : Pat<(nxv8i16 (setcc (nxv8i16 ZPR:$Zs1), (nxv8i16 ZPR:$Zs2), IN_CMP)),
              (CPY_ZPzI_H (!cast<Instruction>(!strconcat(OUT_CMP, "_H"))
                          (PTRUE_H 31), ZPR:$Zs2, ZPR:$Zs1), -1, 0)>;

    def : Pat<(nxv4i32 (setcc (nxv4i32 ZPR:$Zs1), (nxv4i32 ZPR:$Zs2), IN_CMP)),
              (CPY_ZPzI_S (!cast<Instruction>(!strconcat(OUT_CMP, "_S"))
                          (PTRUE_S 31), ZPR:$Zs2, ZPR:$Zs1), -1, 0)>;

    def : Pat<(nxv2i64 (setcc (nxv2i64 ZPR:$Zs1), (nxv2i64 ZPR:$Zs2), IN_CMP)),
              (CPY_ZPzI_D (!cast<Instruction>(!strconcat(OUT_CMP, "_D"))
                          (PTRUE_D 31), ZPR:$Zs2, ZPR:$Zs1), -1, 0)>;

    def : Pat<(nxv16i1 (setcc (nxv16i8 ZPR:$Zs1), (nxv16i8 ZPR:$Zs2), IN_CMP)),
              (!cast<Instruction>(!strconcat(OUT_CMP, "_B"))
               (PTRUE_B 31), ZPR:$Zs2, ZPR:$Zs1)>;

    def : Pat<(nxv8i1 (setcc (nxv8i16 ZPR:$Zs1), (nxv8i16 ZPR:$Zs2), IN_CMP)),
              (!cast<Instruction>(!strconcat(OUT_CMP, "_H"))
               (PTRUE_H 31), ZPR:$Zs2, ZPR:$Zs1)>;

    def : Pat<(nxv4i1 (setcc (nxv4i32 ZPR:$Zs1), (nxv4i32 ZPR:$Zs2), IN_CMP)),
              (!cast<Instruction>(!strconcat(OUT_CMP, "_S"))
               (PTRUE_S 31), ZPR:$Zs2, ZPR:$Zs1)>;

    def : Pat<(nxv2i1 (setcc (nxv2i64 ZPR:$Zs1), (nxv2i64 ZPR:$Zs2), IN_CMP)),
              (!cast<Instruction>(!strconcat(OUT_CMP, "_D"))
               (PTRUE_D 31), ZPR:$Zs2, ZPR:$Zs1)>;
  }

  // FUTURE: find out why this happens and stop it?
  def : Pat<(nxv16i8 (vselect (nxv16i8 ZPR:$P), ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_B (CMPNE_PPzZI_B (PTRUE_B 31), ZPR:$P, 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv8i16 (vselect (nxv8i16 ZPR:$P), ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_H (CMPNE_PPzZI_H (PTRUE_H 31), ZPR:$P, 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv4i32 (vselect (nxv4i32 ZPR:$P), ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), ZPR:$P, 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i64 (vselect (nxv2i64 ZPR:$P), ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_D (CMPNE_PPzZI_D (PTRUE_D 31), ZPR:$P, 0), ZPR:$Zs1, ZPR:$Zs2)>;

  // Whole vector selects.
  def : Pat<(nxv16i8 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv8i16 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv4i32 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i64 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f32 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv4f32 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f64 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv16i1 (select GPR32:$cond, PPR:$Ps1, PPR:$Ps2)),
            (SEL_PPPP (CMPNE_PPzZI_B (PTRUE_B 31), (DUP_ZR_B $cond), 0), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv8i1 (select GPR32:$cond, PPR:$Ps1, PPR:$Ps2)),
            (SEL_PPPP (CMPNE_PPzZI_B (PTRUE_B 31), (DUP_ZR_B $cond), 0), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv4i1 (select GPR32:$cond, PPR:$Ps1, PPR:$Ps2)),
            (SEL_PPPP (CMPNE_PPzZI_B (PTRUE_B 31), (DUP_ZR_B $cond), 0), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv2i1 (select GPR32:$cond, PPR:$Ps1, PPR:$Ps2)),
            (SEL_PPPP (CMPNE_PPzZI_B (PTRUE_B 31), (DUP_ZR_B $cond), 0), PPR:$Ps1, PPR:$Ps2)>;

  // Extract element from vector with immediate index
  def : Pat<(i32 (vector_extract (nxv16i8 ZPR:$vec), sve_elm_idx_b:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_B ZPR:$vec, sve_elm_idx_b:$index), ssub)>;
  def : Pat<(i32 (vector_extract (nxv8i16 ZPR:$vec), sve_elm_idx_h:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_H ZPR:$vec, sve_elm_idx_h:$index), ssub)>;
  def : Pat<(i32 (vector_extract (nxv4i32 ZPR:$vec), sve_elm_idx_s:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_S ZPR:$vec, sve_elm_idx_s:$index), ssub)>;
  def : Pat<(i64 (vector_extract (nxv2i64 ZPR:$vec), sve_elm_idx_d:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_D ZPR:$vec, sve_elm_idx_d:$index), dsub)>;
  def : Pat<(f32 (vector_extract (nxv4f32 ZPR:$vec), sve_elm_idx_s:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_S ZPR:$vec, sve_elm_idx_s:$index), ssub)>;
  def : Pat<(f64 (vector_extract (nxv2f64 ZPR:$vec), sve_elm_idx_d:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_D ZPR:$vec, sve_elm_idx_d:$index), dsub)>;

  // Extract element from vector with scalar index
  def : Pat<(i32 (vector_extract (nxv16i8 ZPR:$vec), GPR64:$index)),
            (LASTB_RPZ_B (CMPEQ_PPzZZ_B (PTRUE_B 31),
                                        (INDEX_II_B 0, 1),
                                        (DUP_ZR_B (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                         ZPR:$vec)>;
  def : Pat<(i32 (vector_extract (nxv8i16 ZPR:$vec), GPR64:$index)),
            (LASTB_RPZ_H (CMPEQ_PPzZZ_H (PTRUE_H 31),
                                        (INDEX_II_H 0, 1),
                                        (DUP_ZR_H (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                         ZPR:$vec)>;
  def : Pat<(i32 (vector_extract (nxv4i32 ZPR:$vec), GPR64:$index)),
            (LASTB_RPZ_S (CMPEQ_PPzZZ_S (PTRUE_S 31),
                                        (INDEX_II_S 0, 1),
                                        (DUP_ZR_S (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                         ZPR:$vec)>;
  def : Pat<(i64 (vector_extract (nxv2i64 ZPR:$vec), GPR64:$index)),
            (LASTB_RPZ_D (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                        (INDEX_II_D 0, 1),
                                        (DUP_ZR_D GPR64:$index)),
                         ZPR:$vec)>;

  def : Pat<(f32 (vector_extract (nxv4f32 ZPR:$vec), GPR64:$index)),
            (LASTB_VPZ_S (CMPEQ_PPzZZ_S (PTRUE_S 31),
                                        (INDEX_II_S 0, 1),
                                        (DUP_ZR_S (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                         ZPR:$vec)>;
  def : Pat<(f64 (vector_extract (nxv2f64 ZPR:$vec), GPR64:$index)),
            (LASTB_VPZ_D (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                        (INDEX_II_D 0, 1),
                                        (DUP_ZR_D $index)),
                         ZPR:$vec)>;
  def : Pat<(f32 (vector_extract (nxv2f32 ZPR:$vec), GPR64:$index)),
            (LASTB_VPZ_S (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                        (INDEX_II_D 0, 1),
                                        (DUP_ZR_D $index)),
                         ZPR:$vec)>;

  defm ASR_ZZI : sve_int_bin_cons_shift_b_right<0b00, "asr", sra>;
  defm LSR_ZZI : sve_int_bin_cons_shift_b_right<0b01, "lsr", srl>;
  defm LSL_ZZI : sve_int_bin_cons_shift_b_left< 0b11, "lsl", shl>;

  // Shift by immediate patterns. Allowed immediate range is different for right
  // vs. left shifts, so the patterns have to be different.
  def : Pat<(nxv16i8 (shl (nxv16i8 ZPR:$Zs1),
                          (nxv16i8 (AArch64dup (vecshiftL8:$imm))))),
            (LSL_ZZI_B ZPR:$Zs1, vecshiftL8:$imm)>;
  def : Pat<(nxv8i16 (shl (nxv8i16 ZPR:$Zs1),
                          (nxv8i16 (AArch64dup (vecshiftL16:$imm))))),
            (LSL_ZZI_H ZPR:$Zs1, vecshiftL16:$imm)>;
  def : Pat<(nxv4i32 (shl (nxv4i32 ZPR:$Zs1),
                          (nxv4i32 (AArch64dup (vecshiftL32:$imm))))),
            (LSL_ZZI_S ZPR:$Zs1, vecshiftL32:$imm)>;
  def : Pat<(nxv2i64 (shl (nxv2i64 ZPR:$Zs1),
                          (nxv2i64 (AArch64dup (i64 (SVELShiftImm64 i32:$imm)))))),
            (LSL_ZZI_D ZPR:$Zs1, vecshiftL64:$imm)>;

  def : Pat<(nxv16i8 (int_aarch64_sve_lsl (nxv16i1 PPRR:$Pg),
                                          (nxv16i8 ZPR:$Zs1),
                                          (nxv16i8 (AArch64dup (vecshiftL8:$imm))))),
            (LSL_ZPmI_B PPRR:$Pg, ZPR:$Zs1, vecshiftL8:$imm)>;
  def : Pat<(nxv8i16 (int_aarch64_sve_lsl (nxv8i1 PPRR:$Pg),
                                          (nxv8i16 ZPR:$Zs1),
                                          (nxv8i16 (AArch64dup (vecshiftL16:$imm))))),
            (LSL_ZPmI_H PPRR:$Pg, ZPR:$Zs1, vecshiftL16:$imm)>;
  def : Pat<(nxv4i32 (int_aarch64_sve_lsl (nxv4i1 PPRR:$Pg),
                                          (nxv4i32 ZPR:$Zs1),
                                          (nxv4i32 (AArch64dup (vecshiftL32:$imm))))),
            (LSL_ZPmI_S PPRR:$Pg, ZPR:$Zs1, vecshiftL32:$imm)>;
  def : Pat<(nxv2i64 (int_aarch64_sve_lsl (nxv2i1 PPRR:$Pg),
                                          (nxv2i64 ZPR:$Zs1),
                                          (nxv2i64 (AArch64dup (i64 (SVELShiftImm64 i32:$imm)))))),
            (LSL_ZPmI_D PPRR:$Pg, ZPR:$Zs1, vecshiftL64:$imm)>;

  // Wide shifts
  def : Pat<(nxv16i8 (int_aarch64_sve_lsl_wide (nxv16i1 PPRR:$Pg),
                                               (nxv16i8 ZPR:$Zs1),
                                               (nxv2i64 (AArch64dup (i64 (SVEWideLShiftImm8 i32:$imm)))))),
            (LSL_ZPmI_B PPRR:$Pg, ZPR:$Zs1, vecshiftL8:$imm)>;
  def : Pat<(nxv8i16 (int_aarch64_sve_lsl_wide (nxv8i1 PPRR:$Pg),
                                               (nxv8i16 ZPR:$Zs1),
                                               (nxv2i64 (AArch64dup (i64 (SVEWideLShiftImm16 i32:$imm)))))),
            (LSL_ZPmI_H PPRR:$Pg, ZPR:$Zs1, vecshiftL16:$imm)>;
  def : Pat<(nxv4i32 (int_aarch64_sve_lsl_wide (nxv4i1 PPRR:$Pg),
                                               (nxv4i32 ZPR:$Zs1),
                                               (nxv2i64 (AArch64dup (i64 (SVEWideLShiftImm32 i32:$imm)))))),
            (LSL_ZPmI_S PPRR:$Pg, ZPR:$Zs1, vecshiftL32:$imm)>;

  multiclass sve_unpred_rshift_immediates<string ir_inst, string int_inst,
                                          SDPatternOperator ir_op,
                                          SDPatternOperator int_op,
                                          SDPatternOperator wide_op> {
    def : Pat<(nxv16i8 (ir_op (nxv16i8 ZPR:$Zs1),
                              (nxv16i8 (AArch64dup (vecshiftR8:$imm))))),
              (!cast<Instruction>(ir_inst # "_B") ZPR:$Zs1, vecshiftR8:$imm)>;
    def : Pat<(nxv8i16 (ir_op (nxv8i16 ZPR:$Zs1),
                              (nxv8i16 (AArch64dup (vecshiftR16:$imm))))),
              (!cast<Instruction>(ir_inst # "_H") ZPR:$Zs1, vecshiftR16:$imm)>;
    def : Pat<(nxv4i32 (ir_op (nxv4i32 ZPR:$Zs1),
                              (nxv4i32 (AArch64dup (vecshiftR32:$imm))))),
              (!cast<Instruction>(ir_inst # "_S") ZPR:$Zs1, vecshiftR32:$imm)>;
    def : Pat<(nxv2i64 (ir_op (nxv2i64 ZPR:$Zs1),
                              (nxv2i64 (AArch64dup (i64 (SVERShiftImm64 i32:$imm)))))),
              (!cast<Instruction>(ir_inst # "_D") ZPR:$Zs1, vecshiftR64:$imm)>;

    def : Pat<(nxv16i8 (int_op (nxv16i1 PPRR:$Pg),
                               (nxv16i8 ZPR:$Zs1),
                               (nxv16i8 (AArch64dup (vecshiftR8:$imm))))),
              (!cast<Instruction>(int_inst # "_B") PPRR:$Pg, ZPR:$Zs1, vecshiftR8:$imm)>;
    def : Pat<(nxv8i16 (int_op (nxv8i1 PPRR:$Pg),
                               (nxv8i16 ZPR:$Zs1),
                               (nxv8i16 (AArch64dup (vecshiftR16:$imm))))),
              (!cast<Instruction>(int_inst # "_H") PPRR:$Pg, ZPR:$Zs1, vecshiftR16:$imm)>;
    def : Pat<(nxv4i32 (int_op (nxv4i1 PPRR:$Pg),
                               (nxv4i32 ZPR:$Zs1),
                               (nxv4i32 (AArch64dup (vecshiftR32:$imm))))),
              (!cast<Instruction>(int_inst # "_S") PPRR:$Pg, ZPR:$Zs1, vecshiftR32:$imm)>;
    def : Pat<(nxv2i64 (int_op (nxv2i1 PPRR:$Pg),
                               (nxv2i64 ZPR:$Zs1),
                               (nxv2i64 (AArch64dup (i64 (SVERShiftImm64 i32:$imm)))))),
              (!cast<Instruction>(int_inst # "_D") PPRR:$Pg, ZPR:$Zs1, vecshiftR64:$imm)>;

    // Wide shifts
    def : Pat<(nxv16i8 (wide_op (nxv16i1 PPRR:$Pg),
                                (nxv16i8 ZPR:$Zs1),
                                (nxv2i64 (AArch64dup (i64 (SVEWideRShiftImm8 i32:$imm)))))),
              (!cast<Instruction>(int_inst # "_B") PPRR:$Pg, ZPR:$Zs1, vecshiftR8:$imm)>;
    def : Pat<(nxv8i16 (wide_op (nxv8i1 PPRR:$Pg),
                                (nxv8i16 ZPR:$Zs1),
                                (nxv2i64 (AArch64dup (i64 (SVEWideRShiftImm16 i32:$imm)))))),
              (!cast<Instruction>(int_inst # "_H") PPRR:$Pg, ZPR:$Zs1, vecshiftR16:$imm)>;
    def : Pat<(nxv4i32 (wide_op (nxv4i1 PPRR:$Pg),
                                (nxv4i32 ZPR:$Zs1),
                                (nxv2i64 (AArch64dup (i64 (SVEWideRShiftImm32 i32:$imm)))))),
              (!cast<Instruction>(int_inst # "_S") PPRR:$Pg, ZPR:$Zs1, vecshiftR32:$imm)>;
  }

  defm : sve_unpred_rshift_immediates<"ASR_ZZI", "ASR_ZPmI", sra, int_aarch64_sve_asr, int_aarch64_sve_asr_wide>;
  defm : sve_unpred_rshift_immediates<"LSR_ZZI", "LSR_ZPmI", srl, int_aarch64_sve_lsr, int_aarch64_sve_lsr_wide>;

  def : Pat<(nxv16i1 (trunc (nxv16i8 ZPR:$Zs))),
            (CMPNE_PPzZI_B (PTRUE_B 31), (LSL_ZZI_B ZPR:$Zs, 7), 0)>;
  def : Pat<(nxv8i1 (trunc (nxv8i16 ZPR:$Zs))),
            (CMPNE_PPzZI_H (PTRUE_H 31), (LSL_ZZI_H ZPR:$Zs, 15), 0)>;
  def : Pat<(nxv4i1 (trunc (nxv4i32 ZPR:$Zs))),
            (CMPNE_PPzZI_S (PTRUE_S 31), (LSL_ZZI_S ZPR:$Zs, 31), 0)>;
  def : Pat<(nxv2i1 (trunc (nxv2i64 ZPR:$Zs))),
            (CMPNE_PPzZI_D (PTRUE_D 31), (LSL_ZZI_D ZPR:$Zs, 63), 0)>;

  def : Pat<(nxv16i1 (and (trunc (nxv16i8 ZPR:$Zs1)), PPR:$Ps2)),
            (CMPNE_PPzZI_B PPR:$Ps2, (LSL_ZZI_B ZPR:$Zs1, 7), 0)>;
  def : Pat<(nxv8i1 (and (trunc (nxv8i16 ZPR:$Zs1)), PPR:$Ps2)),
            (CMPNE_PPzZI_H PPR:$Ps2, (LSL_ZZI_H ZPR:$Zs1, 15), 0)>;
  def : Pat<(nxv4i1 (and (trunc (nxv4i32 ZPR:$Zs1)), PPR:$Ps2)),
            (CMPNE_PPzZI_S PPR:$Ps2, (LSL_ZZI_S ZPR:$Zs1, 31), 0)>;
  def : Pat<(nxv2i1 (and (trunc (nxv2i64 ZPR:$Zs1)), PPR:$Ps2)),
            (CMPNE_PPzZI_D PPR:$Ps2, (LSL_ZZI_D ZPR:$Zs1, 63), 0)>;

  defm : SVEInvCmpPat<SETLE,  "CMPGE_PPzZZ">;
  defm : SVEInvCmpPat<SETLT,  "CMPGT_PPzZZ">;
  defm : SVEInvCmpPat<SETULT, "CMPHI_PPzZZ">;
  defm : SVEInvCmpPat<SETULE, "CMPHS_PPzZZ">;

  // per-element any extend
  def : Pat<(nxv16i8 (anyext (nxv16i1 PPR:$Ps1))),
            (CPY_ZPzI_B PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv8i16 (anyext (nxv8i1 PPR:$Ps1))),
            (CPY_ZPzI_H PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv4i32 (anyext (nxv4i1 PPR:$Ps1))),
            (CPY_ZPzI_S PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv2i64 (anyext (nxv2i1 PPR:$Ps1))),
            (CPY_ZPzI_D PPR:$Ps1, 0x1, 0)>;

  // per-element sign extend
  def : Pat<(nxv16i8 (sext (nxv16i1 PPR:$Ps1))),
            (CPY_ZPzI_B PPR:$Ps1, -1, 0)>;
  def : Pat<(nxv8i16 (sext (nxv8i1 PPR:$Ps1))),
            (CPY_ZPzI_H PPR:$Ps1, -1, 0)>;
  def : Pat<(nxv4i32 (sext (nxv4i1 PPR:$Ps1))),
            (CPY_ZPzI_S PPR:$Ps1, -1, 0)>;
  def : Pat<(nxv2i64 (sext (nxv2i1 PPR:$Ps1))),
            (CPY_ZPzI_D PPR:$Ps1, -1, 0)>;

  // per-element zero extend
  def : Pat<(nxv16i8 (zext (nxv16i1 PPR:$Ps1))),
            (CPY_ZPzI_B PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv8i16 (zext (nxv8i1 PPR:$Ps1))),
            (CPY_ZPzI_H PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv4i32 (zext (nxv4i1 PPR:$Ps1))),
            (CPY_ZPzI_S PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv2i64 (zext (nxv2i1 PPR:$Ps1))),
            (CPY_ZPzI_D PPR:$Ps1, 0x1, 0)>;

  // propff patterns
  def : Pat<(nxv16i1 (prop_first_zero (nxv16i1 PPR:$src1), (nxv16i1 PPR:$src2))),
            (BRKPB_PPzPP (PTRUE_B 31),
                         (BRKB_PPzP (PTRUE_B 31), (NOR_PPzPP (PTRUE_B 31), PPR:$src1, PPR:$src1)),
                         (NOR_PPzPP (PTRUE_B 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv8i1 (prop_first_zero (nxv8i1 PPR:$src1), (nxv8i1 PPR:$src2))),
            (BRKPB_PPzPP (PTRUE_H 31),
                         (BRKB_PPzP (PTRUE_H 31), (NOR_PPzPP (PTRUE_H 31), PPR:$src1, PPR:$src1)),
                         (NOR_PPzPP (PTRUE_H 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv4i1 (prop_first_zero (nxv4i1 PPR:$src1), (nxv4i1 PPR:$src2))),
            (BRKPB_PPzPP (PTRUE_S 31),
                         (BRKB_PPzP (PTRUE_S 31), (NOR_PPzPP (PTRUE_S 31), PPR:$src1, PPR:$src1)),
                         (NOR_PPzPP (PTRUE_S 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv2i1 (prop_first_zero (nxv2i1 PPR:$src1), (nxv2i1 PPR:$src2))),
            (BRKPB_PPzPP (PTRUE_D 31),
                         (BRKB_PPzP (PTRUE_D 31), (NOR_PPzPP (PTRUE_D 31), PPR:$src1, PPR:$src1)),
                         (NOR_PPzPP (PTRUE_D 31), PPR:$src2, PPR:$src2))>;

  // optimized propff
  def : Pat<(nxv16i1 (prop_first_zero (nxv16i1 (AArch64ptrue 31)), (nxv16i1 PPR:$src2))),
            (BRKB_PPzP (PTRUE_B 31), (NOR_PPzPP (PTRUE_B 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv8i1 (prop_first_zero (nxv8i1 (AArch64ptrue 31)), (nxv8i1 PPR:$src2))),
            (BRKB_PPzP (PTRUE_H 31), (NOR_PPzPP (PTRUE_H 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv4i1 (prop_first_zero (nxv4i1 (AArch64ptrue 31)), (nxv4i1 PPR:$src2))),
            (BRKB_PPzP (PTRUE_S 31), (NOR_PPzPP (PTRUE_S 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv2i1 (prop_first_zero (nxv2i1 (AArch64ptrue 31)), (nxv2i1 PPR:$src2))),
            (BRKB_PPzP (PTRUE_D 31), (NOR_PPzPP (PTRUE_D 31), PPR:$src2, PPR:$src2))>;

  // brka
  def : Pat<(nxv16i1 (AArch64brka (nxv16i1 PPR:$Pg), (nxv16i1 PPR:$Src1))),
            (BRKA_PPzP $Pg, $Src1)>;
  def : Pat<(nxv8i1 (AArch64brka (nxv8i1 PPR:$Pg), (nxv8i1 PPR:$Src1))),
            (BRKA_PPzP $Pg, $Src1)>;
  def : Pat<(nxv4i1 (AArch64brka (nxv4i1 PPR:$Pg), (nxv4i1 PPR:$Src1))),
            (BRKA_PPzP $Pg, $Src1)>;
  def : Pat<(nxv2i1 (AArch64brka (nxv2i1 PPR:$Pg), (nxv2i1 PPR:$Src1))),
            (BRKA_PPzP $Pg, $Src1)>;

let AddedComplexity = 1 in {
  def : Pat<(nxv16i1 (prop_first_zero (nxv16i1 PPR:$src1),
                 (nxv16i1 (int_aarch64_sve_whilelo GPR32:$Rs1, GPR32:$Rs2)))),
            (BRKN_PPzP (PTRUE_B 31),
                        (BRKB_PPzP (PTRUE_B 31), (NOR_PPzPP (PTRUE_B 31), PPR:$src1, PPR:$src1)),
                        (WHILELO_PWW_B GPR32:$Rs1, GPR32:$Rs2))>;
  def : Pat<(nxv8i1  (prop_first_zero (nxv8i1 PPR:$src1),
                 (nxv8i1 (int_aarch64_sve_whilelo GPR32:$Rs1, GPR32:$Rs2)))),
            (BRKN_PPzP (PTRUE_H 31),
                       (BRKB_PPzP (PTRUE_H 31), (NOR_PPzPP (PTRUE_H 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PWW_H GPR32:$Rs1, GPR32:$Rs2))>;
  def : Pat<(nxv4i1  (prop_first_zero (nxv4i1 PPR:$src1),
                 (nxv4i1 (int_aarch64_sve_whilelo GPR32:$Rs1, GPR32:$Rs2)))),
            (BRKN_PPzP (PTRUE_S 31),
                       (BRKB_PPzP (PTRUE_S 31), (NOR_PPzPP (PTRUE_S 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PWW_S GPR32:$Rs1, GPR32:$Rs2))>;
  def : Pat<(nxv2i1  (prop_first_zero (nxv2i1 PPR:$src1),
                 (nxv2i1 (int_aarch64_sve_whilelo GPR32:$Rs1, GPR32:$Rs2)))),
            (BRKN_PPzP (PTRUE_D 31),
                       (BRKB_PPzP (PTRUE_D 31), (NOR_PPzPP (PTRUE_D 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PWW_D GPR32:$Rs1, GPR32:$Rs2))>;
  def : Pat<(nxv16i1 (prop_first_zero (nxv16i1 PPR:$src1),
                 (nxv16i1 (int_aarch64_sve_whilelo GPR64:$Rs1, GPR64:$Rs2)))),
            (BRKN_PPzP (PTRUE_B 31),
                       (BRKB_PPzP (PTRUE_B 31), (NOR_PPzPP (PTRUE_B 31), PPR:$src1, PPR:$src1)),
                        (WHILELO_PXX_B GPR64:$Rs1, GPR64:$Rs2))>;
  def : Pat<(nxv8i1  (prop_first_zero (nxv8i1 PPR:$src1),
                 (nxv8i1 (int_aarch64_sve_whilelo GPR64:$Rs1, GPR64:$Rs2)))),
            (BRKN_PPzP (PTRUE_H 31),
                       (BRKB_PPzP (PTRUE_H 31), (NOR_PPzPP (PTRUE_H 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PXX_H GPR64:$Rs1, GPR64:$Rs2))>;
  def : Pat<(nxv4i1  (prop_first_zero (nxv4i1 PPR:$src1),
                 (nxv4i1 (int_aarch64_sve_whilelo GPR64:$Rs1, GPR64:$Rs2)))),
            (BRKN_PPzP (PTRUE_S 31),
                       (BRKB_PPzP (PTRUE_S 31), (NOR_PPzPP (PTRUE_S 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PXX_S GPR64:$Rs1, GPR64:$Rs2))>;
  def : Pat<(nxv2i1  (prop_first_zero (nxv2i1 PPR:$src1),
                 (nxv2i1 (int_aarch64_sve_whilelo GPR64:$Rs1, GPR64:$Rs2)))),
            (BRKN_PPzP (PTRUE_D 31),
                       (BRKB_PPzP (PTRUE_D 31), (NOR_PPzPP(PTRUE_D 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PXX_D GPR64:$Rs1, GPR64:$Rs2))>;
}

  def : Pat<(nxv16i8 (scalar_to_vector (i32 FPR32:$src))),
            (INSERT_SUBREG (nxv16i8 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv8i16 (scalar_to_vector (i32 FPR32:$src))),
            (INSERT_SUBREG (nxv8i16 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv4i32 (scalar_to_vector (i32 FPR32:$src))),
            (INSERT_SUBREG (nxv4i32 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv2i64 (scalar_to_vector (i64 FPR64:$src))),
            (INSERT_SUBREG (nxv2i64 (IMPLICIT_DEF)), FPR64:$src, dsub)>;

  def : Pat<(nxv4f32 (scalar_to_vector (f32 FPR32:$src))),
            (INSERT_SUBREG (nxv4f32 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv2f64 (scalar_to_vector (f64 FPR64:$src))),
            (INSERT_SUBREG (nxv2f64 (IMPLICIT_DEF)), FPR64:$src, dsub)>;

  def : Pat<(nxv2f32 (scalar_to_vector (f32 FPR32:$src))),
            (INSERT_SUBREG (nxv2f32 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv16i1 (scalar_to_vector GPR32:$src)),
            (CMPNE_PPzZI_B (PTRUE_B 31), (LSL_ZZI_B (DUP_ZR_B $src), 7), 0)>;

  def : Pat<(nxv8i1 (scalar_to_vector GPR32:$src)),
            (CMPNE_PPzZI_H (PTRUE_H 31), (LSL_ZZI_H (DUP_ZR_H $src), 15), 0)>;

  def : Pat<(nxv4i1 (scalar_to_vector GPR32:$src)),
            (CMPNE_PPzZI_S (PTRUE_S 31), (LSL_ZZI_S (DUP_ZR_S $src), 31), 0)>;

  def : Pat<(nxv2i1 (scalar_to_vector GPR32:$src)),
            (CMPNE_PPzZI_D (PTRUE_D 31), (LSL_ZZI_S (DUP_ZR_S $src), 31), 0)>;

  // Insert scalar into vector[0]
  def : Pat<(nxv16i8 (vector_insert (nxv16i8 (undef)), (i32 FPR32:$src), 0)),
            (INSERT_SUBREG (nxv16i8 (IMPLICIT_DEF)), FPR32:$src, ssub)>;
  def : Pat<(nxv8i16 (vector_insert (nxv8i16 (undef)), (i32 FPR32:$src), 0)),
            (INSERT_SUBREG (nxv8i16 (IMPLICIT_DEF)), FPR32:$src, ssub)>;
  def : Pat<(nxv4i32 (vector_insert (nxv4i32 (undef)), (i32 FPR32:$src), 0)),
            (INSERT_SUBREG (nxv4i32 (IMPLICIT_DEF)), FPR32:$src, ssub)>;
  def : Pat<(nxv2i64 (vector_insert (nxv2i64 (undef)), (i64 FPR64:$src), 0)),
            (INSERT_SUBREG (nxv2i64 (IMPLICIT_DEF)), FPR64:$src, dsub)>;

  def : Pat<(nxv16i8 (vector_insert (nxv16i8 ZPR:$vec), (i32 GPR32:$src), 0)),
            (CPY_ZPmR_B ZPR:$vec, (PTRUE_B 1), GPR32:$src)>;
  def : Pat<(nxv8i16 (vector_insert (nxv8i16 ZPR:$vec), (i32 GPR32:$src), 0)),
            (CPY_ZPmR_H ZPR:$vec, (PTRUE_H 1), GPR32:$src)>;
  def : Pat<(nxv4i32 (vector_insert (nxv4i32 ZPR:$vec), (i32 GPR32:$src), 0)),
            (CPY_ZPmR_S ZPR:$vec, (PTRUE_S 1), GPR32:$src)>;
  def : Pat<(nxv2i64 (vector_insert (nxv2i64 ZPR:$vec), (i64 GPR64:$src), 0)),
            (CPY_ZPmR_D ZPR:$vec, (PTRUE_D 1), GPR64:$src)>;

  def : Pat<(nxv4f32 (vector_insert (nxv4f32 ZPR:$vec), (f32 FPR32:$src), 0)),
            (SEL_ZPZZ_S (PTRUE_S 1), (INSERT_SUBREG (IMPLICIT_DEF), FPR32:$src, ssub), ZPR:$vec)>;
  def : Pat<(nxv2f64 (vector_insert (nxv2f64 ZPR:$vec), (f64 FPR64:$src), 0)),
            (SEL_ZPZZ_D (PTRUE_D 1), (INSERT_SUBREG (IMPLICIT_DEF), FPR64:$src, dsub), ZPR:$vec)>;

  // Insert scalar into vector with scalar index
  def : Pat<(nxv16i8 (vector_insert (nxv16i8 ZPR:$vec), GPR32:$src, GPR64:$index)),
            (CPY_ZPmR_B ZPR:$vec,
                        (CMPEQ_PPzZZ_B (PTRUE_B 31),
                                       (INDEX_II_B 0, 1),
                                       (DUP_ZR_B (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                        GPR32:$src)>;
  def : Pat<(nxv8i16 (vector_insert (nxv8i16 ZPR:$vec), GPR32:$src, GPR64:$index)),
            (CPY_ZPmR_H ZPR:$vec,
                        (CMPEQ_PPzZZ_H (PTRUE_H 31),
                                       (INDEX_II_H 0, 1),
                                       (DUP_ZR_H (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                        GPR32:$src)>;
  def : Pat<(nxv4i32 (vector_insert (nxv4i32 ZPR:$vec), GPR32:$src, GPR64:$index)),
            (CPY_ZPmR_S ZPR:$vec,
                        (CMPEQ_PPzZZ_S (PTRUE_S 31),
                                       (INDEX_II_S 0, 1),
                                       (DUP_ZR_S (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                        GPR32:$src)>;
  def : Pat<(nxv2i64 (vector_insert (nxv2i64 ZPR:$vec), GPR64:$src, GPR64:$index)),
            (CPY_ZPmR_D ZPR:$vec,
                        (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                       (INDEX_II_D 0, 1),
                                       (DUP_ZR_D GPR64:$index)),
                        GPR64:$src)>;

  // Insert FP scalar into vector with scalar index
  def : Pat<(nxv4f32 (vector_insert (nxv4f32 ZPR:$vec), (f32 FPR32:$src), GPR64:$index)),
            (CPY_ZPmV_S ZPR:$vec,
                        (CMPEQ_PPzZZ_S (PTRUE_S 31),
                                       (INDEX_II_S 0, 1),
                                       (DUP_ZR_S (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                        $src)>;
  def : Pat<(nxv2f64 (vector_insert (nxv2f64 ZPR:$vec), (f64 FPR64:$src), GPR64:$index)),
            (CPY_ZPmV_D ZPR:$vec,
                        (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                       (INDEX_II_D 0, 1),
                                       (DUP_ZR_D $index)),
                        $src)>;
  def : Pat<(nxv2f32 (vector_insert (nxv2f32 ZPR:$vec), (f32 FPR32:$src), GPR64:$index)),
            (CPY_ZPmV_S ZPR:$vec,
                        (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                       (INDEX_II_D 0, 1),
                                       (DUP_ZR_D $index)),
                        $src)>;

  // Duplicate FP scalar into all vector elements
  def : Pat<(nxv8f16 (AArch64dup (f16 FPR16:$src))),
            (CPY_ZPmV_H (IMPLICIT_DEF), (PTRUE_H 31), $src)>;
  def : Pat<(nxv4f32 (AArch64dup (f32 FPR32:$src))),
            (CPY_ZPmV_S (IMPLICIT_DEF), (PTRUE_S 31), $src)>;
  def : Pat<(nxv2f32 (AArch64dup (f32 FPR32:$src))),
            (CPY_ZPmV_S (IMPLICIT_DEF), (PTRUE_D 31), $src)>;
  def : Pat<(nxv2f64 (AArch64dup (f64 FPR64:$src))),
            (CPY_ZPmV_D (IMPLICIT_DEF), (PTRUE_D 31), $src)>;

  // Duplicate +0.0 into all vector elements
  def : Pat<(nxv8f16 (AArch64dup (f16 fpimm0))),
            (DUP_ZI_H 0, 0)>;
  def : Pat<(nxv4f32 (AArch64dup (f32 fpimm0))),
            (DUP_ZI_S 0, 0)>;
  def : Pat<(nxv2f32 (AArch64dup (f32 fpimm0))),
            (DUP_ZI_S 0, 0)>;
  def : Pat<(nxv2f64 (AArch64dup (f64 fpimm0))),
            (DUP_ZI_D 0, 0)>;

  // Duplicate immediate in all vector elements
  def : Pat<(nxv16i8 (AArch64dup (i32 (SVE8BitLslImm i32:$a, i32:$b)))),
            (DUP_ZI_B $a, $b)>;
  def : Pat<(nxv8i16 (AArch64dup (i32 (SVE8BitLslImm i32:$a, i32:$b)))),
            (DUP_ZI_H $a, $b)>;
  def : Pat<(nxv4i32 (AArch64dup (i32 (SVE8BitLslImm i32:$a, i32:$b)))),
            (DUP_ZI_S $a, $b)>;
  def : Pat<(nxv2i64 (AArch64dup (i64 (SVE8BitLslImm i64:$a, i64:$b)))),
            (DUP_ZI_D $a, $b)>;

  // Duplicate GPR in all vector elements
  def : Pat<(nxv16i8 (AArch64dup GPR32:$a)),
            (DUP_ZR_B $a)>;
  def : Pat<(nxv8i16 (AArch64dup GPR32:$a)),
            (DUP_ZR_H $a)>;
  def : Pat<(nxv4i32 (AArch64dup GPR32:$a)),
            (DUP_ZR_S $a)>;
  def : Pat<(nxv2i64 (AArch64dup GPR64:$a)),
            (DUP_ZR_D $a)>;

  // Dup of fp immediate pattern.
  let AddedComplexity = 2 in {
    def : Pat<(nxv4f32 (AArch64dup sve_fpimm32:$imm8)),
              (FCPY_ZI_S sve_fpimm32:$imm8)>;
    def : Pat<(nxv2f32 (AArch64dup sve_fpimm32:$imm8)),
              (FCPY_ZI_S sve_fpimm32:$imm8)>;
    def : Pat<(nxv2f64 (AArch64dup sve_fpimm64:$imm8)),
              (FCPY_ZI_D sve_fpimm64:$imm8)>;
  }

  /// Compact single bit fp immediates
  multiclass intrinsic_compact_fp_immediates<string I, PatLeaf A, PatLeaf B,
                    SDPatternOperator op, SDPatternOperator ir_op = null_frag> {
    def : Pat<(nxv4f32 (op (nxv4i1 PPRR:$Pg),
                           (nxv4f32 ZPR:$Zs1),
                           (nxv4f32 (AArch64dup (f32 A))))),
              (!cast<Instruction>(I # "_S") PPRR:$Pg, ZPR:$Zs1, 0)>;
    def : Pat<(nxv4f32 (op (nxv4i1 PPRR:$Pg),
                           (nxv4f32 ZPR:$Zs1),
                           (nxv4f32 (AArch64dup (f32 B))))),
              (!cast<Instruction>(I # "_S") PPRR:$Pg, ZPR:$Zs1, 1)>;
    def : Pat<(nxv2f64 (op (nxv2i1 PPRR:$Pg),
                           (nxv2f64 ZPR:$Zs1),
                           (nxv2f64 (AArch64dup (f64 A))))),
              (!cast<Instruction>(I # "_D") PPRR:$Pg, ZPR:$Zs1, 0)>;
    def : Pat<(nxv2f64 (op (nxv2i1 PPRR:$Pg),
                           (nxv2f64 ZPR:$Zs1),
                           (nxv2f64 (AArch64dup (f64 B))))),
              (!cast<Instruction>(I # "_D") PPRR:$Pg, ZPR:$Zs1, 1)>;

    def : Pat<(nxv4f32 (ir_op (nxv4f32 ZPR:$Zs1),
                              (nxv4f32 (AArch64dup (f32 A))))),
              (!cast<Instruction>(I # "_S") (PTRUE_S 31), ZPR:$Zs1, 0)>;
    def : Pat<(nxv4f32 (ir_op (nxv4f32 ZPR:$Zs1),
                              (nxv4f32 (AArch64dup (f32 B))))),
              (!cast<Instruction>(I # "_S") (PTRUE_S 31), ZPR:$Zs1, 1)>;
    def : Pat<(nxv2f64 (ir_op (nxv2f64 ZPR:$Zs1),
                              (nxv2f64 (AArch64dup (f64 A))))),
              (!cast<Instruction>(I # "_D") (PTRUE_D 31), ZPR:$Zs1, 0)>;
    def : Pat<(nxv2f64 (ir_op (nxv2f64 ZPR:$Zs1),
                              (nxv2f64 (AArch64dup (f64 B))))),
              (!cast<Instruction>(I # "_D") (PTRUE_D 31), ZPR:$Zs1, 1)>;
  }

  defm : intrinsic_compact_fp_immediates<"FADD_ZPmI", fpimm_half, fpimm_one, int_aarch64_sve_add, fadd>;
  defm : intrinsic_compact_fp_immediates<"FSUB_ZPmI", fpimm_half, fpimm_one, int_aarch64_sve_sub, fsub>;
  defm : intrinsic_compact_fp_immediates<"FSUBR_ZPmI", fpimm_half, fpimm_one, int_aarch64_sve_subr>;
  defm : intrinsic_compact_fp_immediates<"FMUL_ZPmI", fpimm_half, fpimm_two, int_aarch64_sve_mul, fmul>;
  defm : intrinsic_compact_fp_immediates<"FMAX_ZPmI", fpimm0, fpimm_one, AArch64fmax_pred>;
  defm : intrinsic_compact_fp_immediates<"FMIN_ZPmI", fpimm0, fpimm_one, AArch64fmin_pred>;
  defm : intrinsic_compact_fp_immediates<"FMAXNM_ZPmI", fpimm0, fpimm_one, AArch64fmaxnm_pred>;
  defm : intrinsic_compact_fp_immediates<"FMINNM_ZPmI", fpimm0, fpimm_one, AArch64fminnm_pred>;

  foreach type = ["nxv16i1", "nxv8i1", "nxv4i1", "nxv2i1"] in {
    def : Pat< (!cast<ValueType>(type)
                         (load (am_sve_pred GPR64sp:$base, simm9:$offset))),
                (LDR_PXI GPR64sp:$base, simm9:$offset)>;
    def : Pat<(store (!cast<ValueType>(type) PPR:$val),
                         (am_sve_pred GPR64sp:$base, simm9:$offset)),
               (STR_PXI PPR:$val, GPR64sp:$base, simm9:$offset)>;
  }

  def : Pat<(AArch64fcvt_extend (nxv4f32 ZPR:$Zs)),
            (FCVT_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (fextend (nxv2f32 ZPR:$Zs))),
            (FCVT_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f32 (fround  (nxv2f64 ZPR:$Zs))),
            (FCVT_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(nxv4i32 (fp_to_sint (nxv4f32 ZPR:$Zs))),
            (FCVTZS_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_sint (nxv2f32 ZPR:$Zs))),
            (FCVTZS_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_sint (nxv2f64 ZPR:$Zs))),
            (FCVTZS_ZPmZ_DtoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_sint_inreg (nxv2f32 ZPR:$Zs), nxv2i32)),
            (FCVTZS_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_sint_inreg (nxv2f64 ZPR:$Zs), nxv2i32)),
            (FCVTZS_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(nxv4i32 (fp_to_uint (nxv4f32 ZPR:$Zs))),
            (FCVTZU_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_uint (nxv2f32 ZPR:$Zs))),
            (FCVTZU_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_uint (nxv2f64 ZPR:$Zs))),
            (FCVTZU_ZPmZ_DtoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_uint_inreg (nxv2f32 ZPR:$Zs), nxv2i32)),
            (FCVTZU_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_uint_inreg (nxv2f64 ZPR:$Zs), nxv2i32)),
            (FCVTZU_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(nxv2f32 (sint_to_fp (sext_inreg (nxv2i64 ZPR:$Zs), nxv2i32))),
            (SCVTF_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f32 (sint_to_fp (nxv2i64 ZPR:$Zs))),
            (SCVTF_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv4f32 (sint_to_fp (nxv4i32 ZPR:$Zs))),
            (SCVTF_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (sint_to_fp (sext_inreg (nxv2i64 ZPR:$Zs), nxv2i32))),
            (SCVTF_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (sint_to_fp (nxv2i64 ZPR:$Zs))),
            (SCVTF_ZPmZ_DtoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(nxv2f32 (uint_to_fp (and (nxv2i64 ZPR:$Zs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))))),
            (UCVTF_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f32 (uint_to_fp (nxv2i64 ZPR:$Zs))),
            (UCVTF_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv4f32 (uint_to_fp (nxv4i32 ZPR:$Zs))),
            (UCVTF_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (uint_to_fp (and (nxv2i64 ZPR:$Zs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))))),
            (UCVTF_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (uint_to_fp (nxv2i64 ZPR:$Zs))),
            (UCVTF_ZPmZ_DtoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(AArch64ptest (nxv16i1 PPR:$pg), (nxv16i1 PPR:$src)),
            (PTEST_PP PPR:$pg, PPR:$src)>;
  def : Pat<(AArch64ptest (nxv8i1 PPR:$pg), (nxv8i1 PPR:$src)),
            (PTEST_PP PPR:$pg, PPR:$src)>;
  def : Pat<(AArch64ptest (nxv4i1 PPR:$pg), (nxv4i1 PPR:$src)),
            (PTEST_PP PPR:$pg, PPR:$src)>;
  def : Pat<(AArch64ptest (nxv2i1 PPR:$pg), (nxv2i1 PPR:$src)),
            (PTEST_PP PPR:$pg, PPR:$src)>;

  def : Pat<(AArch64not (nxv16i1 PPR:$src)),
            (NOR_PPzPP (PTRUE_B 31), PPR:$src, PPR:$src)>;
  def : Pat<(AArch64not (nxv8i1 PPR:$src)),
            (NOR_PPzPP (PTRUE_H 31), PPR:$src, PPR:$src)>;
  def : Pat<(AArch64not (nxv4i1 PPR:$src)),
            (NOR_PPzPP (PTRUE_S 31), PPR:$src, PPR:$src)>;
  def : Pat<(AArch64not (nxv2i1 PPR:$src)),
            (NOR_PPzPP (PTRUE_D 31), PPR:$src, PPR:$src)>;

  def : Pat<(nxv16i8 (bitconvert (nxv8i16 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv4i32 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv2i64 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv8f16 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv4f32 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv2f64 ZPR:$src))), (nxv16i8 ZPR:$src)>;

  def : Pat<(nxv8i16 (bitconvert (nxv16i8 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv4i32 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv2i64 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv8f16 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv4f32 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv2f64 ZPR:$src))), (nxv8i16 ZPR:$src)>;

  def : Pat<(nxv4i32 (bitconvert (nxv16i8 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv8i16 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv2i64 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv8f16 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv4f32 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv2f64 ZPR:$src))), (nxv4i32 ZPR:$src)>;

  def : Pat<(nxv2i64 (bitconvert (nxv16i8 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv8i16 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv4i32 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv8f16 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv4f32 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv2f64 ZPR:$src))), (nxv2i64 ZPR:$src)>;

  def : Pat<(nxv8f16 (bitconvert (nxv16i8 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv8i16 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv4i32 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv2i64 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv4f32 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv2f64 ZPR:$src))), (nxv8f16 ZPR:$src)>;

  def : Pat<(nxv4f32 (bitconvert (nxv16i8 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv8i16 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv4i32 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv2i64 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv8f16 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv2f64 ZPR:$src))), (nxv4f32 ZPR:$src)>;

  def : Pat<(nxv2f64 (bitconvert (nxv16i8 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv8i16 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv4i32 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv2i64 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv8f16 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv4f32 ZPR:$src))), (nxv2f64 ZPR:$src)>;

  // These are effectively bitconvert for predicates but due to the differently
  // sized input/ouput ValueTypes we cannot simply return $src.
  def : Pat<(nxv16i1 (reinterpret_cast (nxv8i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv16i1 (reinterpret_cast (nxv4i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv16i1 (reinterpret_cast (nxv2i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv8i1 (reinterpret_cast (nxv16i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv8i1 (reinterpret_cast  (nxv4i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv8i1 (reinterpret_cast  (nxv2i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv4i1 (reinterpret_cast (nxv16i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv4i1 (reinterpret_cast  (nxv8i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv4i1 (reinterpret_cast  (nxv2i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv2i1 (reinterpret_cast (nxv16i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv2i1 (reinterpret_cast  (nxv8i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv2i1 (reinterpret_cast  (nxv4i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;

  multiclass unpred_load<ValueType Ty, Instruction RegRegInst, Instruction RegImmInst, ComplexPattern AddrCP, Instruction PTrue> {
    // reg + reg
    let AddedComplexity = 1 in {
      def _reg_reg : Pat<(Ty (load  (AddrCP GPR64sp:$base, GPR64:$offset))),
                         (RegRegInst (PTrue 31), GPR64sp:$base, GPR64:$offset)>;
    }
    // reg + imm
    let AddedComplexity = 2 in {
      def _reg_imm : Pat<(Ty (load  (am_sve_indexed_s4 GPR64sp:$base, simm4:$offset))),
                         (RegImmInst (PTrue 31), GPR64sp:$base, simm4:$offset)>;
    }
    // default fallback
    def _default : Pat<(Ty (load  GPR64sp:$base)),
                       (RegImmInst (PTrue 31), GPR64sp:$base, (i64 0))>;
  }

  defm Pat_LD1B        : unpred_load<nxv16i8, LD1B, LD1B_B_IMM, SVEAddrModeRegReg8,  PTRUE_B>;
  defm Pat_LD1H        : unpred_load<nxv8i16, LD1H, LD1H_H_IMM, SVEAddrModeRegReg16, PTRUE_H>;
  defm Pat_LD1W        : unpred_load<nxv4i32, LD1W, LD1W_S_IMM, SVEAddrModeRegReg32, PTRUE_S>;
  defm Pat_LD1D        : unpred_load<nxv2i64, LD1D, LD1D_D_IMM, SVEAddrModeRegReg64, PTRUE_D>;
  defm Pat_LD1H_float16: unpred_load<nxv8f16, LD1H, LD1H_H_IMM, SVEAddrModeRegReg16, PTRUE_H>;
  defm Pat_LD1W_float  : unpred_load<nxv4f32, LD1W, LD1W_S_IMM, SVEAddrModeRegReg32, PTRUE_S>;
  defm Pat_LD1D_double : unpred_load<nxv2f64, LD1D, LD1D_D_IMM, SVEAddrModeRegReg64, PTRUE_D>;

  multiclass pred_load<ValueType Ty, ValueType PredTy, SDPatternOperator Load, Instruction RegRegInst, Instruction RegImmInst, ComplexPattern AddrCP> {
    // reg + reg
    let AddedComplexity = 1 in {
      def _reg_reg : Pat<(Ty (Load (AddrCP GPR64:$base, GPR64:$offset), (PredTy PPR:$gp), undef)),
                         (RegRegInst PPR:$gp, GPR64:$base, GPR64:$offset)>;
    }
    // reg + imm
    let AddedComplexity = 2 in {
      def _reg_imm : Pat<(Ty (Load (am_sve_indexed_s4 GPR64sp:$base, simm4:$offset), (PredTy PPR:$gp), undef)),
                         (RegImmInst PPR:$gp, GPR64:$base, simm4:$offset)>;
    }
    // default fallback
    def _default : Pat<(Ty (Load  GPR64:$base, (PredTy PPR:$gp), undef)),
                       (RegImmInst PPR:$gp, GPR64:$base, (i64 0))>;
  }

  // 2-element contiguous loads
  defm : pred_load<nxv2i64, nxv2i1, zext_masked_load_i8,  LD1B_D,  LD1B_D_IMM,  SVEAddrModeRegReg8>;
  defm : pred_load<nxv2i64, nxv2i1, sext_masked_load_i8,  LD1SB_D, LD1SB_D_IMM, SVEAddrModeRegReg8>;
  defm : pred_load<nxv2i64, nxv2i1, zext_masked_load_i16, LD1H_D,  LD1H_D_IMM,  SVEAddrModeRegReg16>;
  defm : pred_load<nxv2i64, nxv2i1, sext_masked_load_i16, LD1SH_D, LD1SH_D_IMM, SVEAddrModeRegReg16>;
  defm : pred_load<nxv2i64, nxv2i1, zext_masked_load_i32, LD1W_D,  LD1W_D_IMM,  SVEAddrModeRegReg32>;
  defm : pred_load<nxv2i64, nxv2i1, sext_masked_load_i32, LD1SW_D, LD1SW_D_IMM, SVEAddrModeRegReg32>;
  defm : pred_load<nxv2i64, nxv2i1, nonext_masked_load,   LD1D,    LD1D_D_IMM,  SVEAddrModeRegReg64>;
  defm : pred_load<nxv2f32, nxv2i1, nonext_masked_load,   LD1W_D,  LD1W_D_IMM,  SVEAddrModeRegReg32>;
  defm : pred_load<nxv2f64, nxv2i1, nonext_masked_load,   LD1D,    LD1D_D_IMM,  SVEAddrModeRegReg64>;

  // 4-element contiguous loads
  defm : pred_load<nxv4i32, nxv4i1, zext_masked_load_i8,  LD1B_S,  LD1B_S_IMM,  SVEAddrModeRegReg8>;
  defm : pred_load<nxv4i32, nxv4i1, sext_masked_load_i8,  LD1SB_S, LD1SB_S_IMM, SVEAddrModeRegReg8>;
  defm : pred_load<nxv4i32, nxv4i1, zext_masked_load_i16, LD1H_S,  LD1H_S_IMM,  SVEAddrModeRegReg16>;
  defm : pred_load<nxv4i32, nxv4i1, sext_masked_load_i16, LD1SH_S, LD1SH_S_IMM, SVEAddrModeRegReg16>;
  defm : pred_load<nxv4i32, nxv4i1, nonext_masked_load,   LD1W,    LD1W_S_IMM,  SVEAddrModeRegReg32>;
  defm : pred_load<nxv4f32, nxv4i1, nonext_masked_load,   LD1W,    LD1W_S_IMM,  SVEAddrModeRegReg32>;

  // 8-element contiguous loads
  defm : pred_load<nxv8i16, nxv8i1, zext_masked_load_i8,  LD1B_H,  LD1B_H_IMM,  SVEAddrModeRegReg8>;
  defm : pred_load<nxv8i16, nxv8i1, sext_masked_load_i8,  LD1SB_H, LD1SB_H_IMM, SVEAddrModeRegReg8>;
  defm : pred_load<nxv8i16, nxv8i1, nonext_masked_load,   LD1H,    LD1H_H_IMM,  SVEAddrModeRegReg16>;
  defm : pred_load<nxv8f16, nxv8i1, nonext_masked_load,   LD1H,    LD1H_H_IMM,  SVEAddrModeRegReg16>;

  // 16-element contiguous loads
  defm : pred_load<nxv16i8, nxv16i1, nonext_masked_load,  LD1B,    LD1B_B_IMM,  SVEAddrModeRegReg8>;


  // 2-element contiguous first faulting loads
  def : Pat<(nxv2i64 (AArch64ldff1b (nxv2i1 PPR:$gp), GPR64:$base)),
            (LDFF1B_D PPR:$gp, GPR64:$base, XZR)>;
  def : Pat<(nxv2i64 (AArch64ldff1h (nxv2i1 PPR:$gp), GPR64:$base)),
            (LDFF1H_D PPR:$gp, GPR64:$base, XZR)>;
  def : Pat<(nxv2i64 (AArch64ldff1w (nxv2i1 PPR:$gp), GPR64:$base)),
            (LDFF1W_D PPR:$gp, GPR64:$base, XZR)>;
  def : Pat<(nxv2i64 (AArch64ldff1d (nxv2i1 PPR:$gp), GPR64:$base)),
            (LDFF1D PPR:$gp, GPR64:$base, XZR)>;
  def : Pat<(nxv2f32 (AArch64ldff1w (nxv2i1 PPR:$gp), GPR64:$base)),
            (LDFF1W_D PPR:$gp, GPR64:$base, XZR)>;
  def : Pat<(nxv2f64 (AArch64ldff1d (nxv2i1 PPR:$gp), GPR64:$base)),
            (LDFF1D PPR:$gp, GPR64:$base, XZR)>;

  // 4-element contiguous first faulting loads
  def : Pat<(nxv4i32 (AArch64ldff1b (nxv4i1 PPR:$gp), GPR64:$base)),
            (LDFF1B_S PPR:$gp, GPR64:$base, XZR)>;
  def : Pat<(nxv4i32 (AArch64ldff1h (nxv4i1 PPR:$gp), GPR64:$base)),
            (LDFF1H_S PPR:$gp, GPR64:$base, XZR)>;
  def : Pat<(nxv4i32 (AArch64ldff1w (nxv4i1 PPR:$gp), GPR64:$base)),
            (LDFF1W PPR:$gp, GPR64:$base, XZR)>;
  def : Pat<(nxv4f32 (AArch64ldff1w (nxv4i1 PPR:$gp), GPR64:$base)),
            (LDFF1W PPR:$gp, GPR64:$base, XZR)>;

  // 8-element contiguous first faulting loads
  def : Pat<(nxv8i16 (AArch64ldff1b (nxv8i1 PPR:$gp), GPR64:$base)),
            (LDFF1B_H PPR:$gp, GPR64:$base, XZR)>;
  def : Pat<(nxv8i16 (AArch64ldff1h (nxv8i1 PPR:$gp), GPR64:$base)),
            (LDFF1H PPR:$gp, GPR64:$base, XZR)>;

  // 16-element contiguous first faulting loads
  def : Pat<(nxv16i8 (AArch64ldff1b (nxv16i1 PPR:$gp), GPR64:$base)),
            (LDFF1B PPR:$gp, GPR64:$base, XZR)>;


  multiclass sve_masked_gather_x2<ValueType vt, SDPatternOperator load, string I> {
    // vector of pointers
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), 0, (nxv2i64 ZPR:$ptrs))),
              (!cast<Instruction>(!strconcat(I, "_IMM")) PPR:$gp, ZPR:$ptrs, 0)>;
    // vector of pointers + scalar offset
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), 0, (add (nxv2i64 ZPR:$ptrs), (nxv2i64 (AArch64dup GPR64:$offset))))),
              (!cast<Instruction>(I) PPR:$gp, GPR64:$offset, ZPR:$ptrs)>;
    // base + vector of indices
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), GPR64:$base, (nxv2i64 ZPR:$idxs))),
              (!cast<Instruction>(!strconcat(I, "_SCALED")) PPR:$gp, GPR64:$base, ZPR:$idxs)>;
    // base + vector of signed 32bit indices
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), GPR64:$base, (sext_inreg (nxv2i64 ZPR:$idxs), nxv2i32))),
              (!cast<Instruction>(!strconcat(I, "_SXTW_SCALED")) PPR:$gp, GPR64:$base, ZPR:$idxs)>;
    // base + vector of unsigned 32bit indices
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), GPR64:$base, (and (nxv2i64 ZPR:$idxs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))))),
              (!cast<Instruction>(!strconcat(I, "_UXTW_SCALED")) PPR:$gp, GPR64:$base, ZPR:$idxs)>;
  }

  multiclass sve_masked_gather_x4<ValueType vt, SDPatternOperator load, string I> {
    // base + vector of signed 32bit indices
    def : Pat<(vt (load undef, (nxv4i1 PPR:$gp), GPR64:$base, (nxv4i32 ZPR:$idxs))),
              (!cast<Instruction>(!strconcat(I, "_SXTW_SCALED")) PPR:$gp, GPR64:$base, ZPR:$idxs)>;
  }

  // Bytes handled seperately as they don't require "SCALED" instructions.
  multiclass sve_masked_gather_bytes<SDPatternOperator load, string I2, string I4> {
    // x2 - vector of pointers
    def : Pat<(nxv2i64 (load undef, (nxv2i1 PPR:$gp), 0, (nxv2i64 ZPR:$ptrs))),
              (!cast<Instruction>(!strconcat(I2, "_IMM")) PPR:$gp, ZPR:$ptrs, 0)>;
    // vector of pointers + scalar offset
    def : Pat<(nxv2i64 (load undef, (nxv2i1 PPR:$gp), 0, (add (nxv2i64 ZPR:$ptrs), (nxv2i64 (AArch64dup GPR64:$offset))))),
              (!cast<Instruction>(I2) PPR:$gp, GPR64:$offset, ZPR:$ptrs)>;
    // x2 - base + vector of indices
    def : Pat<(nxv2i64 (load undef, (nxv2i1 PPR:$gp), GPR64:$base, (nxv2i64 ZPR:$idxs))),
              (!cast<Instruction>(I2) PPR:$gp, GPR64:$base, ZPR:$idxs)>;
    // x2 - base + vector of signed 32bit indices
    def : Pat<(nxv2i64 (load undef, (nxv2i1 PPR:$gp), GPR64:$base, (sext_inreg (nxv2i64 ZPR:$idxs), nxv2i32))),
              (!cast<Instruction>(!strconcat(I2, "_SXTW")) PPR:$gp, GPR64:$base, ZPR:$idxs)>;
    // x2 - base + vector of unsigned 32bit indices
    def : Pat<(nxv2i64 (load undef, (nxv2i1 PPR:$gp), GPR64:$base, (and (nxv2i64 ZPR:$idxs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))))),
              (!cast<Instruction>(!strconcat(I2, "_UXTW")) PPR:$gp, GPR64:$base, ZPR:$idxs)>;

    // x4 - base + vector of signed 32bit indices
    def : Pat<(nxv4i32 (load undef, (nxv4i1 PPR:$gp), GPR64:$base, (nxv4i32 ZPR:$idxs))),
              (!cast<Instruction>(!strconcat(I4, "_SXTW")) PPR:$gp, GPR64:$base, ZPR:$idxs)>;
  }

  defm : sve_masked_gather_bytes<zext_masked_gather_i8, "GLD1B_D" , "GLD1B_S">;
  defm : sve_masked_gather_bytes<sext_masked_gather_i8, "GLD1SB_D", "GLD1SB_S">;

  defm : sve_masked_gather_x2<nxv2i64, zext_masked_gather_i16, "GLD1H_D">;
  defm : sve_masked_gather_x2<nxv2i64, sext_masked_gather_i16, "GLD1SH_D">;
  defm : sve_masked_gather_x2<nxv2i64, zext_masked_gather_i32, "GLD1W_D">;
  defm : sve_masked_gather_x2<nxv2i64, sext_masked_gather_i32, "GLD1SW_D">;
  defm : sve_masked_gather_x2<nxv2i64, nonext_masked_gather,   "GLD1D">;
  defm : sve_masked_gather_x2<nxv2f32, nonext_masked_gather,   "GLD1W_D">;
  defm : sve_masked_gather_x2<nxv2f64, nonext_masked_gather,   "GLD1D">;

  defm : sve_masked_gather_x4<nxv4i32, zext_masked_gather_i16, "GLD1H_S">;
  defm : sve_masked_gather_x4<nxv4i32, sext_masked_gather_i16, "GLD1SH_S">;
  defm : sve_masked_gather_x4<nxv4i32, nonext_masked_gather,   "GLD1W">;
  defm : sve_masked_gather_x4<nxv4f32, nonext_masked_gather,   "GLD1W">;


  multiclass unpred_store<ValueType Ty, Instruction RegRegInst, Instruction RegImmInst, ComplexPattern AddrCP, Instruction PTrue> {
    // reg + reg
    let AddedComplexity = 1 in {
      def _reg_reg : Pat<(store (Ty ZPR:$val), (AddrCP GPR64sp:$base, GPR64:$offset)),
                         (RegRegInst ZPR:$val, (PTrue 31), GPR64sp:$base, GPR64:$offset)>;
    // reg + imm
    }
    let AddedComplexity = 2 in {
      def _reg_imm : Pat<(store (Ty ZPR:$val), (am_sve_indexed_s4 GPR64sp:$base, simm4:$offset)),
                         (RegImmInst ZPR:$val, (PTrue 31), GPR64sp:$base, simm4:$offset)>;
    }
    // default fallback
    def _default : Pat<(store (Ty ZPR:$val),  GPR64sp:$base),
                       (RegImmInst ZPR:$val, (PTrue 31), GPR64sp:$base, (i64 0))>;
  }

  defm Pat_ST1B        : unpred_store<nxv16i8, ST1B, ST1B_B_IMM, SVEAddrModeRegReg8,  PTRUE_B>;
  defm Pat_ST1H        : unpred_store<nxv8i16, ST1H, ST1H_H_IMM, SVEAddrModeRegReg16, PTRUE_H>;
  defm Pat_ST1W        : unpred_store<nxv4i32, ST1W, ST1W_S_IMM, SVEAddrModeRegReg32, PTRUE_S>;
  defm Pat_ST1D        : unpred_store<nxv2i64, ST1D, ST1D_D_IMM, SVEAddrModeRegReg64, PTRUE_D>;
  defm Pat_ST1H_float16: unpred_store<nxv8f16, ST1H, ST1H_H_IMM, SVEAddrModeRegReg16, PTRUE_H>;
  defm Pat_ST1W_float  : unpred_store<nxv4f32, ST1W, ST1W_S_IMM, SVEAddrModeRegReg32, PTRUE_S>;
  defm Pat_ST1D_double : unpred_store<nxv2f64, ST1D, ST1D_D_IMM, SVEAddrModeRegReg64, PTRUE_D>;


  multiclass pred_store<ValueType Ty, ValueType PredTy, SDPatternOperator Store, Instruction RegRegInst, Instruction RegImmInst, ComplexPattern AddrCP> {
    // reg + reg
    let AddedComplexity = 1 in {
      def _reg_reg : Pat<(Store (AddrCP GPR64:$base, GPR64:$offset), (PredTy PPR:$gp), (Ty ZPR:$vec)),
                         (RegRegInst ZPR:$vec, PPR:$gp, GPR64:$base, GPR64:$offset)>;
    }
    // reg + imm
    let AddedComplexity = 2 in {
    // TODO: write LL test for this pattern
      def _reg_imm : Pat<(Store (am_sve_indexed_s4 GPR64sp:$base, simm4:$offset), (PredTy PPR:$gp), (Ty ZPR:$vec)),
                         (RegImmInst ZPR:$vec, PPR:$gp, GPR64:$base, simm4:$offset)>;
    }
    // default fallback
    def _default : Pat<(Store GPR64:$base, (PredTy PPR:$gp), (Ty ZPR:$vec)),
                       (RegImmInst ZPR:$vec, PPR:$gp, GPR64:$base, (i64 0))>;
  }

  // 2-element contiguous stores
  defm : pred_store<nxv2i64, nxv2i1, trunc_masked_store_i8,  ST1B_D, ST1B_D_IMM, SVEAddrModeRegReg8>;
  defm : pred_store<nxv2i64, nxv2i1, trunc_masked_store_i16, ST1H_D, ST1H_D_IMM, SVEAddrModeRegReg16>;
  defm : pred_store<nxv2i64, nxv2i1, trunc_masked_store_i32, ST1W_D, ST1W_D_IMM, SVEAddrModeRegReg32>;
  defm : pred_store<nxv2i64, nxv2i1, nontrunc_masked_store,  ST1D,   ST1D_D_IMM, SVEAddrModeRegReg64>;
  defm : pred_store<nxv2f32, nxv2i1, nontrunc_masked_store,  ST1W_D, ST1W_D_IMM, SVEAddrModeRegReg32>;
  defm : pred_store<nxv2f64, nxv2i1, nontrunc_masked_store,  ST1D,   ST1D_D_IMM, SVEAddrModeRegReg64>;

  // 4-element contiguous stores
  defm : pred_store<nxv4i32, nxv4i1, trunc_masked_store_i8,  ST1B_S, ST1B_S_IMM, SVEAddrModeRegReg8>;
  defm : pred_store<nxv4i32, nxv4i1, trunc_masked_store_i16, ST1H_S, ST1H_S_IMM, SVEAddrModeRegReg16>;
  defm : pred_store<nxv4i32, nxv4i1, nontrunc_masked_store,  ST1W,   ST1W_S_IMM, SVEAddrModeRegReg32>;
  defm : pred_store<nxv4f32, nxv4i1, nontrunc_masked_store,  ST1W,   ST1W_S_IMM, SVEAddrModeRegReg32>;

  // 8-element contiguous stores
  defm : pred_store<nxv8i16, nxv8i1, trunc_masked_store_i8,  ST1B_H, ST1B_H_IMM, SVEAddrModeRegReg8>;
  defm : pred_store<nxv8i16, nxv8i1, nontrunc_masked_store,  ST1H,   ST1H_H_IMM, SVEAddrModeRegReg16>;
  defm : pred_store<nxv8f16, nxv8i1, nontrunc_masked_store,  ST1H,   ST1H_H_IMM, SVEAddrModeRegReg16>;

  // 16-element contiguous stores
  defm : pred_store<nxv16i8, nxv16i1, nontrunc_masked_store, ST1B,   ST1B_B_IMM, SVEAddrModeRegReg8>;


  multiclass sve_masked_scatter_x2<ValueType vt, SDPatternOperator store, string I> {
    // vector of pointers
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), 0, (nxv2i64 ZPR:$ptrs)),
              (!cast<Instruction>(!strconcat(I, "_IMM")) ZPR:$vec, PPR:$gp, ZPR:$ptrs, 0)>;
    // base + vector of indices
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), GPR64:$base, (nxv2i64 ZPR:$idxs)),
              (!cast<Instruction>(!strconcat(I, "_SCALED")) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$idxs)>;
    // base + vector of signed 32bit indices
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), GPR64:$base, (sext_inreg (nxv2i64 ZPR:$idxs), nxv2i32)),
              (!cast<Instruction>(!strconcat(I, "_SXTW_SCALED")) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$idxs)>;
    // base + vector of unsigned 32bit indices
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), GPR64:$base, (and (nxv2i64 ZPR:$idxs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF))))),
              (!cast<Instruction>(!strconcat(I, "_UXTW_SCALED")) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$idxs)>;
  }

  multiclass sve_masked_scatter_x4<ValueType vt, SDPatternOperator store, string I> {
    // base + vector of signed 32bit indices
    def : Pat<(store (vt ZPR:$vec), (nxv4i1 PPR:$gp), GPR64:$base, (nxv4i32 ZPR:$idxs)),
              (!cast<Instruction>(!strconcat(I, "_SXTW_SCALED")) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$idxs)>;
  }

  // Bytes handled seperately as they don't require "SCALED" instructions.
  multiclass sve_masked_scatter_bytes<SDPatternOperator store, string I2, string I4> {
    // x2 - vector of pointers
    def : Pat<(store (nxv2i64 ZPR:$vec), (nxv2i1 PPR:$gp), 0, (nxv2i64 ZPR:$ptrs)),
              (!cast<Instruction>(!strconcat(I2, "_IMM")) ZPR:$vec, PPR:$gp, ZPR:$ptrs, 0)>;
    // x2 - base + vector of indices
    def : Pat<(store (nxv2i64 ZPR:$vec), (nxv2i1 PPR:$gp), GPR64:$base, (nxv2i64 ZPR:$idxs)),
              (!cast<Instruction>(I2) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$idxs)>;
    // x2 - base + vector of signed 32bit indices
    def : Pat<(store (nxv2i64 ZPR:$vec), (nxv2i1 PPR:$gp), GPR64:$base, (sext_inreg (nxv2i64 ZPR:$idxs), nxv2i32)),
              (!cast<Instruction>(!strconcat(I2, "_SXTW")) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$idxs)>;
    // x2 - base + vector of unsigned 32bit indices
    def : Pat<(store (nxv2i64 ZPR:$vec), (nxv2i1 PPR:$gp), GPR64:$base, (and (nxv2i64 ZPR:$idxs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF))))),
              (!cast<Instruction>(!strconcat(I2, "_UXTW")) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$idxs)>;

    // x4 - base + vector of signed 32bit indices
    def : Pat<(store (nxv4i32 ZPR:$vec), (nxv4i1 PPR:$gp), GPR64:$base, (nxv4i32 ZPR:$idxs)),
              (!cast<Instruction>(!strconcat(I4, "_SXTW")) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$idxs)>;
  }

  defm : sve_masked_scatter_bytes<trunc_masked_scatter_i8, "SST1B_D" , "SST1B_S">;

  defm : sve_masked_scatter_x2<nxv2i64, trunc_masked_scatter_i16, "SST1H_D">;
  defm : sve_masked_scatter_x2<nxv2i64, trunc_masked_scatter_i32, "SST1W_D">;
  defm : sve_masked_scatter_x2<nxv2i64, nontrunc_masked_scatter,  "SST1D">;
  defm : sve_masked_scatter_x2<nxv2f32, nontrunc_masked_scatter,  "SST1W_D">;
  defm : sve_masked_scatter_x2<nxv2f64, nontrunc_masked_scatter,  "SST1D">;

  defm : sve_masked_scatter_x4<nxv4i32, trunc_masked_scatter_i16, "SST1H_S">;
  defm : sve_masked_scatter_x4<nxv4i32, nontrunc_masked_scatter,  "SST1W">;
  defm : sve_masked_scatter_x4<nxv4f32, nontrunc_masked_scatter,  "SST1W">;


  // Unpacked floating point loads

  // mem: [A][B][C][D]
  // ldr: [A][B][?][?] [?][?][?][?] [C][D][?][?] [?][?][?][?]
  // uzp: [A][B][?][?] [C][D][?][?] [?]...
  // uzp: [A][B][C][D] [?]...
  def : Pat<(nxv2f32 (load (i64 GPR64:$base))),
            (LD1W_D_IMM (PTRUE_D 31), GPR64:$base, (i64 0))>;


  // Unpacked floating point stores

  //    : [A][B][C][D] [?]...
  // zip: [A][B][?][?] [C][D][?][?] [?]...
  // zip: [A][B][?][?] [?][?][?][?] [C][D][?][?] [?][?][?][?]
  // mem: [A][B][C][D]
  def : Pat<(store (nxv2f32 ZPR:$Zs), (i64 GPR64:$base)),
            (ST1W_D_IMM ZPR:$Zs, (PTRUE_D 31), GPR64:$base, (i64 0))>;


  def : Pat<(nxv16i1 (and PPR:$Ps1, PPR:$Ps2)),
            (AND_PPzPP (PTRUE_B 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv8i1 (and PPR:$Ps1, PPR:$Ps2)),
            (AND_PPzPP (PTRUE_H 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv4i1 (and PPR:$Ps1, PPR:$Ps2)),
            (AND_PPzPP (PTRUE_S 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv2i1 (and PPR:$Ps1, PPR:$Ps2)),
            (AND_PPzPP (PTRUE_D 31), PPR:$Ps1, PPR:$Ps2)>;

  def : Pat<(nxv2i1 (and (nxv2i1 (and PPR:$Ps1, PPR:$Ps2)), PPR:$Ps3)),
            (AND_PPzPP PPR:$Ps1, PPR:$Ps2, PPR:$Ps3)>;
  def : Pat<(nxv2i1 (and PPR:$Ps1, (nxv2i1 (and PPR:$Ps2, PPR:$Ps3)))),
            (AND_PPzPP PPR:$Ps1, PPR:$Ps2, PPR:$Ps3)>;

  def : Pat<(nxv16i1 (or PPR:$Ps1, PPR:$Ps2)),
            (ORR_PPzPP (PTRUE_B 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv8i1 (or PPR:$Ps1, PPR:$Ps2)),
            (ORR_PPzPP (PTRUE_H 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv4i1 (or PPR:$Ps1, PPR:$Ps2)),
            (ORR_PPzPP (PTRUE_S 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv2i1 (or PPR:$Ps1, PPR:$Ps2)),
            (ORR_PPzPP (PTRUE_D 31), PPR:$Ps1, PPR:$Ps2)>;

  def : Pat<(nxv16i1 (xor PPR:$Ps1, PPR:$Ps2)),
            (EOR_PPzPP (PTRUE_B 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv8i1 (xor PPR:$Ps1, PPR:$Ps2)),
            (EOR_PPzPP (PTRUE_H 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv4i1 (xor PPR:$Ps1, PPR:$Ps2)),
            (EOR_PPzPP (PTRUE_S 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv2i1 (xor PPR:$Ps1, PPR:$Ps2)),
            (EOR_PPzPP (PTRUE_D 31), PPR:$Ps1, PPR:$Ps2)>;

  // Floating point compares
  defm FCMGE_PPzZZ : sve_fp_3op_p_pd<0b000, "fcmge", int_aarch64_sve_cmpge, AArch64fcmge>;
  defm FCMGT_PPzZZ : sve_fp_3op_p_pd<0b001, "fcmgt", int_aarch64_sve_cmpgt, AArch64fcmgt>;
  defm FCMEQ_PPzZZ : sve_fp_3op_p_pd<0b010, "fcmeq", int_aarch64_sve_cmpeq, AArch64fcmeq>;
  defm FCMNE_PPzZZ : sve_fp_3op_p_pd<0b011, "fcmne", int_aarch64_sve_cmpne>;
  defm FCMUO_PPzZZ : sve_fp_3op_p_pd<0b100, "fcmuo", int_aarch64_sve_cmpuo>;
  defm FACGE_PPzZZ : sve_fp_3op_p_pd<0b101, "facge", int_aarch64_sve_acge>;
  defm FACGT_PPzZZ : sve_fp_3op_p_pd<0b111, "facgt", int_aarch64_sve_acgt>;

  defm FCMGE_PPzZ0 : sve_fp_2op_p_pd<0b000, "fcmge", int_aarch64_sve_cmpge, AArch64fcmge>;
  defm FCMGT_PPzZ0 : sve_fp_2op_p_pd<0b001, "fcmgt", int_aarch64_sve_cmpgt, AArch64fcmgt>;
  defm FCMLT_PPzZ0 : sve_fp_2op_p_pd<0b010, "fcmlt", null_frag, null_frag, int_aarch64_sve_cmpgt, AArch64fcmgt>;
  defm FCMLE_PPzZ0 : sve_fp_2op_p_pd<0b011, "fcmle", null_frag, null_frag, int_aarch64_sve_cmpge, AArch64fcmge>;
  defm FCMEQ_PPzZ0 : sve_fp_2op_p_pd<0b100, "fcmeq", int_aarch64_sve_cmpeq, AArch64fcmeq>;
  defm FCMNE_PPzZ0 : sve_fp_2op_p_pd<0b110, "fcmne", int_aarch64_sve_cmpne>;

  // UNE compares
  def : Pat<(nxv4i1 (AArch64not (AArch64fcmeq (nxv4f32 ZPR:$Zs1), (nxv4f32 ZPR:$Zs2)))),
            (FCMNE_PPzZZ_S (PTRUE_S 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i1 (AArch64not (AArch64fcmeq (nxv2f64 ZPR:$Zs1), (nxv2f64 ZPR:$Zs2)))),
            (FCMNE_PPzZZ_D (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;

  // Extract lo/hi halves of legal predicate types.
  def : Pat<(nxv2i1 (extract_subvector (nxv4i1 PPR:$Ps), (i64 0))),
            (ZIP1_PPP_S PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv2i1 (extract_subvector (nxv4i1 PPR:$Ps), (i64 2))),
            (ZIP2_PPP_S PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv4i1 (extract_subvector (nxv8i1 PPR:$Ps), (i64 0))),
            (ZIP1_PPP_H PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv4i1 (extract_subvector (nxv8i1 PPR:$Ps), (i64 4))),
            (ZIP2_PPP_H PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv8i1 (extract_subvector (nxv16i1 PPR:$Ps), (i64 0))),
            (ZIP1_PPP_B PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv8i1 (extract_subvector (nxv16i1 PPR:$Ps), (i64 8))),
            (ZIP2_PPP_B PPR:$Ps, (PFALSE))>;

  def : Pat<(nxv2f32 (extract_subvector (nxv4f32 ZPR:$Zs), (i64 0))),
            (UUNPKLO_ZZ_D ZPR:$Zs)>;
  def : Pat<(nxv2f32 (extract_subvector (nxv4f32 ZPR:$Zs), (i64 2))),
            (UUNPKHI_ZZ_D ZPR:$Zs)>;

  def ADR_SXTW_ZZZ_D : sve_int_bin_cons_misc_0_a<0b00, "adr", ".d", sve_adr_sxtw>;
  def ADR_UXTW_ZZZ_D : sve_int_bin_cons_misc_0_a<0b01, "adr", ".d", sve_adr_uxtw>;
  def ADR_LSL_ZZZ_S  : sve_int_bin_cons_misc_0_a<0b10, "adr", ".s", sve_adr_shift>;
  def ADR_LSL_ZZZ_D  : sve_int_bin_cons_misc_0_a<0b11, "adr", ".d", sve_adr_shift>;

  def : Pat<(nxv2i64 (add (nxv2i64 ZPR:$Zn), (nxv2i64LslBy3 (nxv2i64 ZPR:$Zm)))),
            (ADR_LSL_ZZZ_D ZPR:$Zn, ZPR:$Zm, 3)>;
  def : Pat<(nxv2i64 (add (nxv2i64LslBy3 (nxv2i64 ZPR:$Zm)), (nxv2i64 ZPR:$Zn))),
            (ADR_LSL_ZZZ_D ZPR:$Zn, ZPR:$Zm, 3)>;

  defm PRFB_PRI : sve_mem_prfm_si<0b00, "prfb">;
  defm PRFH_PRI : sve_mem_prfm_si<0b01, "prfh">;
  defm PRFW_PRI : sve_mem_prfm_si<0b10, "prfw">;
  defm PRFD_PRI : sve_mem_prfm_si<0b11, "prfd">;

  def PRFB_PRR : sve_mem_prfm_ss_b<0b001, "prfb">;
  def PRFH_PRR : sve_mem_prfm_ss<0b011, "prfh", ", lsl #1">;
  def PRFS_PRR : sve_mem_prfm_ss<0b101, "prfw", ", lsl #2">;
  def PRFD_PRR : sve_mem_prfm_ss<0b111, "prfd", ", lsl #3">;

  defm PRFB_S_PZI : sve_mem_32b_prfm_vi<0b00, "prfb", imm0_31>;
  defm PRFH_S_PZI : sve_mem_32b_prfm_vi<0b01, "prfh", uimm5s2>;
  defm PRFW_S_PZI : sve_mem_32b_prfm_vi<0b10, "prfw", uimm5s4>;
  defm PRFD_S_PZI : sve_mem_32b_prfm_vi<0b11, "prfd", uimm5s8>;

  defm PRFB_D_PZI : sve_mem_64b_prfm_vi<0b00, "prfb", imm0_31>;
  defm PRFH_D_PZI : sve_mem_64b_prfm_vi<0b01, "prfh", uimm5s2>;
  defm PRFW_D_PZI : sve_mem_64b_prfm_vi<0b10, "prfw", uimm5s4>;
  defm PRFD_D_PZI : sve_mem_64b_prfm_vi<0b11, "prfd", uimm5s8>;

  def PRFB_S_UXTW        : sve_mem_32b_prfm_sv<0b000, "prfb", ", uxtw">;
  def PRFH_S_UXTW_SCALED : sve_mem_32b_prfm_sv<0b001, "prfh", ", uxtw #1">;
  def PRFW_S_UXTW_SCALED : sve_mem_32b_prfm_sv<0b010, "prfw", ", uxtw #2">;
  def PRFD_S_UXTW_SCALED : sve_mem_32b_prfm_sv<0b011, "prfd", ", uxtw #3">;
  def PRFB_S_SXTW        : sve_mem_32b_prfm_sv<0b100, "prfb", ", sxtw">;
  def PRFH_S_SXTW_SCALED : sve_mem_32b_prfm_sv<0b101, "prfh", ", sxtw #1">;
  def PRFW_S_SXTW_SCALED : sve_mem_32b_prfm_sv<0b110, "prfw", ", sxtw #2">;
  def PRFD_S_SXTW_SCALED : sve_mem_32b_prfm_sv<0b111, "prfd", ", sxtw #3">;

  def PRFB_D_UXTW        : sve_mem_64b_prfm_sv<0b000, "prfb", ", uxtw">;
  def PRFH_D_UXTW_SCALED : sve_mem_64b_prfm_sv<0b001, "prfh", ", uxtw #1">;
  def PRFW_D_UXTW_SCALED : sve_mem_64b_prfm_sv<0b010, "prfw", ", uxtw #2">;
  def PRFD_D_UXTW_SCALED : sve_mem_64b_prfm_sv<0b011, "prfd", ", uxtw #3">;
  def PRFB_D_SXTW        : sve_mem_64b_prfm_sv<0b100, "prfb", ", sxtw">;
  def PRFH_D_SXTW_SCALED : sve_mem_64b_prfm_sv<0b101, "prfh", ", sxtw #1">;
  def PRFW_D_SXTW_SCALED : sve_mem_64b_prfm_sv<0b110, "prfw", ", sxtw #2">;
  def PRFD_D_SXTW_SCALED : sve_mem_64b_prfm_sv<0b111, "prfd", ", sxtw #3">;

  def PRFB_D_UNSCALED : sve_mem_64b_prfm_sv2<0b00, "prfb", "">;
  def PRFH_D_UNSCALED : sve_mem_64b_prfm_sv2<0b01, "prfh", ", lsl #1">;
  def PRFW_D_UNSCALED : sve_mem_64b_prfm_sv2<0b10, "prfw", ", lsl #2">;
  def PRFD_D_UNSCALED : sve_mem_64b_prfm_sv2<0b11, "prfd", ", lsl #3">;

  defm LDNT1B_ZRI : sve_mem_cldnt_si<0b00, "ldnt1b", "b">;
  defm LDNT1H_ZRI : sve_mem_cldnt_si<0b01, "ldnt1h", "h">;
  defm LDNT1W_ZRI : sve_mem_cldnt_si<0b10, "ldnt1w", "s">;
  defm LDNT1D_ZRI : sve_mem_cldnt_si<0b11, "ldnt1d", "d">;

  defm LDNT1B_ZRR : sve_mem_cldnt_ss_b<0b001, "ldnt1b", "b">;
  defm LDNT1H_ZRR : sve_mem_cldnt_ss<  0b011, "ldnt1h", "h", ", lsl #1">;
  defm LDNT1W_ZRR : sve_mem_cldnt_ss<  0b101, "ldnt1w", "s", ", lsl #2">;
  defm LDNT1D_ZRR : sve_mem_cldnt_ss<  0b111, "ldnt1d", "d", ", lsl #3">;

  defm STNT1B_ZRI : sve_mem_cstnt_si<0b00, "stnt1b", "b">;
  defm STNT1H_ZRI : sve_mem_cstnt_si<0b01, "stnt1h", "h">;
  defm STNT1W_ZRI : sve_mem_cstnt_si<0b10, "stnt1w", "s">;
  defm STNT1D_ZRI : sve_mem_cstnt_si<0b11, "stnt1d", "d">;

  defm STNT1B_ZRR : sve_mem_cstnt_ss_b<0b001, "stnt1b", "b">;
  defm STNT1H_ZRR : sve_mem_cstnt_ss<  0b011, "stnt1h", "h", ", lsl #1">;
  defm STNT1W_ZRR : sve_mem_cstnt_ss<  0b101, "stnt1w", "s", ", lsl #2">;
  defm STNT1D_ZRR : sve_mem_cstnt_ss<  0b111, "stnt1d", "d", ", lsl #3">;


  def : InstAlias<"adr $Zd.s, [$Zn.s, $Zm.s]",
                  (ADR_LSL_ZZZ_S ZPROp:$Zd, ZPROp:$Zn, ZPROp:$Zm, 0b00), 1>;
  def : InstAlias<"adr $Zd.d, [$Zn.d, $Zm.d]",
                  (ADR_LSL_ZZZ_D ZPROp:$Zd, ZPROp:$Zn, ZPROp:$Zm, 0b00), 1>;

  def : InstAlias<"cmple $Zd.b, $Pg/z, $Zm.b, $Zn.b",
                  (CMPGE_PPzZZ_B PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmple $Zd.h, $Pg/z, $Zm.h, $Zn.h",
                  (CMPGE_PPzZZ_H PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmple $Zd.s, $Pg/z, $Zm.s, $Zn.s",
                  (CMPGE_PPzZZ_S PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmple $Zd.d, $Pg/z, $Zm.d, $Zn.d",
                  (CMPGE_PPzZZ_D PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;

  def : InstAlias<"cmplo $Zd.b, $Pg/z, $Zm.b, $Zn.b",
                  (CMPHI_PPzZZ_B PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmplo $Zd.h, $Pg/z, $Zm.h, $Zn.h",
                  (CMPHI_PPzZZ_H PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmplo $Zd.s, $Pg/z, $Zm.s, $Zn.s",
                  (CMPHI_PPzZZ_S PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmplo $Zd.d, $Pg/z, $Zm.d, $Zn.d",
                  (CMPHI_PPzZZ_D PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;

  def : InstAlias<"cmpls $Zd.b, $Pg/z, $Zm.b, $Zn.b",
                  (CMPHS_PPzZZ_B PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmpls $Zd.h, $Pg/z, $Zm.h, $Zn.h",
                  (CMPHS_PPzZZ_H PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmpls $Zd.s, $Pg/z, $Zm.s, $Zn.s",
                  (CMPHS_PPzZZ_S PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmpls $Zd.d, $Pg/z, $Zm.d, $Zn.d",
                  (CMPHS_PPzZZ_D PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;

  def : InstAlias<"cmplt $Zd.b, $Pg/z, $Zm.b, $Zn.b",
                  (CMPGT_PPzZZ_B PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmplt $Zd.h, $Pg/z, $Zm.h, $Zn.h",
                  (CMPGT_PPzZZ_H PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmplt $Zd.s, $Pg/z, $Zm.s, $Zn.s",
                  (CMPGT_PPzZZ_S PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"cmplt $Zd.d, $Pg/z, $Zm.d, $Zn.d",
                  (CMPGT_PPzZZ_D PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;

  def : InstAlias<"mov $Zd.d, $Zn.d",
                  (ORR_ZZZ ZPROp:$Zd, ZPROp:$Zn, ZPROp:$Zn), 1>;

  def : InstAlias<"mov $Pd.b, $Pn.b",
                  (ORR_PPzPP PPROp:$Pd, PPROp:$Pn, PPROp:$Pn, PPROp:$Pn), 1>;
  def : InstAlias<"mov $Pd.b, $Pg/z, $Pn.b",
                  (AND_PPzPP PPROp:$Pd, PPROp:$Pg, PPROp:$Pn, PPROp:$Pn), 1>;
  def : InstAlias<"mov $Pd.b, $Pg/m, $Pn.b",
                  (SEL_PPPP PPROp:$Pd, PPROp:$Pg, PPROp:$Pn, PPROp:$Pd), 1>;

  def : InstAlias<"movs $Pd.b, $Pn.b",
                  (ORRS_PPzPP PPROp:$Pd, PPROp:$Pn, PPROp:$Pn, PPROp:$Pn), 1>;
  def : InstAlias<"movs $Pd.b, $Pg/z, $Pn.b",
                  (ANDS_PPzPP PPROp:$Pd, PPROp:$Pg, PPROp:$Pn, PPROp:$Pn), 1>;

  def : InstAlias<"not $Pd.b, $Pg/z, $Pn.b",
                  (EOR_PPzPP PPROp:$Pd, PPROp:$Pg, PPROp:$Pn, PPROp:$Pg), 1>;

  def : InstAlias<"nots $Pd.b, $Pg/z, $Pn.b",
                  (EORS_PPzPP PPROp:$Pd, PPROp:$Pg, PPROp:$Pn, PPROp:$Pg), 1>;

  def : InstAlias<"facle $Zd.s, $Pg/z, $Zm.s, $Zn.s",
                  (FACGE_PPzZZ_S PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"facle $Zd.d, $Pg/z, $Zm.d, $Zn.d",
                  (FACGE_PPzZZ_D PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;

  def : InstAlias<"faclt $Zd.s, $Pg/z, $Zm.s, $Zn.s",
                  (FACGT_PPzZZ_S PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"faclt $Zd.d, $Pg/z, $Zm.d, $Zn.d",
                  (FACGT_PPzZZ_D PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;

  def : InstAlias<"fcmle $Zd.s, $Pg/z, $Zm.s, $Zn.s",
                  (FCMGE_PPzZZ_S PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"fcmle $Zd.d, $Pg/z, $Zm.d, $Zn.d",
                  (FCMGE_PPzZZ_D PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;

  def : InstAlias<"fcmlt $Zd.s, $Pg/z, $Zm.s, $Zn.s",
                  (FCMGT_PPzZZ_S PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<"fcmlt $Zd.d, $Pg/z, $Zm.d, $Zn.d",
                  (FCMGT_PPzZZ_D PPROp:$Zd, PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm), 0>;

  defm : pred_load<nxv16i8, nxv16i1, AArch64ldnt1, LDNT1B_ZRR, LDNT1B_ZRI, SVEAddrModeRegReg8>;
  defm : pred_load<nxv8i16,  nxv8i1, AArch64ldnt1, LDNT1H_ZRR, LDNT1H_ZRI, SVEAddrModeRegReg16>;
  defm : pred_load<nxv4i32,  nxv4i1, AArch64ldnt1, LDNT1W_ZRR, LDNT1W_ZRI, SVEAddrModeRegReg32>;
  defm : pred_load<nxv2i64,  nxv2i1, AArch64ldnt1, LDNT1D_ZRR, LDNT1D_ZRI, SVEAddrModeRegReg64>;

  defm : pred_store<nxv16i8, nxv16i1, AArch64stnt1, STNT1B_ZRR, STNT1B_ZRI, SVEAddrModeRegReg8>;
  defm : pred_store<nxv8i16,  nxv8i1, AArch64stnt1, STNT1H_ZRR, STNT1H_ZRI, SVEAddrModeRegReg16>;
  defm : pred_store<nxv4i32,  nxv4i1, AArch64stnt1, STNT1W_ZRR, STNT1W_ZRI, SVEAddrModeRegReg32>;
  defm : pred_store<nxv2i64,  nxv2i1, AArch64stnt1, STNT1D_ZRR, STNT1D_ZRI, SVEAddrModeRegReg64>;
} // Predicates = [HasSVE]

defm ADD     : SIMDThreeSameVector<0, 0b10000, "add", add>;
defm ADDP    : SIMDThreeSameVector<0, 0b10111, "addp", int_aarch64_neon_addp>;
defm CMEQ    : SIMDThreeSameVector<1, 0b10001, "cmeq", AArch64cmeq>;
defm CMGE    : SIMDThreeSameVector<0, 0b00111, "cmge", AArch64cmge>;
defm CMGT    : SIMDThreeSameVector<0, 0b00110, "cmgt", AArch64cmgt>;
defm CMHI    : SIMDThreeSameVector<1, 0b00110, "cmhi", AArch64cmhi>;
defm CMHS    : SIMDThreeSameVector<1, 0b00111, "cmhs", AArch64cmhs>;
defm CMTST   : SIMDThreeSameVector<0, 0b10001, "cmtst", AArch64cmtst>;
defm FABD    : SIMDThreeSameVectorFP<1,1,0b010,"fabd", int_aarch64_neon_fabd>;
defm FACGE   : SIMDThreeSameVectorFPCmp<1,0,0b101,"facge",int_aarch64_neon_facge>;
defm FACGT   : SIMDThreeSameVectorFPCmp<1,1,0b101,"facgt",int_aarch64_neon_facgt>;
defm FADDP   : SIMDThreeSameVectorFP<1,0,0b010,"faddp",int_aarch64_neon_addp>;
defm FADD    : SIMDThreeSameVectorFP<0,0,0b010,"fadd", fadd>;
defm FCMEQ   : SIMDThreeSameVectorFPCmp<0, 0, 0b100, "fcmeq", AArch64fcmeq>;
defm FCMGE   : SIMDThreeSameVectorFPCmp<1, 0, 0b100, "fcmge", AArch64fcmge>;
defm FCMGT   : SIMDThreeSameVectorFPCmp<1, 1, 0b100, "fcmgt", AArch64fcmgt>;
defm FDIV    : SIMDThreeSameVectorFP<1,0,0b111,"fdiv", fdiv>;
defm FMAXNMP : SIMDThreeSameVectorFP<1,0,0b000,"fmaxnmp", int_aarch64_neon_fmaxnmp>;
defm FMAXNM  : SIMDThreeSameVectorFP<0,0,0b000,"fmaxnm", fmaxnum>;
defm FMAXP   : SIMDThreeSameVectorFP<1,0,0b110,"fmaxp", int_aarch64_neon_fmaxp>;
defm FMAX    : SIMDThreeSameVectorFP<0,0,0b110,"fmax", fmaxnan>;
defm FMINNMP : SIMDThreeSameVectorFP<1,1,0b000,"fminnmp", int_aarch64_neon_fminnmp>;
defm FMINNM  : SIMDThreeSameVectorFP<0,1,0b000,"fminnm", fminnum>;
defm FMINP   : SIMDThreeSameVectorFP<1,1,0b110,"fminp", int_aarch64_neon_fminp>;
defm FMIN    : SIMDThreeSameVectorFP<0,1,0b110,"fmin", fminnan>;

// NOTE: The operands of the PatFrag are reordered on FMLA/FMLS because the
// instruction expects the addend first, while the fma intrinsic puts it last.
defm FMLA     : SIMDThreeSameVectorFPTied<0, 0, 0b001, "fmla",
            TriOpFrag<(fma node:$RHS, node:$MHS, node:$LHS)> >;
defm FMLS     : SIMDThreeSameVectorFPTied<0, 1, 0b001, "fmls",
            TriOpFrag<(fma node:$MHS, (fneg node:$RHS), node:$LHS)> >;

// The following def pats catch the case where the LHS of an FMA is negated.
// The TriOpFrag above catches the case where the middle operand is negated.
def : Pat<(v2f32 (fma (fneg V64:$Rn), V64:$Rm, V64:$Rd)),
          (FMLSv2f32 V64:$Rd, V64:$Rn, V64:$Rm)>;

def : Pat<(v4f32 (fma (fneg V128:$Rn), V128:$Rm, V128:$Rd)),
          (FMLSv4f32 V128:$Rd, V128:$Rn, V128:$Rm)>;

def : Pat<(v2f64 (fma (fneg V128:$Rn), V128:$Rm, V128:$Rd)),
          (FMLSv2f64 V128:$Rd, V128:$Rn, V128:$Rm)>;

defm FMULX    : SIMDThreeSameVectorFP<0,0,0b011,"fmulx", int_aarch64_neon_fmulx>;
defm FMUL     : SIMDThreeSameVectorFP<1,0,0b011,"fmul", fmul>;
defm FRECPS   : SIMDThreeSameVectorFP<0,0,0b111,"frecps", int_aarch64_neon_frecps>;
defm FRSQRTS  : SIMDThreeSameVectorFP<0,1,0b111,"frsqrts", int_aarch64_neon_frsqrts>;
defm FSUB     : SIMDThreeSameVectorFP<0,1,0b010,"fsub", fsub>;
defm MLA      : SIMDThreeSameVectorBHSTied<0, 0b10010, "mla",
                      TriOpFrag<(add node:$LHS, (mul node:$MHS, node:$RHS))> >;
defm MLS      : SIMDThreeSameVectorBHSTied<1, 0b10010, "mls",
                      TriOpFrag<(sub node:$LHS, (mul node:$MHS, node:$RHS))> >;
defm MUL      : SIMDThreeSameVectorBHS<0, 0b10011, "mul", mul>;
defm PMUL     : SIMDThreeSameVectorB<1, 0b10011, "pmul", int_aarch64_neon_pmul>;
defm SABA     : SIMDThreeSameVectorBHSTied<0, 0b01111, "saba",
      TriOpFrag<(add node:$LHS, (int_aarch64_neon_sabd node:$MHS, node:$RHS))> >;
defm SABD     : SIMDThreeSameVectorBHS<0,0b01110,"sabd", int_aarch64_neon_sabd>;
defm SHADD    : SIMDThreeSameVectorBHS<0,0b00000,"shadd", int_aarch64_neon_shadd>;
defm SHSUB    : SIMDThreeSameVectorBHS<0,0b00100,"shsub", int_aarch64_neon_shsub>;
defm SMAXP    : SIMDThreeSameVectorBHS<0,0b10100,"smaxp", int_aarch64_neon_smaxp>;
defm SMAX     : SIMDThreeSameVectorBHS<0,0b01100,"smax", smax>;
defm SMINP    : SIMDThreeSameVectorBHS<0,0b10101,"sminp", int_aarch64_neon_sminp>;
defm SMIN     : SIMDThreeSameVectorBHS<0,0b01101,"smin", smin>;
defm SQADD    : SIMDThreeSameVector<0,0b00001,"sqadd", int_aarch64_neon_sqadd>;
defm SQDMULH  : SIMDThreeSameVectorHS<0,0b10110,"sqdmulh",int_aarch64_neon_sqdmulh>;
defm SQRDMULH : SIMDThreeSameVectorHS<1,0b10110,"sqrdmulh",int_aarch64_neon_sqrdmulh>;
defm SQRSHL   : SIMDThreeSameVector<0,0b01011,"sqrshl", int_aarch64_neon_sqrshl>;
defm SQSHL    : SIMDThreeSameVector<0,0b01001,"sqshl", int_aarch64_neon_sqshl>;
defm SQSUB    : SIMDThreeSameVector<0,0b00101,"sqsub", int_aarch64_neon_sqsub>;
defm SRHADD   : SIMDThreeSameVectorBHS<0,0b00010,"srhadd",int_aarch64_neon_srhadd>;
defm SRSHL    : SIMDThreeSameVector<0,0b01010,"srshl", int_aarch64_neon_srshl>;
defm SSHL     : SIMDThreeSameVector<0,0b01000,"sshl", int_aarch64_neon_sshl>;
defm SUB      : SIMDThreeSameVector<1,0b10000,"sub", sub>;
defm UABA     : SIMDThreeSameVectorBHSTied<1, 0b01111, "uaba",
      TriOpFrag<(add node:$LHS, (int_aarch64_neon_uabd node:$MHS, node:$RHS))> >;
defm UABD     : SIMDThreeSameVectorBHS<1,0b01110,"uabd", int_aarch64_neon_uabd>;
defm UHADD    : SIMDThreeSameVectorBHS<1,0b00000,"uhadd", int_aarch64_neon_uhadd>;
defm UHSUB    : SIMDThreeSameVectorBHS<1,0b00100,"uhsub", int_aarch64_neon_uhsub>;
defm UMAXP    : SIMDThreeSameVectorBHS<1,0b10100,"umaxp", int_aarch64_neon_umaxp>;
defm UMAX     : SIMDThreeSameVectorBHS<1,0b01100,"umax", umax>;
defm UMINP    : SIMDThreeSameVectorBHS<1,0b10101,"uminp", int_aarch64_neon_uminp>;
defm UMIN     : SIMDThreeSameVectorBHS<1,0b01101,"umin", umin>;
defm UQADD    : SIMDThreeSameVector<1,0b00001,"uqadd", int_aarch64_neon_uqadd>;
defm UQRSHL   : SIMDThreeSameVector<1,0b01011,"uqrshl", int_aarch64_neon_uqrshl>;
defm UQSHL    : SIMDThreeSameVector<1,0b01001,"uqshl", int_aarch64_neon_uqshl>;
defm UQSUB    : SIMDThreeSameVector<1,0b00101,"uqsub", int_aarch64_neon_uqsub>;
defm URHADD   : SIMDThreeSameVectorBHS<1,0b00010,"urhadd", int_aarch64_neon_urhadd>;
defm URSHL    : SIMDThreeSameVector<1,0b01010,"urshl", int_aarch64_neon_urshl>;
defm USHL     : SIMDThreeSameVector<1,0b01000,"ushl", int_aarch64_neon_ushl>;
defm SQRDMLAH : SIMDThreeSameVectorSQRDMLxHTiedHS<1,0b10000,"sqrdmlah",
                                                  int_aarch64_neon_sqadd>;
defm SQRDMLSH : SIMDThreeSameVectorSQRDMLxHTiedHS<1,0b10001,"sqrdmlsh",
                                                    int_aarch64_neon_sqsub>;

defm AND : SIMDLogicalThreeVector<0, 0b00, "and", and>;
defm BIC : SIMDLogicalThreeVector<0, 0b01, "bic",
                                  BinOpFrag<(and node:$LHS, (vnot node:$RHS))> >;
defm BIF : SIMDLogicalThreeVector<1, 0b11, "bif">;
defm BIT : SIMDLogicalThreeVectorTied<1, 0b10, "bit", AArch64bit>;
defm BSL : SIMDLogicalThreeVectorTied<1, 0b01, "bsl",
    TriOpFrag<(or (and node:$LHS, node:$MHS), (and (vnot node:$LHS), node:$RHS))>>;
defm EOR : SIMDLogicalThreeVector<1, 0b00, "eor", xor>;
defm ORN : SIMDLogicalThreeVector<0, 0b11, "orn",
                                  BinOpFrag<(or node:$LHS, (vnot node:$RHS))> >;
defm ORR : SIMDLogicalThreeVector<0, 0b10, "orr", or>;


def : Pat<(AArch64bsl (v8i8 V64:$Rd), V64:$Rn, V64:$Rm),
          (BSLv8i8 V64:$Rd, V64:$Rn, V64:$Rm)>;
def : Pat<(AArch64bsl (v4i16 V64:$Rd), V64:$Rn, V64:$Rm),
          (BSLv8i8 V64:$Rd, V64:$Rn, V64:$Rm)>;
def : Pat<(AArch64bsl (v2i32 V64:$Rd), V64:$Rn, V64:$Rm),
          (BSLv8i8 V64:$Rd, V64:$Rn, V64:$Rm)>;
def : Pat<(AArch64bsl (v1i64 V64:$Rd), V64:$Rn, V64:$Rm),
          (BSLv8i8 V64:$Rd, V64:$Rn, V64:$Rm)>;

def : Pat<(AArch64bsl (v16i8 V128:$Rd), V128:$Rn, V128:$Rm),
          (BSLv16i8 V128:$Rd, V128:$Rn, V128:$Rm)>;
def : Pat<(AArch64bsl (v8i16 V128:$Rd), V128:$Rn, V128:$Rm),
          (BSLv16i8 V128:$Rd, V128:$Rn, V128:$Rm)>;
def : Pat<(AArch64bsl (v4i32 V128:$Rd), V128:$Rn, V128:$Rm),
          (BSLv16i8 V128:$Rd, V128:$Rn, V128:$Rm)>;
def : Pat<(AArch64bsl (v2i64 V128:$Rd), V128:$Rn, V128:$Rm),
          (BSLv16i8 V128:$Rd, V128:$Rn, V128:$Rm)>;

def : InstAlias<"mov{\t$dst.16b, $src.16b|.16b\t$dst, $src}",
                (ORRv16i8 V128:$dst, V128:$src, V128:$src), 1>;
def : InstAlias<"mov{\t$dst.8h, $src.8h|.8h\t$dst, $src}",
                (ORRv16i8 V128:$dst, V128:$src, V128:$src), 0>;
def : InstAlias<"mov{\t$dst.4s, $src.4s|.4s\t$dst, $src}",
                (ORRv16i8 V128:$dst, V128:$src, V128:$src), 0>;
def : InstAlias<"mov{\t$dst.2d, $src.2d|.2d\t$dst, $src}",
                (ORRv16i8 V128:$dst, V128:$src, V128:$src), 0>;

def : InstAlias<"mov{\t$dst.8b, $src.8b|.8b\t$dst, $src}",
                (ORRv8i8 V64:$dst, V64:$src, V64:$src), 1>;
def : InstAlias<"mov{\t$dst.4h, $src.4h|.4h\t$dst, $src}",
                (ORRv8i8 V64:$dst, V64:$src, V64:$src), 0>;
def : InstAlias<"mov{\t$dst.2s, $src.2s|.2s\t$dst, $src}",
                (ORRv8i8 V64:$dst, V64:$src, V64:$src), 0>;
def : InstAlias<"mov{\t$dst.1d, $src.1d|.1d\t$dst, $src}",
                (ORRv8i8 V64:$dst, V64:$src, V64:$src), 0>;

def : InstAlias<"{cmls\t$dst.8b, $src1.8b, $src2.8b" #
                "|cmls.8b\t$dst, $src1, $src2}",
                (CMHSv8i8 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmls\t$dst.16b, $src1.16b, $src2.16b" #
                "|cmls.16b\t$dst, $src1, $src2}",
                (CMHSv16i8 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmls\t$dst.4h, $src1.4h, $src2.4h" #
                "|cmls.4h\t$dst, $src1, $src2}",
                (CMHSv4i16 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmls\t$dst.8h, $src1.8h, $src2.8h" #
                "|cmls.8h\t$dst, $src1, $src2}",
                (CMHSv8i16 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmls\t$dst.2s, $src1.2s, $src2.2s" #
                "|cmls.2s\t$dst, $src1, $src2}",
                (CMHSv2i32 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmls\t$dst.4s, $src1.4s, $src2.4s" #
                "|cmls.4s\t$dst, $src1, $src2}",
                (CMHSv4i32 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmls\t$dst.2d, $src1.2d, $src2.2d" #
                "|cmls.2d\t$dst, $src1, $src2}",
                (CMHSv2i64 V128:$dst, V128:$src2, V128:$src1), 0>;

def : InstAlias<"{cmlo\t$dst.8b, $src1.8b, $src2.8b" #
                "|cmlo.8b\t$dst, $src1, $src2}",
                (CMHIv8i8 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmlo\t$dst.16b, $src1.16b, $src2.16b" #
                "|cmlo.16b\t$dst, $src1, $src2}",
                (CMHIv16i8 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmlo\t$dst.4h, $src1.4h, $src2.4h" #
                "|cmlo.4h\t$dst, $src1, $src2}",
                (CMHIv4i16 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmlo\t$dst.8h, $src1.8h, $src2.8h" #
                "|cmlo.8h\t$dst, $src1, $src2}",
                (CMHIv8i16 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmlo\t$dst.2s, $src1.2s, $src2.2s" #
                "|cmlo.2s\t$dst, $src1, $src2}",
                (CMHIv2i32 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmlo\t$dst.4s, $src1.4s, $src2.4s" #
                "|cmlo.4s\t$dst, $src1, $src2}",
                (CMHIv4i32 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmlo\t$dst.2d, $src1.2d, $src2.2d" #
                "|cmlo.2d\t$dst, $src1, $src2}",
                (CMHIv2i64 V128:$dst, V128:$src2, V128:$src1), 0>;

def : InstAlias<"{cmle\t$dst.8b, $src1.8b, $src2.8b" #
                "|cmle.8b\t$dst, $src1, $src2}",
                (CMGEv8i8 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmle\t$dst.16b, $src1.16b, $src2.16b" #
                "|cmle.16b\t$dst, $src1, $src2}",
                (CMGEv16i8 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmle\t$dst.4h, $src1.4h, $src2.4h" #
                "|cmle.4h\t$dst, $src1, $src2}",
                (CMGEv4i16 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmle\t$dst.8h, $src1.8h, $src2.8h" #
                "|cmle.8h\t$dst, $src1, $src2}",
                (CMGEv8i16 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmle\t$dst.2s, $src1.2s, $src2.2s" #
                "|cmle.2s\t$dst, $src1, $src2}",
                (CMGEv2i32 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmle\t$dst.4s, $src1.4s, $src2.4s" #
                "|cmle.4s\t$dst, $src1, $src2}",
                (CMGEv4i32 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmle\t$dst.2d, $src1.2d, $src2.2d" #
                "|cmle.2d\t$dst, $src1, $src2}",
                (CMGEv2i64 V128:$dst, V128:$src2, V128:$src1), 0>;

def : InstAlias<"{cmlt\t$dst.8b, $src1.8b, $src2.8b" #
                "|cmlt.8b\t$dst, $src1, $src2}",
                (CMGTv8i8 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmlt\t$dst.16b, $src1.16b, $src2.16b" #
                "|cmlt.16b\t$dst, $src1, $src2}",
                (CMGTv16i8 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmlt\t$dst.4h, $src1.4h, $src2.4h" #
                "|cmlt.4h\t$dst, $src1, $src2}",
                (CMGTv4i16 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmlt\t$dst.8h, $src1.8h, $src2.8h" #
                "|cmlt.8h\t$dst, $src1, $src2}",
                (CMGTv8i16 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmlt\t$dst.2s, $src1.2s, $src2.2s" #
                "|cmlt.2s\t$dst, $src1, $src2}",
                (CMGTv2i32 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{cmlt\t$dst.4s, $src1.4s, $src2.4s" #
                "|cmlt.4s\t$dst, $src1, $src2}",
                (CMGTv4i32 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{cmlt\t$dst.2d, $src1.2d, $src2.2d" #
                "|cmlt.2d\t$dst, $src1, $src2}",
                (CMGTv2i64 V128:$dst, V128:$src2, V128:$src1), 0>;

let Predicates = [HasNEON, HasFullFP16] in {
def : InstAlias<"{fcmle\t$dst.4h, $src1.4h, $src2.4h" #
                "|fcmle.4h\t$dst, $src1, $src2}",
                (FCMGEv4f16 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{fcmle\t$dst.8h, $src1.8h, $src2.8h" #
                "|fcmle.8h\t$dst, $src1, $src2}",
                (FCMGEv8f16 V128:$dst, V128:$src2, V128:$src1), 0>;
}
def : InstAlias<"{fcmle\t$dst.2s, $src1.2s, $src2.2s" #
                "|fcmle.2s\t$dst, $src1, $src2}",
                (FCMGEv2f32 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{fcmle\t$dst.4s, $src1.4s, $src2.4s" #
                "|fcmle.4s\t$dst, $src1, $src2}",
                (FCMGEv4f32 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{fcmle\t$dst.2d, $src1.2d, $src2.2d" #
                "|fcmle.2d\t$dst, $src1, $src2}",
                (FCMGEv2f64 V128:$dst, V128:$src2, V128:$src1), 0>;

let Predicates = [HasNEON, HasFullFP16] in {
def : InstAlias<"{fcmlt\t$dst.4h, $src1.4h, $src2.4h" #
                "|fcmlt.4h\t$dst, $src1, $src2}",
                (FCMGTv4f16 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{fcmlt\t$dst.8h, $src1.8h, $src2.8h" #
                "|fcmlt.8h\t$dst, $src1, $src2}",
                (FCMGTv8f16 V128:$dst, V128:$src2, V128:$src1), 0>;
}
def : InstAlias<"{fcmlt\t$dst.2s, $src1.2s, $src2.2s" #
                "|fcmlt.2s\t$dst, $src1, $src2}",
                (FCMGTv2f32 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{fcmlt\t$dst.4s, $src1.4s, $src2.4s" #
                "|fcmlt.4s\t$dst, $src1, $src2}",
                (FCMGTv4f32 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{fcmlt\t$dst.2d, $src1.2d, $src2.2d" #
                "|fcmlt.2d\t$dst, $src1, $src2}",
                (FCMGTv2f64 V128:$dst, V128:$src2, V128:$src1), 0>;

let Predicates = [HasNEON, HasFullFP16] in {
def : InstAlias<"{facle\t$dst.4h, $src1.4h, $src2.4h" #
                "|facle.4h\t$dst, $src1, $src2}",
                (FACGEv4f16 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{facle\t$dst.8h, $src1.8h, $src2.8h" #
                "|facle.8h\t$dst, $src1, $src2}",
                (FACGEv8f16 V128:$dst, V128:$src2, V128:$src1), 0>;
}
def : InstAlias<"{facle\t$dst.2s, $src1.2s, $src2.2s" #
                "|facle.2s\t$dst, $src1, $src2}",
                (FACGEv2f32 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{facle\t$dst.4s, $src1.4s, $src2.4s" #
                "|facle.4s\t$dst, $src1, $src2}",
                (FACGEv4f32 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{facle\t$dst.2d, $src1.2d, $src2.2d" #
                "|facle.2d\t$dst, $src1, $src2}",
                (FACGEv2f64 V128:$dst, V128:$src2, V128:$src1), 0>;

let Predicates = [HasNEON, HasFullFP16] in {
def : InstAlias<"{faclt\t$dst.4h, $src1.4h, $src2.4h" #
                "|faclt.4h\t$dst, $src1, $src2}",
                (FACGTv4f16 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{faclt\t$dst.8h, $src1.8h, $src2.8h" #
                "|faclt.8h\t$dst, $src1, $src2}",
                (FACGTv8f16 V128:$dst, V128:$src2, V128:$src1), 0>;
}
def : InstAlias<"{faclt\t$dst.2s, $src1.2s, $src2.2s" #
                "|faclt.2s\t$dst, $src1, $src2}",
                (FACGTv2f32 V64:$dst, V64:$src2, V64:$src1), 0>;
def : InstAlias<"{faclt\t$dst.4s, $src1.4s, $src2.4s" #
                "|faclt.4s\t$dst, $src1, $src2}",
                (FACGTv4f32 V128:$dst, V128:$src2, V128:$src1), 0>;
def : InstAlias<"{faclt\t$dst.2d, $src1.2d, $src2.2d" #
                "|faclt.2d\t$dst, $src1, $src2}",
                (FACGTv2f64 V128:$dst, V128:$src2, V128:$src1), 0>;

//===----------------------------------------------------------------------===//
// Advanced SIMD three scalar instructions.
//===----------------------------------------------------------------------===//

defm ADD      : SIMDThreeScalarD<0, 0b10000, "add", add>;
defm CMEQ     : SIMDThreeScalarD<1, 0b10001, "cmeq", AArch64cmeq>;
defm CMGE     : SIMDThreeScalarD<0, 0b00111, "cmge", AArch64cmge>;
defm CMGT     : SIMDThreeScalarD<0, 0b00110, "cmgt", AArch64cmgt>;
defm CMHI     : SIMDThreeScalarD<1, 0b00110, "cmhi", AArch64cmhi>;
defm CMHS     : SIMDThreeScalarD<1, 0b00111, "cmhs", AArch64cmhs>;
defm CMTST    : SIMDThreeScalarD<0, 0b10001, "cmtst", AArch64cmtst>;
defm FABD     : SIMDFPThreeScalar<1, 1, 0b010, "fabd", int_aarch64_sisd_fabd>;
def : Pat<(v1f64 (int_aarch64_neon_fabd (v1f64 FPR64:$Rn), (v1f64 FPR64:$Rm))),
          (FABD64 FPR64:$Rn, FPR64:$Rm)>;
defm FACGE    : SIMDThreeScalarFPCmp<1, 0, 0b101, "facge",
                                     int_aarch64_neon_facge>;
defm FACGT    : SIMDThreeScalarFPCmp<1, 1, 0b101, "facgt",
                                     int_aarch64_neon_facgt>;
defm FCMEQ    : SIMDThreeScalarFPCmp<0, 0, 0b100, "fcmeq", AArch64fcmeq>;
defm FCMGE    : SIMDThreeScalarFPCmp<1, 0, 0b100, "fcmge", AArch64fcmge>;
defm FCMGT    : SIMDThreeScalarFPCmp<1, 1, 0b100, "fcmgt", AArch64fcmgt>;
defm FMULX    : SIMDFPThreeScalar<0, 0, 0b011, "fmulx", int_aarch64_neon_fmulx>;
defm FRECPS   : SIMDFPThreeScalar<0, 0, 0b111, "frecps", int_aarch64_neon_frecps>;
defm FRSQRTS  : SIMDFPThreeScalar<0, 1, 0b111, "frsqrts", int_aarch64_neon_frsqrts>;
defm SQADD    : SIMDThreeScalarBHSD<0, 0b00001, "sqadd", int_aarch64_neon_sqadd>;
defm SQDMULH  : SIMDThreeScalarHS<  0, 0b10110, "sqdmulh", int_aarch64_neon_sqdmulh>;
defm SQRDMULH : SIMDThreeScalarHS<  1, 0b10110, "sqrdmulh", int_aarch64_neon_sqrdmulh>;
defm SQRSHL   : SIMDThreeScalarBHSD<0, 0b01011, "sqrshl",int_aarch64_neon_sqrshl>;
defm SQSHL    : SIMDThreeScalarBHSD<0, 0b01001, "sqshl", int_aarch64_neon_sqshl>;
defm SQSUB    : SIMDThreeScalarBHSD<0, 0b00101, "sqsub", int_aarch64_neon_sqsub>;
defm SRSHL    : SIMDThreeScalarD<   0, 0b01010, "srshl", int_aarch64_neon_srshl>;
defm SSHL     : SIMDThreeScalarD<   0, 0b01000, "sshl", int_aarch64_neon_sshl>;
defm SUB      : SIMDThreeScalarD<   1, 0b10000, "sub", sub>;
defm UQADD    : SIMDThreeScalarBHSD<1, 0b00001, "uqadd", int_aarch64_neon_uqadd>;
defm UQRSHL   : SIMDThreeScalarBHSD<1, 0b01011, "uqrshl",int_aarch64_neon_uqrshl>;
defm UQSHL    : SIMDThreeScalarBHSD<1, 0b01001, "uqshl", int_aarch64_neon_uqshl>;
defm UQSUB    : SIMDThreeScalarBHSD<1, 0b00101, "uqsub", int_aarch64_neon_uqsub>;
defm URSHL    : SIMDThreeScalarD<   1, 0b01010, "urshl", int_aarch64_neon_urshl>;
defm USHL     : SIMDThreeScalarD<   1, 0b01000, "ushl", int_aarch64_neon_ushl>;
let Predicates = [HasV8_1a] in {
  defm SQRDMLAH : SIMDThreeScalarHSTied<1, 0, 0b10000, "sqrdmlah">;
  defm SQRDMLSH : SIMDThreeScalarHSTied<1, 0, 0b10001, "sqrdmlsh">;
  def : Pat<(i32 (int_aarch64_neon_sqadd
                   (i32 FPR32:$Rd),
                   (i32 (int_aarch64_neon_sqrdmulh (i32 FPR32:$Rn),
                                                   (i32 FPR32:$Rm))))),
            (SQRDMLAHv1i32 FPR32:$Rd, FPR32:$Rn, FPR32:$Rm)>;
  def : Pat<(i32 (int_aarch64_neon_sqsub
                   (i32 FPR32:$Rd),
                   (i32 (int_aarch64_neon_sqrdmulh (i32 FPR32:$Rn),
                                                   (i32 FPR32:$Rm))))),
            (SQRDMLSHv1i32 FPR32:$Rd, FPR32:$Rn, FPR32:$Rm)>;
}

def : InstAlias<"cmls $dst, $src1, $src2",
                (CMHSv1i64 FPR64:$dst, FPR64:$src2, FPR64:$src1), 0>;
def : InstAlias<"cmle $dst, $src1, $src2",
                (CMGEv1i64 FPR64:$dst, FPR64:$src2, FPR64:$src1), 0>;
def : InstAlias<"cmlo $dst, $src1, $src2",
                (CMHIv1i64 FPR64:$dst, FPR64:$src2, FPR64:$src1), 0>;
def : InstAlias<"cmlt $dst, $src1, $src2",
                (CMGTv1i64 FPR64:$dst, FPR64:$src2, FPR64:$src1), 0>;
def : InstAlias<"fcmle $dst, $src1, $src2",
                (FCMGE32 FPR32:$dst, FPR32:$src2, FPR32:$src1), 0>;
def : InstAlias<"fcmle $dst, $src1, $src2",
                (FCMGE64 FPR64:$dst, FPR64:$src2, FPR64:$src1), 0>;
def : InstAlias<"fcmlt $dst, $src1, $src2",
                (FCMGT32 FPR32:$dst, FPR32:$src2, FPR32:$src1), 0>;
def : InstAlias<"fcmlt $dst, $src1, $src2",
                (FCMGT64 FPR64:$dst, FPR64:$src2, FPR64:$src1), 0>;
def : InstAlias<"facle $dst, $src1, $src2",
                (FACGE32 FPR32:$dst, FPR32:$src2, FPR32:$src1), 0>;
def : InstAlias<"facle $dst, $src1, $src2",
                (FACGE64 FPR64:$dst, FPR64:$src2, FPR64:$src1), 0>;
def : InstAlias<"faclt $dst, $src1, $src2",
                (FACGT32 FPR32:$dst, FPR32:$src2, FPR32:$src1), 0>;
def : InstAlias<"faclt $dst, $src1, $src2",
                (FACGT64 FPR64:$dst, FPR64:$src2, FPR64:$src1), 0>;

//===----------------------------------------------------------------------===//
// Advanced SIMD three scalar instructions (mixed operands).
//===----------------------------------------------------------------------===//
defm SQDMULL  : SIMDThreeScalarMixedHS<0, 0b11010, "sqdmull",
                                       int_aarch64_neon_sqdmulls_scalar>;
defm SQDMLAL  : SIMDThreeScalarMixedTiedHS<0, 0b10010, "sqdmlal">;
defm SQDMLSL  : SIMDThreeScalarMixedTiedHS<0, 0b10110, "sqdmlsl">;

def : Pat<(i64 (int_aarch64_neon_sqadd (i64 FPR64:$Rd),
                   (i64 (int_aarch64_neon_sqdmulls_scalar (i32 FPR32:$Rn),
                                                        (i32 FPR32:$Rm))))),
          (SQDMLALi32 FPR64:$Rd, FPR32:$Rn, FPR32:$Rm)>;
def : Pat<(i64 (int_aarch64_neon_sqsub (i64 FPR64:$Rd),
                   (i64 (int_aarch64_neon_sqdmulls_scalar (i32 FPR32:$Rn),
                                                        (i32 FPR32:$Rm))))),
          (SQDMLSLi32 FPR64:$Rd, FPR32:$Rn, FPR32:$Rm)>;

//===----------------------------------------------------------------------===//
// Advanced SIMD two scalar instructions.
//===----------------------------------------------------------------------===//

defm ABS    : SIMDTwoScalarD<    0, 0b01011, "abs", int_aarch64_neon_abs>;
defm CMEQ   : SIMDCmpTwoScalarD< 0, 0b01001, "cmeq", AArch64cmeqz>;
defm CMGE   : SIMDCmpTwoScalarD< 1, 0b01000, "cmge", AArch64cmgez>;
defm CMGT   : SIMDCmpTwoScalarD< 0, 0b01000, "cmgt", AArch64cmgtz>;
defm CMLE   : SIMDCmpTwoScalarD< 1, 0b01001, "cmle", AArch64cmlez>;
defm CMLT   : SIMDCmpTwoScalarD< 0, 0b01010, "cmlt", AArch64cmltz>;
defm FCMEQ  : SIMDFPCmpTwoScalar<0, 1, 0b01101, "fcmeq", AArch64fcmeqz>;
defm FCMGE  : SIMDFPCmpTwoScalar<1, 1, 0b01100, "fcmge", AArch64fcmgez>;
defm FCMGT  : SIMDFPCmpTwoScalar<0, 1, 0b01100, "fcmgt", AArch64fcmgtz>;
defm FCMLE  : SIMDFPCmpTwoScalar<1, 1, 0b01101, "fcmle", AArch64fcmlez>;
defm FCMLT  : SIMDFPCmpTwoScalar<0, 1, 0b01110, "fcmlt", AArch64fcmltz>;
defm FCVTAS : SIMDFPTwoScalar<   0, 0, 0b11100, "fcvtas">;
defm FCVTAU : SIMDFPTwoScalar<   1, 0, 0b11100, "fcvtau">;
defm FCVTMS : SIMDFPTwoScalar<   0, 0, 0b11011, "fcvtms">;
defm FCVTMU : SIMDFPTwoScalar<   1, 0, 0b11011, "fcvtmu">;
defm FCVTNS : SIMDFPTwoScalar<   0, 0, 0b11010, "fcvtns">;
defm FCVTNU : SIMDFPTwoScalar<   1, 0, 0b11010, "fcvtnu">;
defm FCVTPS : SIMDFPTwoScalar<   0, 1, 0b11010, "fcvtps">;
defm FCVTPU : SIMDFPTwoScalar<   1, 1, 0b11010, "fcvtpu">;
def  FCVTXNv1i64 : SIMDInexactCvtTwoScalar<0b10110, "fcvtxn">;
defm FCVTZS : SIMDFPTwoScalar<   0, 1, 0b11011, "fcvtzs">;
defm FCVTZU : SIMDFPTwoScalar<   1, 1, 0b11011, "fcvtzu">;
defm FRECPE : SIMDFPTwoScalar<   0, 1, 0b11101, "frecpe">;
defm FRECPX : SIMDFPTwoScalar<   0, 1, 0b11111, "frecpx">;
defm FRSQRTE : SIMDFPTwoScalar<  1, 1, 0b11101, "frsqrte">;
defm NEG    : SIMDTwoScalarD<    1, 0b01011, "neg",
                                 UnOpFrag<(sub immAllZerosV, node:$LHS)> >;
defm SCVTF  : SIMDFPTwoScalarCVT<   0, 0, 0b11101, "scvtf", AArch64sitof>;
defm SQABS  : SIMDTwoScalarBHSD< 0, 0b00111, "sqabs", int_aarch64_neon_sqabs>;
defm SQNEG  : SIMDTwoScalarBHSD< 1, 0b00111, "sqneg", int_aarch64_neon_sqneg>;
defm SQXTN  : SIMDTwoScalarMixedBHS< 0, 0b10100, "sqxtn", int_aarch64_neon_scalar_sqxtn>;
defm SQXTUN : SIMDTwoScalarMixedBHS< 1, 0b10010, "sqxtun", int_aarch64_neon_scalar_sqxtun>;
defm SUQADD : SIMDTwoScalarBHSDTied< 0, 0b00011, "suqadd",
                                     int_aarch64_neon_suqadd>;
defm UCVTF  : SIMDFPTwoScalarCVT<   1, 0, 0b11101, "ucvtf", AArch64uitof>;
defm UQXTN  : SIMDTwoScalarMixedBHS<1, 0b10100, "uqxtn", int_aarch64_neon_scalar_uqxtn>;
defm USQADD : SIMDTwoScalarBHSDTied< 1, 0b00011, "usqadd",
                                    int_aarch64_neon_usqadd>;

def : Pat<(AArch64neg (v1i64 V64:$Rn)), (NEGv1i64 V64:$Rn)>;

def : Pat<(v1i64 (int_aarch64_neon_fcvtas (v1f64 FPR64:$Rn))),
          (FCVTASv1i64 FPR64:$Rn)>;
def : Pat<(v1i64 (int_aarch64_neon_fcvtau (v1f64 FPR64:$Rn))),
          (FCVTAUv1i64 FPR64:$Rn)>;
def : Pat<(v1i64 (int_aarch64_neon_fcvtms (v1f64 FPR64:$Rn))),
          (FCVTMSv1i64 FPR64:$Rn)>;
def : Pat<(v1i64 (int_aarch64_neon_fcvtmu (v1f64 FPR64:$Rn))),
          (FCVTMUv1i64 FPR64:$Rn)>;
def : Pat<(v1i64 (int_aarch64_neon_fcvtns (v1f64 FPR64:$Rn))),
          (FCVTNSv1i64 FPR64:$Rn)>;
def : Pat<(v1i64 (int_aarch64_neon_fcvtnu (v1f64 FPR64:$Rn))),
          (FCVTNUv1i64 FPR64:$Rn)>;
def : Pat<(v1i64 (int_aarch64_neon_fcvtps (v1f64 FPR64:$Rn))),
          (FCVTPSv1i64 FPR64:$Rn)>;
def : Pat<(v1i64 (int_aarch64_neon_fcvtpu (v1f64 FPR64:$Rn))),
          (FCVTPUv1i64 FPR64:$Rn)>;

def : Pat<(f32 (int_aarch64_neon_frecpe (f32 FPR32:$Rn))),
          (FRECPEv1i32 FPR32:$Rn)>;
def : Pat<(f64 (int_aarch64_neon_frecpe (f64 FPR64:$Rn))),
          (FRECPEv1i64 FPR64:$Rn)>;
def : Pat<(v1f64 (int_aarch64_neon_frecpe (v1f64 FPR64:$Rn))),
          (FRECPEv1i64 FPR64:$Rn)>;

def : Pat<(f32 (AArch64frecpe (f32 FPR32:$Rn))),
          (FRECPEv1i32 FPR32:$Rn)>;
def : Pat<(v2f32 (AArch64frecpe (v2f32 V64:$Rn))),
          (FRECPEv2f32 V64:$Rn)>;
def : Pat<(v4f32 (AArch64frecpe (v4f32 FPR128:$Rn))),
          (FRECPEv4f32 FPR128:$Rn)>;
def : Pat<(f64 (AArch64frecpe (f64 FPR64:$Rn))),
          (FRECPEv1i64 FPR64:$Rn)>;
def : Pat<(v1f64 (AArch64frecpe (v1f64 FPR64:$Rn))),
          (FRECPEv1i64 FPR64:$Rn)>;
def : Pat<(v2f64 (AArch64frecpe (v2f64 FPR128:$Rn))),
          (FRECPEv2f64 FPR128:$Rn)>;

def : Pat<(f32 (int_aarch64_neon_frecpx (f32 FPR32:$Rn))),
          (FRECPXv1i32 FPR32:$Rn)>;
def : Pat<(f64 (int_aarch64_neon_frecpx (f64 FPR64:$Rn))),
          (FRECPXv1i64 FPR64:$Rn)>;

def : Pat<(f32 (int_aarch64_neon_frsqrte (f32 FPR32:$Rn))),
          (FRSQRTEv1i32 FPR32:$Rn)>;
def : Pat<(f64 (int_aarch64_neon_frsqrte (f64 FPR64:$Rn))),
          (FRSQRTEv1i64 FPR64:$Rn)>;
def : Pat<(v1f64 (int_aarch64_neon_frsqrte (v1f64 FPR64:$Rn))),
          (FRSQRTEv1i64 FPR64:$Rn)>;

def : Pat<(f32 (AArch64frsqrte (f32 FPR32:$Rn))),
          (FRSQRTEv1i32 FPR32:$Rn)>;
def : Pat<(v2f32 (AArch64frsqrte (v2f32 V64:$Rn))),
          (FRSQRTEv2f32 V64:$Rn)>;
def : Pat<(v4f32 (AArch64frsqrte (v4f32 FPR128:$Rn))),
          (FRSQRTEv4f32 FPR128:$Rn)>;
def : Pat<(f64 (AArch64frsqrte (f64 FPR64:$Rn))),
          (FRSQRTEv1i64 FPR64:$Rn)>;
def : Pat<(v1f64 (AArch64frsqrte (v1f64 FPR64:$Rn))),
          (FRSQRTEv1i64 FPR64:$Rn)>;
def : Pat<(v2f64 (AArch64frsqrte (v2f64 FPR128:$Rn))),
          (FRSQRTEv2f64 FPR128:$Rn)>;

// If an integer is about to be converted to a floating point value,
// just load it on the floating point unit.
// Here are the patterns for 8 and 16-bits to float.
// 8-bits -> float.
multiclass UIntToFPROLoadPat<ValueType DstTy, ValueType SrcTy,
                             SDPatternOperator loadop, Instruction UCVTF,
                             ROAddrMode ro, Instruction LDRW, Instruction LDRX,
                             SubRegIndex sub> {
  def : Pat<(DstTy (uint_to_fp (SrcTy
                     (loadop (ro.Wpat GPR64sp:$Rn, GPR32:$Rm,
                                      ro.Wext:$extend))))),
           (UCVTF (INSERT_SUBREG (DstTy (IMPLICIT_DEF)),
                                 (LDRW GPR64sp:$Rn, GPR32:$Rm, ro.Wext:$extend),
                                 sub))>;

  def : Pat<(DstTy (uint_to_fp (SrcTy
                     (loadop (ro.Xpat GPR64sp:$Rn, GPR64:$Rm,
                                      ro.Wext:$extend))))),
           (UCVTF (INSERT_SUBREG (DstTy (IMPLICIT_DEF)),
                                 (LDRX GPR64sp:$Rn, GPR64:$Rm, ro.Xext:$extend),
                                 sub))>;
}

defm : UIntToFPROLoadPat<f32, i32, zextloadi8,
                         UCVTFv1i32, ro8, LDRBroW, LDRBroX, bsub>;
def : Pat <(f32 (uint_to_fp (i32
               (zextloadi8 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))))),
           (UCVTFv1i32 (INSERT_SUBREG (f32 (IMPLICIT_DEF)),
                          (LDRBui GPR64sp:$Rn, uimm12s1:$offset), bsub))>;
def : Pat <(f32 (uint_to_fp (i32
                     (zextloadi8 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))))),
           (UCVTFv1i32 (INSERT_SUBREG (f32 (IMPLICIT_DEF)),
                          (LDURBi GPR64sp:$Rn, simm9:$offset), bsub))>;
// 16-bits -> float.
defm : UIntToFPROLoadPat<f32, i32, zextloadi16,
                         UCVTFv1i32, ro16, LDRHroW, LDRHroX, hsub>;
def : Pat <(f32 (uint_to_fp (i32
                  (zextloadi16 (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset))))),
           (UCVTFv1i32 (INSERT_SUBREG (f32 (IMPLICIT_DEF)),
                          (LDRHui GPR64sp:$Rn, uimm12s2:$offset), hsub))>;
def : Pat <(f32 (uint_to_fp (i32
                  (zextloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset))))),
           (UCVTFv1i32 (INSERT_SUBREG (f32 (IMPLICIT_DEF)),
                          (LDURHi GPR64sp:$Rn, simm9:$offset), hsub))>;
// 32-bits are handled in target specific dag combine:
// performIntToFpCombine.
// 64-bits integer to 32-bits floating point, not possible with
// UCVTF on floating point registers (both source and destination
// must have the same size).

// Here are the patterns for 8, 16, 32, and 64-bits to double.
// 8-bits -> double.
defm : UIntToFPROLoadPat<f64, i32, zextloadi8,
                         UCVTFv1i64, ro8, LDRBroW, LDRBroX, bsub>;
def : Pat <(f64 (uint_to_fp (i32
                    (zextloadi8 (am_indexed8 GPR64sp:$Rn, uimm12s1:$offset))))),
           (UCVTFv1i64 (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                          (LDRBui GPR64sp:$Rn, uimm12s1:$offset), bsub))>;
def : Pat <(f64 (uint_to_fp (i32
                  (zextloadi8 (am_unscaled8 GPR64sp:$Rn, simm9:$offset))))),
           (UCVTFv1i64 (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                          (LDURBi GPR64sp:$Rn, simm9:$offset), bsub))>;
// 16-bits -> double.
defm : UIntToFPROLoadPat<f64, i32, zextloadi16,
                         UCVTFv1i64, ro16, LDRHroW, LDRHroX, hsub>;
def : Pat <(f64 (uint_to_fp (i32
                  (zextloadi16 (am_indexed16 GPR64sp:$Rn, uimm12s2:$offset))))),
           (UCVTFv1i64 (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                          (LDRHui GPR64sp:$Rn, uimm12s2:$offset), hsub))>;
def : Pat <(f64 (uint_to_fp (i32
                  (zextloadi16 (am_unscaled16 GPR64sp:$Rn, simm9:$offset))))),
           (UCVTFv1i64 (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                          (LDURHi GPR64sp:$Rn, simm9:$offset), hsub))>;
// 32-bits -> double.
defm : UIntToFPROLoadPat<f64, i32, load,
                         UCVTFv1i64, ro32, LDRSroW, LDRSroX, ssub>;
def : Pat <(f64 (uint_to_fp (i32
                  (load (am_indexed32 GPR64sp:$Rn, uimm12s4:$offset))))),
           (UCVTFv1i64 (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                          (LDRSui GPR64sp:$Rn, uimm12s4:$offset), ssub))>;
def : Pat <(f64 (uint_to_fp (i32
                  (load (am_unscaled32 GPR64sp:$Rn, simm9:$offset))))),
           (UCVTFv1i64 (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                          (LDURSi GPR64sp:$Rn, simm9:$offset), ssub))>;
// 64-bits -> double are handled in target specific dag combine:
// performIntToFpCombine.

//===----------------------------------------------------------------------===//
// Advanced SIMD three different-sized vector instructions.
//===----------------------------------------------------------------------===//

defm ADDHN  : SIMDNarrowThreeVectorBHS<0,0b0100,"addhn", int_aarch64_neon_addhn>;
defm SUBHN  : SIMDNarrowThreeVectorBHS<0,0b0110,"subhn", int_aarch64_neon_subhn>;
defm RADDHN : SIMDNarrowThreeVectorBHS<1,0b0100,"raddhn",int_aarch64_neon_raddhn>;
defm RSUBHN : SIMDNarrowThreeVectorBHS<1,0b0110,"rsubhn",int_aarch64_neon_rsubhn>;
defm PMULL  : SIMDDifferentThreeVectorBD<0,0b1110,"pmull",int_aarch64_neon_pmull>;
defm SABAL  : SIMDLongThreeVectorTiedBHSabal<0,0b0101,"sabal",
                                             int_aarch64_neon_sabd>;
defm SABDL   : SIMDLongThreeVectorBHSabdl<0, 0b0111, "sabdl",
                                          int_aarch64_neon_sabd>;
defm SADDL   : SIMDLongThreeVectorBHS<   0, 0b0000, "saddl",
            BinOpFrag<(add (sext node:$LHS), (sext node:$RHS))>>;
defm SADDW   : SIMDWideThreeVectorBHS<   0, 0b0001, "saddw",
                 BinOpFrag<(add node:$LHS, (sext node:$RHS))>>;
defm SMLAL   : SIMDLongThreeVectorTiedBHS<0, 0b1000, "smlal",
    TriOpFrag<(add node:$LHS, (int_aarch64_neon_smull node:$MHS, node:$RHS))>>;
defm SMLSL   : SIMDLongThreeVectorTiedBHS<0, 0b1010, "smlsl",
    TriOpFrag<(sub node:$LHS, (int_aarch64_neon_smull node:$MHS, node:$RHS))>>;
defm SMULL   : SIMDLongThreeVectorBHS<0, 0b1100, "smull", int_aarch64_neon_smull>;
defm SQDMLAL : SIMDLongThreeVectorSQDMLXTiedHS<0, 0b1001, "sqdmlal",
                                               int_aarch64_neon_sqadd>;
defm SQDMLSL : SIMDLongThreeVectorSQDMLXTiedHS<0, 0b1011, "sqdmlsl",
                                               int_aarch64_neon_sqsub>;
defm SQDMULL : SIMDLongThreeVectorHS<0, 0b1101, "sqdmull",
                                     int_aarch64_neon_sqdmull>;
defm SSUBL   : SIMDLongThreeVectorBHS<0, 0b0010, "ssubl",
                 BinOpFrag<(sub (sext node:$LHS), (sext node:$RHS))>>;
defm SSUBW   : SIMDWideThreeVectorBHS<0, 0b0011, "ssubw",
                 BinOpFrag<(sub node:$LHS, (sext node:$RHS))>>;
defm UABAL   : SIMDLongThreeVectorTiedBHSabal<1, 0b0101, "uabal",
                                              int_aarch64_neon_uabd>;
defm UADDL   : SIMDLongThreeVectorBHS<1, 0b0000, "uaddl",
                 BinOpFrag<(add (zext node:$LHS), (zext node:$RHS))>>;
defm UADDW   : SIMDWideThreeVectorBHS<1, 0b0001, "uaddw",
                 BinOpFrag<(add node:$LHS, (zext node:$RHS))>>;
defm UMLAL   : SIMDLongThreeVectorTiedBHS<1, 0b1000, "umlal",
    TriOpFrag<(add node:$LHS, (int_aarch64_neon_umull node:$MHS, node:$RHS))>>;
defm UMLSL   : SIMDLongThreeVectorTiedBHS<1, 0b1010, "umlsl",
    TriOpFrag<(sub node:$LHS, (int_aarch64_neon_umull node:$MHS, node:$RHS))>>;
defm UMULL   : SIMDLongThreeVectorBHS<1, 0b1100, "umull", int_aarch64_neon_umull>;
defm USUBL   : SIMDLongThreeVectorBHS<1, 0b0010, "usubl",
                 BinOpFrag<(sub (zext node:$LHS), (zext node:$RHS))>>;
defm USUBW   : SIMDWideThreeVectorBHS<   1, 0b0011, "usubw",
                 BinOpFrag<(sub node:$LHS, (zext node:$RHS))>>;

// Additional patterns for SMULL and UMULL
multiclass Neon_mul_widen_patterns<SDPatternOperator opnode,
  Instruction INST8B, Instruction INST4H, Instruction INST2S> {
  def : Pat<(v8i16 (opnode (v8i8 V64:$Rn), (v8i8 V64:$Rm))),
            (INST8B V64:$Rn, V64:$Rm)>;
  def : Pat<(v4i32 (opnode (v4i16 V64:$Rn), (v4i16 V64:$Rm))),
            (INST4H V64:$Rn, V64:$Rm)>;
  def : Pat<(v2i64 (opnode (v2i32 V64:$Rn), (v2i32 V64:$Rm))),
            (INST2S V64:$Rn, V64:$Rm)>;
}

defm : Neon_mul_widen_patterns<AArch64smull, SMULLv8i8_v8i16,
  SMULLv4i16_v4i32, SMULLv2i32_v2i64>;
defm : Neon_mul_widen_patterns<AArch64umull, UMULLv8i8_v8i16,
  UMULLv4i16_v4i32, UMULLv2i32_v2i64>;

// Additional patterns for SMLAL/SMLSL and UMLAL/UMLSL
multiclass Neon_mulacc_widen_patterns<SDPatternOperator opnode,
  Instruction INST8B, Instruction INST4H, Instruction INST2S> {
  def : Pat<(v8i16 (opnode (v8i16 V128:$Rd), (v8i8 V64:$Rn), (v8i8 V64:$Rm))),
            (INST8B V128:$Rd, V64:$Rn, V64:$Rm)>;
  def : Pat<(v4i32 (opnode (v4i32 V128:$Rd), (v4i16 V64:$Rn), (v4i16 V64:$Rm))),
            (INST4H V128:$Rd, V64:$Rn, V64:$Rm)>;
  def : Pat<(v2i64 (opnode (v2i64 V128:$Rd), (v2i32 V64:$Rn), (v2i32 V64:$Rm))),
            (INST2S  V128:$Rd, V64:$Rn, V64:$Rm)>;
}

defm : Neon_mulacc_widen_patterns<
  TriOpFrag<(add node:$LHS, (AArch64smull node:$MHS, node:$RHS))>,
  SMLALv8i8_v8i16, SMLALv4i16_v4i32, SMLALv2i32_v2i64>;
defm : Neon_mulacc_widen_patterns<
  TriOpFrag<(add node:$LHS, (AArch64umull node:$MHS, node:$RHS))>,
  UMLALv8i8_v8i16, UMLALv4i16_v4i32, UMLALv2i32_v2i64>;
defm : Neon_mulacc_widen_patterns<
  TriOpFrag<(sub node:$LHS, (AArch64smull node:$MHS, node:$RHS))>,
  SMLSLv8i8_v8i16, SMLSLv4i16_v4i32, SMLSLv2i32_v2i64>;
defm : Neon_mulacc_widen_patterns<
  TriOpFrag<(sub node:$LHS, (AArch64umull node:$MHS, node:$RHS))>,
  UMLSLv8i8_v8i16, UMLSLv4i16_v4i32, UMLSLv2i32_v2i64>;

// Patterns for 64-bit pmull
def : Pat<(int_aarch64_neon_pmull64 V64:$Rn, V64:$Rm),
          (PMULLv1i64 V64:$Rn, V64:$Rm)>;
def : Pat<(int_aarch64_neon_pmull64 (extractelt (v2i64 V128:$Rn), (i64 1)),
                                    (extractelt (v2i64 V128:$Rm), (i64 1))),
          (PMULLv2i64 V128:$Rn, V128:$Rm)>;

// CodeGen patterns for addhn and subhn instructions, which can actually be
// written in LLVM IR without too much difficulty.

// ADDHN
def : Pat<(v8i8 (trunc (v8i16 (AArch64vlshr (add V128:$Rn, V128:$Rm), (i32 8))))),
          (ADDHNv8i16_v8i8 V128:$Rn, V128:$Rm)>;
def : Pat<(v4i16 (trunc (v4i32 (AArch64vlshr (add V128:$Rn, V128:$Rm),
                                           (i32 16))))),
          (ADDHNv4i32_v4i16 V128:$Rn, V128:$Rm)>;
def : Pat<(v2i32 (trunc (v2i64 (AArch64vlshr (add V128:$Rn, V128:$Rm),
                                           (i32 32))))),
          (ADDHNv2i64_v2i32 V128:$Rn, V128:$Rm)>;
def : Pat<(concat_vectors (v8i8 V64:$Rd),
                          (trunc (v8i16 (AArch64vlshr (add V128:$Rn, V128:$Rm),
                                                    (i32 8))))),
          (ADDHNv8i16_v16i8 (SUBREG_TO_REG (i32 0), V64:$Rd, dsub),
                            V128:$Rn, V128:$Rm)>;
def : Pat<(concat_vectors (v4i16 V64:$Rd),
                          (trunc (v4i32 (AArch64vlshr (add V128:$Rn, V128:$Rm),
                                                    (i32 16))))),
          (ADDHNv4i32_v8i16 (SUBREG_TO_REG (i32 0), V64:$Rd, dsub),
                            V128:$Rn, V128:$Rm)>;
def : Pat<(concat_vectors (v2i32 V64:$Rd),
                          (trunc (v2i64 (AArch64vlshr (add V128:$Rn, V128:$Rm),
                                                    (i32 32))))),
          (ADDHNv2i64_v4i32 (SUBREG_TO_REG (i32 0), V64:$Rd, dsub),
                            V128:$Rn, V128:$Rm)>;

// SUBHN
def : Pat<(v8i8 (trunc (v8i16 (AArch64vlshr (sub V128:$Rn, V128:$Rm), (i32 8))))),
          (SUBHNv8i16_v8i8 V128:$Rn, V128:$Rm)>;
def : Pat<(v4i16 (trunc (v4i32 (AArch64vlshr (sub V128:$Rn, V128:$Rm),
                                           (i32 16))))),
          (SUBHNv4i32_v4i16 V128:$Rn, V128:$Rm)>;
def : Pat<(v2i32 (trunc (v2i64 (AArch64vlshr (sub V128:$Rn, V128:$Rm),
                                           (i32 32))))),
          (SUBHNv2i64_v2i32 V128:$Rn, V128:$Rm)>;
def : Pat<(concat_vectors (v8i8 V64:$Rd),
                          (trunc (v8i16 (AArch64vlshr (sub V128:$Rn, V128:$Rm),
                                                    (i32 8))))),
          (SUBHNv8i16_v16i8 (SUBREG_TO_REG (i32 0), V64:$Rd, dsub),
                            V128:$Rn, V128:$Rm)>;
def : Pat<(concat_vectors (v4i16 V64:$Rd),
                          (trunc (v4i32 (AArch64vlshr (sub V128:$Rn, V128:$Rm),
                                                    (i32 16))))),
          (SUBHNv4i32_v8i16 (SUBREG_TO_REG (i32 0), V64:$Rd, dsub),
                            V128:$Rn, V128:$Rm)>;
def : Pat<(concat_vectors (v2i32 V64:$Rd),
                          (trunc (v2i64 (AArch64vlshr (sub V128:$Rn, V128:$Rm),
                                                    (i32 32))))),
          (SUBHNv2i64_v4i32 (SUBREG_TO_REG (i32 0), V64:$Rd, dsub),
                            V128:$Rn, V128:$Rm)>;

//----------------------------------------------------------------------------
// AdvSIMD bitwise extract from vector instruction.
//----------------------------------------------------------------------------

defm EXT : SIMDBitwiseExtract<"ext">;

def : Pat<(v4i16 (AArch64ext V64:$Rn, V64:$Rm, (i32 imm:$imm))),
          (EXTv8i8 V64:$Rn, V64:$Rm, imm:$imm)>;
def : Pat<(v8i16 (AArch64ext V128:$Rn, V128:$Rm, (i32 imm:$imm))),
          (EXTv16i8 V128:$Rn, V128:$Rm, imm:$imm)>;
def : Pat<(v2i32 (AArch64ext V64:$Rn, V64:$Rm, (i32 imm:$imm))),
          (EXTv8i8 V64:$Rn, V64:$Rm, imm:$imm)>;
def : Pat<(v2f32 (AArch64ext V64:$Rn, V64:$Rm, (i32 imm:$imm))),
          (EXTv8i8 V64:$Rn, V64:$Rm, imm:$imm)>;
def : Pat<(v4i32 (AArch64ext V128:$Rn, V128:$Rm, (i32 imm:$imm))),
          (EXTv16i8 V128:$Rn, V128:$Rm, imm:$imm)>;
def : Pat<(v4f32 (AArch64ext V128:$Rn, V128:$Rm, (i32 imm:$imm))),
          (EXTv16i8 V128:$Rn, V128:$Rm, imm:$imm)>;
def : Pat<(v2i64 (AArch64ext V128:$Rn, V128:$Rm, (i32 imm:$imm))),
          (EXTv16i8 V128:$Rn, V128:$Rm, imm:$imm)>;
def : Pat<(v2f64 (AArch64ext V128:$Rn, V128:$Rm, (i32 imm:$imm))),
          (EXTv16i8 V128:$Rn, V128:$Rm, imm:$imm)>;
def : Pat<(v4f16 (AArch64ext V64:$Rn, V64:$Rm, (i32 imm:$imm))),
          (EXTv8i8 V64:$Rn, V64:$Rm, imm:$imm)>;
def : Pat<(v8f16 (AArch64ext V128:$Rn, V128:$Rm, (i32 imm:$imm))),
          (EXTv16i8 V128:$Rn, V128:$Rm, imm:$imm)>;

// We use EXT to handle extract_subvector to copy the upper 64-bits of a
// 128-bit vector.
def : Pat<(v8i8  (extract_subvector V128:$Rn, (i64 8))),
          (EXTRACT_SUBREG (EXTv16i8 V128:$Rn, V128:$Rn, 8), dsub)>;
def : Pat<(v4i16 (extract_subvector V128:$Rn, (i64 4))),
          (EXTRACT_SUBREG (EXTv16i8 V128:$Rn, V128:$Rn, 8), dsub)>;
def : Pat<(v2i32 (extract_subvector V128:$Rn, (i64 2))),
          (EXTRACT_SUBREG (EXTv16i8 V128:$Rn, V128:$Rn, 8), dsub)>;
def : Pat<(v1i64 (extract_subvector V128:$Rn, (i64 1))),
          (EXTRACT_SUBREG (EXTv16i8 V128:$Rn, V128:$Rn, 8), dsub)>;
def : Pat<(v4f16 (extract_subvector V128:$Rn, (i64 4))),
          (EXTRACT_SUBREG (EXTv16i8 V128:$Rn, V128:$Rn, 8), dsub)>;
def : Pat<(v2f32 (extract_subvector V128:$Rn, (i64 2))),
          (EXTRACT_SUBREG (EXTv16i8 V128:$Rn, V128:$Rn, 8), dsub)>;
def : Pat<(v1f64 (extract_subvector V128:$Rn, (i64 1))),
          (EXTRACT_SUBREG (EXTv16i8 V128:$Rn, V128:$Rn, 8), dsub)>;


//----------------------------------------------------------------------------
// AdvSIMD zip vector
//----------------------------------------------------------------------------

defm TRN1 : SIMDZipVector<0b010, "trn1", AArch64trn1>;
defm TRN2 : SIMDZipVector<0b110, "trn2", AArch64trn2>;
defm UZP1 : SIMDZipVector<0b001, "uzp1", AArch64uzp1>;
defm UZP2 : SIMDZipVector<0b101, "uzp2", AArch64uzp2>;
defm ZIP1 : SIMDZipVector<0b011, "zip1", AArch64zip1>;
defm ZIP2 : SIMDZipVector<0b111, "zip2", AArch64zip2>;

//----------------------------------------------------------------------------
// AdvSIMD TBL/TBX instructions
//----------------------------------------------------------------------------

defm TBL : SIMDTableLookup<    0, "tbl">;
defm TBX : SIMDTableLookupTied<1, "tbx">;

def : Pat<(v8i8 (int_aarch64_neon_tbl1 (v16i8 VecListOne128:$Rn), (v8i8 V64:$Ri))),
          (TBLv8i8One VecListOne128:$Rn, V64:$Ri)>;
def : Pat<(v16i8 (int_aarch64_neon_tbl1 (v16i8 V128:$Ri), (v16i8 V128:$Rn))),
          (TBLv16i8One V128:$Ri, V128:$Rn)>;

def : Pat<(v8i8 (int_aarch64_neon_tbx1 (v8i8 V64:$Rd),
                  (v16i8 VecListOne128:$Rn), (v8i8 V64:$Ri))),
          (TBXv8i8One V64:$Rd, VecListOne128:$Rn, V64:$Ri)>;
def : Pat<(v16i8 (int_aarch64_neon_tbx1 (v16i8 V128:$Rd),
                   (v16i8 V128:$Ri), (v16i8 V128:$Rn))),
          (TBXv16i8One V128:$Rd, V128:$Ri, V128:$Rn)>;


//----------------------------------------------------------------------------
// AdvSIMD scalar CPY instruction
//----------------------------------------------------------------------------

defm CPY : SIMDScalarCPY<"cpy">;

//----------------------------------------------------------------------------
// AdvSIMD scalar pairwise instructions
//----------------------------------------------------------------------------

defm ADDP    : SIMDPairwiseScalarD<0, 0b11011, "addp">;
defm FADDP   : SIMDFPPairwiseScalar<0, 0b01101, "faddp">;
defm FMAXNMP : SIMDFPPairwiseScalar<0, 0b01100, "fmaxnmp">;
defm FMAXP   : SIMDFPPairwiseScalar<0, 0b01111, "fmaxp">;
defm FMINNMP : SIMDFPPairwiseScalar<1, 0b01100, "fminnmp">;
defm FMINP   : SIMDFPPairwiseScalar<1, 0b01111, "fminp">;
def : Pat<(v2i64 (AArch64saddv V128:$Rn)),
          (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (ADDPv2i64p V128:$Rn), dsub)>;
def : Pat<(v2i64 (AArch64uaddv V128:$Rn)),
          (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (ADDPv2i64p V128:$Rn), dsub)>;
def : Pat<(f32 (int_aarch64_neon_faddv (v2f32 V64:$Rn))),
          (FADDPv2i32p V64:$Rn)>;
def : Pat<(f32 (int_aarch64_neon_faddv (v4f32 V128:$Rn))),
          (FADDPv2i32p (EXTRACT_SUBREG (FADDPv4f32 V128:$Rn, V128:$Rn), dsub))>;
def : Pat<(f64 (int_aarch64_neon_faddv (v2f64 V128:$Rn))),
          (FADDPv2i64p V128:$Rn)>;
def : Pat<(f32 (int_aarch64_neon_fmaxnmv (v2f32 V64:$Rn))),
          (FMAXNMPv2i32p V64:$Rn)>;
def : Pat<(f64 (int_aarch64_neon_fmaxnmv (v2f64 V128:$Rn))),
          (FMAXNMPv2i64p V128:$Rn)>;
def : Pat<(f32 (int_aarch64_neon_fmaxv (v2f32 V64:$Rn))),
          (FMAXPv2i32p V64:$Rn)>;
def : Pat<(f64 (int_aarch64_neon_fmaxv (v2f64 V128:$Rn))),
          (FMAXPv2i64p V128:$Rn)>;
def : Pat<(f32 (int_aarch64_neon_fminnmv (v2f32 V64:$Rn))),
          (FMINNMPv2i32p V64:$Rn)>;
def : Pat<(f64 (int_aarch64_neon_fminnmv (v2f64 V128:$Rn))),
          (FMINNMPv2i64p V128:$Rn)>;
def : Pat<(f32 (int_aarch64_neon_fminv (v2f32 V64:$Rn))),
          (FMINPv2i32p V64:$Rn)>;
def : Pat<(f64 (int_aarch64_neon_fminv (v2f64 V128:$Rn))),
          (FMINPv2i64p V128:$Rn)>;

//----------------------------------------------------------------------------
// AdvSIMD INS/DUP instructions
//----------------------------------------------------------------------------

def DUPv8i8gpr  : SIMDDupFromMain<0, {?,?,?,?,1}, ".8b", v8i8, V64, GPR32>;
def DUPv16i8gpr : SIMDDupFromMain<1, {?,?,?,?,1}, ".16b", v16i8, V128, GPR32>;
def DUPv4i16gpr : SIMDDupFromMain<0, {?,?,?,1,0}, ".4h", v4i16, V64, GPR32>;
def DUPv8i16gpr : SIMDDupFromMain<1, {?,?,?,1,0}, ".8h", v8i16, V128, GPR32>;
def DUPv2i32gpr : SIMDDupFromMain<0, {?,?,1,0,0}, ".2s", v2i32, V64, GPR32>;
def DUPv4i32gpr : SIMDDupFromMain<1, {?,?,1,0,0}, ".4s", v4i32, V128, GPR32>;
def DUPv2i64gpr : SIMDDupFromMain<1, {?,1,0,0,0}, ".2d", v2i64, V128, GPR64>;

def DUPv2i64lane : SIMDDup64FromElement;
def DUPv2i32lane : SIMDDup32FromElement<0, ".2s", v2i32, V64>;
def DUPv4i32lane : SIMDDup32FromElement<1, ".4s", v4i32, V128>;
def DUPv4i16lane : SIMDDup16FromElement<0, ".4h", v4i16, V64>;
def DUPv8i16lane : SIMDDup16FromElement<1, ".8h", v8i16, V128>;
def DUPv8i8lane  : SIMDDup8FromElement <0, ".8b", v8i8, V64>;
def DUPv16i8lane : SIMDDup8FromElement <1, ".16b", v16i8, V128>;

def : Pat<(v2f32 (AArch64dup (f32 FPR32:$Rn))),
          (v2f32 (DUPv2i32lane
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), FPR32:$Rn, ssub),
            (i64 0)))>;
def : Pat<(v4f32 (AArch64dup (f32 FPR32:$Rn))),
          (v4f32 (DUPv4i32lane
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), FPR32:$Rn, ssub),
            (i64 0)))>;
def : Pat<(v2f64 (AArch64dup (f64 FPR64:$Rn))),
          (v2f64 (DUPv2i64lane
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), FPR64:$Rn, dsub),
            (i64 0)))>;
def : Pat<(v4f16 (AArch64dup (f16 FPR16:$Rn))),
          (v4f16 (DUPv4i16lane
            (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)), FPR16:$Rn, hsub),
            (i64 0)))>;
def : Pat<(v8f16 (AArch64dup (f16 FPR16:$Rn))),
          (v8f16 (DUPv8i16lane
            (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)), FPR16:$Rn, hsub),
            (i64 0)))>;

def : Pat<(v4f16 (AArch64duplane16 (v8f16 V128:$Rn), VectorIndexH:$imm)),
          (DUPv4i16lane V128:$Rn, VectorIndexH:$imm)>;
def : Pat<(v8f16 (AArch64duplane16 (v8f16 V128:$Rn), VectorIndexH:$imm)),
          (DUPv8i16lane V128:$Rn, VectorIndexH:$imm)>;

def : Pat<(v2f32 (AArch64duplane32 (v4f32 V128:$Rn), VectorIndexS:$imm)),
          (DUPv2i32lane V128:$Rn, VectorIndexS:$imm)>;
def : Pat<(v4f32 (AArch64duplane32 (v4f32 V128:$Rn), VectorIndexS:$imm)),
         (DUPv4i32lane V128:$Rn, VectorIndexS:$imm)>;
def : Pat<(v2f64 (AArch64duplane64 (v2f64 V128:$Rn), VectorIndexD:$imm)),
          (DUPv2i64lane V128:$Rn, VectorIndexD:$imm)>;

// If there's an (AArch64dup (vector_extract ...) ...), we can use a duplane
// instruction even if the types don't match: we just have to remap the lane
// carefully. N.b. this trick only applies to truncations.
def VecIndex_x2 : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(2 * N->getZExtValue(), SDLoc(N), MVT::i64);
}]>;
def VecIndex_x4 : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(4 * N->getZExtValue(), SDLoc(N), MVT::i64);
}]>;
def VecIndex_x8 : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(8 * N->getZExtValue(), SDLoc(N), MVT::i64);
}]>;

multiclass DUPWithTruncPats<ValueType ResVT, ValueType Src64VT,
                            ValueType Src128VT, ValueType ScalVT,
                            Instruction DUP, SDNodeXForm IdxXFORM> {
  def : Pat<(ResVT (AArch64dup (ScalVT (vector_extract (Src128VT V128:$Rn),
                                                     imm:$idx)))),
            (DUP V128:$Rn, (IdxXFORM imm:$idx))>;

  def : Pat<(ResVT (AArch64dup (ScalVT (vector_extract (Src64VT V64:$Rn),
                                                     imm:$idx)))),
            (DUP (SUBREG_TO_REG (i64 0), V64:$Rn, dsub), (IdxXFORM imm:$idx))>;
}

defm : DUPWithTruncPats<v8i8,   v4i16, v8i16, i32, DUPv8i8lane,  VecIndex_x2>;
defm : DUPWithTruncPats<v8i8,   v2i32, v4i32, i32, DUPv8i8lane,  VecIndex_x4>;
defm : DUPWithTruncPats<v4i16,  v2i32, v4i32, i32, DUPv4i16lane, VecIndex_x2>;

defm : DUPWithTruncPats<v16i8,  v4i16, v8i16, i32, DUPv16i8lane, VecIndex_x2>;
defm : DUPWithTruncPats<v16i8,  v2i32, v4i32, i32, DUPv16i8lane, VecIndex_x4>;
defm : DUPWithTruncPats<v8i16,  v2i32, v4i32, i32, DUPv8i16lane, VecIndex_x2>;

multiclass DUPWithTrunci64Pats<ValueType ResVT, Instruction DUP,
                               SDNodeXForm IdxXFORM> {
  def : Pat<(ResVT (AArch64dup (i32 (trunc (extractelt (v2i64 V128:$Rn),
                                                         imm:$idx))))),
            (DUP V128:$Rn, (IdxXFORM imm:$idx))>;

  def : Pat<(ResVT (AArch64dup (i32 (trunc (extractelt (v1i64 V64:$Rn),
                                                       imm:$idx))))),
            (DUP (SUBREG_TO_REG (i64 0), V64:$Rn, dsub), (IdxXFORM imm:$idx))>;
}

defm : DUPWithTrunci64Pats<v8i8,  DUPv8i8lane,   VecIndex_x8>;
defm : DUPWithTrunci64Pats<v4i16, DUPv4i16lane,  VecIndex_x4>;
defm : DUPWithTrunci64Pats<v2i32, DUPv2i32lane,  VecIndex_x2>;

defm : DUPWithTrunci64Pats<v16i8, DUPv16i8lane, VecIndex_x8>;
defm : DUPWithTrunci64Pats<v8i16, DUPv8i16lane, VecIndex_x4>;
defm : DUPWithTrunci64Pats<v4i32, DUPv4i32lane, VecIndex_x2>;

// SMOV and UMOV definitions, with some extra patterns for convenience
defm SMOV : SMov;
defm UMOV : UMov;

def : Pat<(sext_inreg (vector_extract (v16i8 V128:$Rn), VectorIndexB:$idx), i8),
          (i32 (SMOVvi8to32 V128:$Rn, VectorIndexB:$idx))>;
def : Pat<(sext_inreg (vector_extract (v16i8 V128:$Rn), VectorIndexB:$idx), i8),
          (i64 (SMOVvi8to64 V128:$Rn, VectorIndexB:$idx))>;
def : Pat<(sext_inreg (vector_extract (v8i16 V128:$Rn), VectorIndexH:$idx),i16),
          (i32 (SMOVvi16to32 V128:$Rn, VectorIndexH:$idx))>;
def : Pat<(sext_inreg (vector_extract (v8i16 V128:$Rn), VectorIndexH:$idx),i16),
          (i64 (SMOVvi16to64 V128:$Rn, VectorIndexH:$idx))>;
def : Pat<(sext_inreg (vector_extract (v8i16 V128:$Rn), VectorIndexH:$idx),i16),
          (i32 (SMOVvi16to32 V128:$Rn, VectorIndexH:$idx))>;
def : Pat<(sext (i32 (vector_extract (v4i32 V128:$Rn), VectorIndexS:$idx))),
          (i64 (SMOVvi32to64 V128:$Rn, VectorIndexS:$idx))>;

def : Pat<(sext_inreg (i64 (anyext (i32 (vector_extract (v16i8 V128:$Rn),
            VectorIndexB:$idx)))), i8),
          (i64 (SMOVvi8to64 V128:$Rn, VectorIndexB:$idx))>;
def : Pat<(sext_inreg (i64 (anyext (i32 (vector_extract (v8i16 V128:$Rn),
            VectorIndexH:$idx)))), i16),
          (i64 (SMOVvi16to64 V128:$Rn, VectorIndexH:$idx))>;

// Extracting i8 or i16 elements will have the zero-extend transformed to
// an 'and' mask by type legalization since neither i8 nor i16 are legal types
// for AArch64. Match these patterns here since UMOV already zeroes out the high
// bits of the destination register.
def : Pat<(and (vector_extract (v16i8 V128:$Rn), VectorIndexB:$idx),
               (i32 0xff)),
          (i32 (UMOVvi8 V128:$Rn, VectorIndexB:$idx))>;
def : Pat<(and (vector_extract (v8i16 V128:$Rn), VectorIndexH:$idx),
               (i32 0xffff)),
          (i32 (UMOVvi16 V128:$Rn, VectorIndexH:$idx))>;

defm INS : SIMDIns;

def : Pat<(v16i8 (scalar_to_vector GPR32:$Rn)),
          (SUBREG_TO_REG (i32 0),
                         (f32 (COPY_TO_REGCLASS GPR32:$Rn, FPR32)), ssub)>;
def : Pat<(v8i8 (scalar_to_vector GPR32:$Rn)),
          (SUBREG_TO_REG (i32 0),
                         (f32 (COPY_TO_REGCLASS GPR32:$Rn, FPR32)), ssub)>;

def : Pat<(v8i16 (scalar_to_vector GPR32:$Rn)),
          (SUBREG_TO_REG (i32 0),
                         (f32 (COPY_TO_REGCLASS GPR32:$Rn, FPR32)), ssub)>;
def : Pat<(v4i16 (scalar_to_vector GPR32:$Rn)),
          (SUBREG_TO_REG (i32 0),
                         (f32 (COPY_TO_REGCLASS GPR32:$Rn, FPR32)), ssub)>;

def : Pat<(v2i32 (scalar_to_vector (i32 FPR32:$Rn))),
            (v2i32 (INSERT_SUBREG (v2i32 (IMPLICIT_DEF)),
                                  (i32 FPR32:$Rn), ssub))>;
def : Pat<(v4i32 (scalar_to_vector (i32 FPR32:$Rn))),
            (v4i32 (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)),
                                  (i32 FPR32:$Rn), ssub))>;
def : Pat<(v2i64 (scalar_to_vector (i64 FPR64:$Rn))),
            (v2i64 (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)),
                                  (i64 FPR64:$Rn), dsub))>;

def : Pat<(v4f16 (scalar_to_vector (f16 FPR16:$Rn))),
          (INSERT_SUBREG (v4f16 (IMPLICIT_DEF)), FPR16:$Rn, hsub)>;
def : Pat<(v8f16 (scalar_to_vector (f16 FPR16:$Rn))),
          (INSERT_SUBREG (v8f16 (IMPLICIT_DEF)), FPR16:$Rn, hsub)>;

def : Pat<(v4f32 (scalar_to_vector (f32 FPR32:$Rn))),
          (INSERT_SUBREG (v4f32 (IMPLICIT_DEF)), FPR32:$Rn, ssub)>;
def : Pat<(v2f32 (scalar_to_vector (f32 FPR32:$Rn))),
          (INSERT_SUBREG (v2f32 (IMPLICIT_DEF)), FPR32:$Rn, ssub)>;
def : Pat<(v2f64 (scalar_to_vector (f64 FPR64:$Rn))),
          (INSERT_SUBREG (v2f64 (IMPLICIT_DEF)), FPR64:$Rn, dsub)>;

def : Pat<(v4f16 (vector_insert (v4f16 V64:$Rn),
            (f16 FPR16:$Rm), (i64 VectorIndexS:$imm))),
          (EXTRACT_SUBREG
            (INSvi16lane
              (v8f16 (INSERT_SUBREG (v8f16 (IMPLICIT_DEF)), V64:$Rn, dsub)),
              VectorIndexS:$imm,
              (v8f16 (INSERT_SUBREG (v8f16 (IMPLICIT_DEF)), FPR16:$Rm, hsub)),
              (i64 0)),
            dsub)>;

def : Pat<(v8f16 (vector_insert (v8f16 V128:$Rn),
            (f16 FPR16:$Rm), (i64 VectorIndexH:$imm))),
          (INSvi16lane
            V128:$Rn, VectorIndexH:$imm,
            (v8f16 (INSERT_SUBREG (v8f16 (IMPLICIT_DEF)), FPR16:$Rm, hsub)),
            (i64 0))>;

def : Pat<(v2f32 (vector_insert (v2f32 V64:$Rn),
            (f32 FPR32:$Rm), (i64 VectorIndexS:$imm))),
          (EXTRACT_SUBREG
            (INSvi32lane
              (v4f32 (INSERT_SUBREG (v4f32 (IMPLICIT_DEF)), V64:$Rn, dsub)),
              VectorIndexS:$imm,
              (v4f32 (INSERT_SUBREG (v4f32 (IMPLICIT_DEF)), FPR32:$Rm, ssub)),
              (i64 0)),
            dsub)>;
def : Pat<(v4f32 (vector_insert (v4f32 V128:$Rn),
            (f32 FPR32:$Rm), (i64 VectorIndexS:$imm))),
          (INSvi32lane
            V128:$Rn, VectorIndexS:$imm,
            (v4f32 (INSERT_SUBREG (v4f32 (IMPLICIT_DEF)), FPR32:$Rm, ssub)),
            (i64 0))>;
def : Pat<(v2f64 (vector_insert (v2f64 V128:$Rn),
            (f64 FPR64:$Rm), (i64 VectorIndexD:$imm))),
          (INSvi64lane
            V128:$Rn, VectorIndexD:$imm,
            (v2f64 (INSERT_SUBREG (v2f64 (IMPLICIT_DEF)), FPR64:$Rm, dsub)),
            (i64 0))>;

// Copy an element at a constant index in one vector into a constant indexed
// element of another.
// FIXME refactor to a shared class/dev parameterized on vector type, vector
// index type and INS extension
def : Pat<(v16i8 (int_aarch64_neon_vcopy_lane
                   (v16i8 V128:$Vd), VectorIndexB:$idx, (v16i8 V128:$Vs),
                   VectorIndexB:$idx2)),
          (v16i8 (INSvi8lane
                   V128:$Vd, VectorIndexB:$idx, V128:$Vs, VectorIndexB:$idx2)
          )>;
def : Pat<(v8i16 (int_aarch64_neon_vcopy_lane
                   (v8i16 V128:$Vd), VectorIndexH:$idx, (v8i16 V128:$Vs),
                   VectorIndexH:$idx2)),
          (v8i16 (INSvi16lane
                   V128:$Vd, VectorIndexH:$idx, V128:$Vs, VectorIndexH:$idx2)
          )>;
def : Pat<(v4i32 (int_aarch64_neon_vcopy_lane
                   (v4i32 V128:$Vd), VectorIndexS:$idx, (v4i32 V128:$Vs),
                   VectorIndexS:$idx2)),
          (v4i32 (INSvi32lane
                   V128:$Vd, VectorIndexS:$idx, V128:$Vs, VectorIndexS:$idx2)
          )>;
def : Pat<(v2i64 (int_aarch64_neon_vcopy_lane
                   (v2i64 V128:$Vd), VectorIndexD:$idx, (v2i64 V128:$Vs),
                   VectorIndexD:$idx2)),
          (v2i64 (INSvi64lane
                   V128:$Vd, VectorIndexD:$idx, V128:$Vs, VectorIndexD:$idx2)
          )>;

multiclass Neon_INS_elt_pattern<ValueType VT128, ValueType VT64,
                                ValueType VTScal, Instruction INS> {
  def : Pat<(VT128 (vector_insert V128:$src,
                        (VTScal (vector_extract (VT128 V128:$Rn), imm:$Immn)),
                        imm:$Immd)),
            (INS V128:$src, imm:$Immd, V128:$Rn, imm:$Immn)>;

  def : Pat<(VT128 (vector_insert V128:$src,
                        (VTScal (vector_extract (VT64 V64:$Rn), imm:$Immn)),
                        imm:$Immd)),
            (INS V128:$src, imm:$Immd,
                 (SUBREG_TO_REG (i64 0), V64:$Rn, dsub), imm:$Immn)>;

  def : Pat<(VT64 (vector_insert V64:$src,
                        (VTScal (vector_extract (VT128 V128:$Rn), imm:$Immn)),
                        imm:$Immd)),
            (EXTRACT_SUBREG (INS (SUBREG_TO_REG (i64 0), V64:$src, dsub),
                                 imm:$Immd, V128:$Rn, imm:$Immn),
                            dsub)>;

  def : Pat<(VT64 (vector_insert V64:$src,
                        (VTScal (vector_extract (VT64 V64:$Rn), imm:$Immn)),
                        imm:$Immd)),
            (EXTRACT_SUBREG
                (INS (SUBREG_TO_REG (i64 0), V64:$src, dsub), imm:$Immd,
                     (SUBREG_TO_REG (i64 0), V64:$Rn, dsub), imm:$Immn),
                dsub)>;
}

defm : Neon_INS_elt_pattern<v8f16, v4f16, f16, INSvi16lane>;
defm : Neon_INS_elt_pattern<v4f32, v2f32, f32, INSvi32lane>;
defm : Neon_INS_elt_pattern<v2f64, v1f64, f64, INSvi64lane>;


// Floating point vector extractions are codegen'd as either a sequence of
// subregister extractions, or a MOV (aka CPY here, alias for DUP) if
// the lane number is anything other than zero.
def : Pat<(vector_extract (v2f64 V128:$Rn), 0),
          (f64 (EXTRACT_SUBREG V128:$Rn, dsub))>;
def : Pat<(vector_extract (v4f32 V128:$Rn), 0),
          (f32 (EXTRACT_SUBREG V128:$Rn, ssub))>;
def : Pat<(vector_extract (v8f16 V128:$Rn), 0),
          (f16 (EXTRACT_SUBREG V128:$Rn, hsub))>;

def : Pat<(vector_extract (v2f64 V128:$Rn), VectorIndexD:$idx),
          (f64 (CPYi64 V128:$Rn, VectorIndexD:$idx))>;
def : Pat<(vector_extract (v4f32 V128:$Rn), VectorIndexS:$idx),
          (f32 (CPYi32 V128:$Rn, VectorIndexS:$idx))>;
def : Pat<(vector_extract (v8f16 V128:$Rn), VectorIndexH:$idx),
          (f16 (CPYi16 V128:$Rn, VectorIndexH:$idx))>;

// All concat_vectors operations are canonicalised to act on i64 vectors for
// AArch64. In the general case we need an instruction, which had just as well be
// INS.
class ConcatPat<ValueType DstTy, ValueType SrcTy>
  : Pat<(DstTy (concat_vectors (SrcTy V64:$Rd), V64:$Rn)),
        (INSvi64lane (INSERT_SUBREG (IMPLICIT_DEF), V64:$Rd, dsub), 1,
                     (INSERT_SUBREG (IMPLICIT_DEF), V64:$Rn, dsub), 0)>;

def : ConcatPat<v2i64, v1i64>;
def : ConcatPat<v2f64, v1f64>;
def : ConcatPat<v4i32, v2i32>;
def : ConcatPat<v4f32, v2f32>;
def : ConcatPat<v8i16, v4i16>;
def : ConcatPat<v8f16, v4f16>;
def : ConcatPat<v16i8, v8i8>;

// If the high lanes are undef, though, we can just ignore them:
class ConcatUndefPat<ValueType DstTy, ValueType SrcTy>
  : Pat<(DstTy (concat_vectors (SrcTy V64:$Rn), undef)),
        (INSERT_SUBREG (IMPLICIT_DEF), V64:$Rn, dsub)>;

def : ConcatUndefPat<v2i64, v1i64>;
def : ConcatUndefPat<v2f64, v1f64>;
def : ConcatUndefPat<v4i32, v2i32>;
def : ConcatUndefPat<v4f32, v2f32>;
def : ConcatUndefPat<v8i16, v4i16>;
def : ConcatUndefPat<v16i8, v8i8>;

//----------------------------------------------------------------------------
// AdvSIMD across lanes instructions
//----------------------------------------------------------------------------

defm ADDV    : SIMDAcrossLanesBHS<0, 0b11011, "addv">;
defm SMAXV   : SIMDAcrossLanesBHS<0, 0b01010, "smaxv">;
defm SMINV   : SIMDAcrossLanesBHS<0, 0b11010, "sminv">;
defm UMAXV   : SIMDAcrossLanesBHS<1, 0b01010, "umaxv">;
defm UMINV   : SIMDAcrossLanesBHS<1, 0b11010, "uminv">;
defm SADDLV  : SIMDAcrossLanesHSD<0, 0b00011, "saddlv">;
defm UADDLV  : SIMDAcrossLanesHSD<1, 0b00011, "uaddlv">;
defm FMAXNMV : SIMDFPAcrossLanes<0b01100, 0, "fmaxnmv", int_aarch64_neon_fmaxnmv>;
defm FMAXV   : SIMDFPAcrossLanes<0b01111, 0, "fmaxv", int_aarch64_neon_fmaxv>;
defm FMINNMV : SIMDFPAcrossLanes<0b01100, 1, "fminnmv", int_aarch64_neon_fminnmv>;
defm FMINV   : SIMDFPAcrossLanes<0b01111, 1, "fminv", int_aarch64_neon_fminv>;

// Patterns for across-vector intrinsics, that have a node equivalent, that
// returns a vector (with only the low lane defined) instead of a scalar.
// In effect, opNode is the same as (scalar_to_vector (IntNode)).
multiclass SIMDAcrossLanesIntrinsic<string baseOpc,
                                    SDPatternOperator opNode> {
// If a lane instruction caught the vector_extract around opNode, we can
// directly match the latter to the instruction.
def : Pat<(v8i8 (opNode V64:$Rn)),
          (INSERT_SUBREG (v8i8 (IMPLICIT_DEF)),
           (!cast<Instruction>(!strconcat(baseOpc, "v8i8v")) V64:$Rn), bsub)>;
def : Pat<(v16i8 (opNode V128:$Rn)),
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
           (!cast<Instruction>(!strconcat(baseOpc, "v16i8v")) V128:$Rn), bsub)>;
def : Pat<(v4i16 (opNode V64:$Rn)),
          (INSERT_SUBREG (v4i16 (IMPLICIT_DEF)),
           (!cast<Instruction>(!strconcat(baseOpc, "v4i16v")) V64:$Rn), hsub)>;
def : Pat<(v8i16 (opNode V128:$Rn)),
          (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)),
           (!cast<Instruction>(!strconcat(baseOpc, "v8i16v")) V128:$Rn), hsub)>;
def : Pat<(v4i32 (opNode V128:$Rn)),
          (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)),
           (!cast<Instruction>(!strconcat(baseOpc, "v4i32v")) V128:$Rn), ssub)>;


// If none did, fallback to the explicit patterns, consuming the vector_extract.
def : Pat<(i32 (vector_extract (insert_subvector undef, (v8i8 (opNode V64:$Rn)),
            (i32 0)), (i64 0))),
          (EXTRACT_SUBREG (INSERT_SUBREG (v8i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v8i8v")) V64:$Rn),
            bsub), ssub)>;
def : Pat<(i32 (vector_extract (v16i8 (opNode V128:$Rn)), (i64 0))),
          (EXTRACT_SUBREG (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v16i8v")) V128:$Rn),
            bsub), ssub)>;
def : Pat<(i32 (vector_extract (insert_subvector undef,
            (v4i16 (opNode V64:$Rn)), (i32 0)), (i64 0))),
          (EXTRACT_SUBREG (INSERT_SUBREG (v4i16 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v4i16v")) V64:$Rn),
            hsub), ssub)>;
def : Pat<(i32 (vector_extract (v8i16 (opNode V128:$Rn)), (i64 0))),
          (EXTRACT_SUBREG (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v8i16v")) V128:$Rn),
            hsub), ssub)>;
def : Pat<(i32 (vector_extract (v4i32 (opNode V128:$Rn)), (i64 0))),
          (EXTRACT_SUBREG (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v4i32v")) V128:$Rn),
            ssub), ssub)>;

}

multiclass SIMDAcrossLanesSignedIntrinsic<string baseOpc,
                                          SDPatternOperator opNode>
    : SIMDAcrossLanesIntrinsic<baseOpc, opNode> {
// If there is a sign extension after this intrinsic, consume it as smov already
// performed it
def : Pat<(i32 (sext_inreg (i32 (vector_extract (insert_subvector undef,
            (opNode (v8i8 V64:$Rn)), (i32 0)), (i64 0))), i8)),
          (i32 (SMOVvi8to32
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
              (!cast<Instruction>(!strconcat(baseOpc, "v8i8v")) V64:$Rn), bsub),
            (i64 0)))>;
def : Pat<(i32 (sext_inreg (i32 (vector_extract
            (opNode (v16i8 V128:$Rn)), (i64 0))), i8)),
          (i32 (SMOVvi8to32
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
             (!cast<Instruction>(!strconcat(baseOpc, "v16i8v")) V128:$Rn), bsub),
            (i64 0)))>;
def : Pat<(i32 (sext_inreg (i32 (vector_extract (insert_subvector undef,
            (opNode (v4i16 V64:$Rn)), (i32 0)), (i64 0))), i16)),
          (i32 (SMOVvi16to32
           (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v4i16v")) V64:$Rn), hsub),
           (i64 0)))>;
def : Pat<(i32 (sext_inreg (i32 (vector_extract
            (opNode (v8i16 V128:$Rn)), (i64 0))), i16)),
          (i32 (SMOVvi16to32
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
             (!cast<Instruction>(!strconcat(baseOpc, "v8i16v")) V128:$Rn), hsub),
            (i64 0)))>;
}

multiclass SIMDAcrossLanesUnsignedIntrinsic<string baseOpc,
                                            SDPatternOperator opNode>
    : SIMDAcrossLanesIntrinsic<baseOpc, opNode> {
// If there is a masking operation keeping only what has been actually
// generated, consume it.
def : Pat<(i32 (and (i32 (vector_extract (insert_subvector undef,
            (opNode (v8i8 V64:$Rn)), (i32 0)), (i64 0))), maski8_or_more)),
      (i32 (EXTRACT_SUBREG
        (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
          (!cast<Instruction>(!strconcat(baseOpc, "v8i8v")) V64:$Rn), bsub),
        ssub))>;
def : Pat<(i32 (and (i32 (vector_extract (opNode (v16i8 V128:$Rn)), (i64 0))),
            maski8_or_more)),
        (i32 (EXTRACT_SUBREG
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v16i8v")) V128:$Rn), bsub),
          ssub))>;
def : Pat<(i32 (and (i32 (vector_extract (insert_subvector undef,
            (opNode (v4i16 V64:$Rn)), (i32 0)), (i64 0))), maski16_or_more)),
          (i32 (EXTRACT_SUBREG
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
              (!cast<Instruction>(!strconcat(baseOpc, "v4i16v")) V64:$Rn), hsub),
            ssub))>;
def : Pat<(i32 (and (i32 (vector_extract (opNode (v8i16 V128:$Rn)), (i64 0))),
            maski16_or_more)),
        (i32 (EXTRACT_SUBREG
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v8i16v")) V128:$Rn), hsub),
          ssub))>;
}

defm : SIMDAcrossLanesSignedIntrinsic<"ADDV",  AArch64saddv>;
// vaddv_[su]32 is special; -> ADDP Vd.2S,Vn.2S,Vm.2S; return Vd.s[0];Vn==Vm
def : Pat<(v2i32 (AArch64saddv (v2i32 V64:$Rn))),
          (ADDPv2i32 V64:$Rn, V64:$Rn)>;

defm : SIMDAcrossLanesUnsignedIntrinsic<"ADDV", AArch64uaddv>;
// vaddv_[su]32 is special; -> ADDP Vd.2S,Vn.2S,Vm.2S; return Vd.s[0];Vn==Vm
def : Pat<(v2i32 (AArch64uaddv (v2i32 V64:$Rn))),
          (ADDPv2i32 V64:$Rn, V64:$Rn)>;

defm : SIMDAcrossLanesSignedIntrinsic<"SMAXV", AArch64smaxv>;
def : Pat<(v2i32 (AArch64smaxv (v2i32 V64:$Rn))),
          (SMAXPv2i32 V64:$Rn, V64:$Rn)>;

defm : SIMDAcrossLanesSignedIntrinsic<"SMINV", AArch64sminv>;
def : Pat<(v2i32 (AArch64sminv (v2i32 V64:$Rn))),
          (SMINPv2i32 V64:$Rn, V64:$Rn)>;

defm : SIMDAcrossLanesUnsignedIntrinsic<"UMAXV", AArch64umaxv>;
def : Pat<(v2i32 (AArch64umaxv (v2i32 V64:$Rn))),
          (UMAXPv2i32 V64:$Rn, V64:$Rn)>;

defm : SIMDAcrossLanesUnsignedIntrinsic<"UMINV", AArch64uminv>;
def : Pat<(v2i32 (AArch64uminv (v2i32 V64:$Rn))),
          (UMINPv2i32 V64:$Rn, V64:$Rn)>;

multiclass SIMDAcrossLanesSignedLongIntrinsic<string baseOpc, Intrinsic intOp> {
  def : Pat<(i32 (intOp (v8i8 V64:$Rn))),
        (i32 (SMOVvi16to32
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v8i8v")) V64:$Rn), hsub),
          (i64 0)))>;
def : Pat<(i32 (intOp (v16i8 V128:$Rn))),
        (i32 (SMOVvi16to32
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
           (!cast<Instruction>(!strconcat(baseOpc, "v16i8v")) V128:$Rn), hsub),
          (i64 0)))>;

def : Pat<(i32 (intOp (v4i16 V64:$Rn))),
          (i32 (EXTRACT_SUBREG
           (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v4i16v")) V64:$Rn), ssub),
           ssub))>;
def : Pat<(i32 (intOp (v8i16 V128:$Rn))),
        (i32 (EXTRACT_SUBREG
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
           (!cast<Instruction>(!strconcat(baseOpc, "v8i16v")) V128:$Rn), ssub),
          ssub))>;

def : Pat<(i64 (intOp (v4i32 V128:$Rn))),
        (i64 (EXTRACT_SUBREG
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
           (!cast<Instruction>(!strconcat(baseOpc, "v4i32v")) V128:$Rn), dsub),
          dsub))>;
}

multiclass SIMDAcrossLanesUnsignedLongIntrinsic<string baseOpc,
                                                Intrinsic intOp> {
  def : Pat<(i32 (intOp (v8i8 V64:$Rn))),
        (i32 (EXTRACT_SUBREG
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v8i8v")) V64:$Rn), hsub),
          ssub))>;
def : Pat<(i32 (intOp (v16i8 V128:$Rn))),
        (i32 (EXTRACT_SUBREG
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v16i8v")) V128:$Rn), hsub),
          ssub))>;

def : Pat<(i32 (intOp (v4i16 V64:$Rn))),
          (i32 (EXTRACT_SUBREG
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
              (!cast<Instruction>(!strconcat(baseOpc, "v4i16v")) V64:$Rn), ssub),
            ssub))>;
def : Pat<(i32 (intOp (v8i16 V128:$Rn))),
        (i32 (EXTRACT_SUBREG
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v8i16v")) V128:$Rn), ssub),
          ssub))>;

def : Pat<(i64 (intOp (v4i32 V128:$Rn))),
        (i64 (EXTRACT_SUBREG
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
            (!cast<Instruction>(!strconcat(baseOpc, "v4i32v")) V128:$Rn), dsub),
          dsub))>;
}

defm : SIMDAcrossLanesSignedLongIntrinsic<"SADDLV", int_aarch64_neon_saddlv>;
defm : SIMDAcrossLanesUnsignedLongIntrinsic<"UADDLV", int_aarch64_neon_uaddlv>;

// The vaddlv_s32 intrinsic gets mapped to SADDLP.
def : Pat<(i64 (int_aarch64_neon_saddlv (v2i32 V64:$Rn))),
          (i64 (EXTRACT_SUBREG
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
              (SADDLPv2i32_v1i64 V64:$Rn), dsub),
            dsub))>;
// The vaddlv_u32 intrinsic gets mapped to UADDLP.
def : Pat<(i64 (int_aarch64_neon_uaddlv (v2i32 V64:$Rn))),
          (i64 (EXTRACT_SUBREG
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)),
              (UADDLPv2i32_v1i64 V64:$Rn), dsub),
            dsub))>;

//------------------------------------------------------------------------------
// AdvSIMD modified immediate instructions
//------------------------------------------------------------------------------

// AdvSIMD BIC
defm BIC : SIMDModifiedImmVectorShiftTied<1, 0b11, 0b01, "bic", AArch64bici>;
// AdvSIMD ORR
defm ORR : SIMDModifiedImmVectorShiftTied<0, 0b11, 0b01, "orr", AArch64orri>;

def : InstAlias<"{bic $Vd.4h, $imm|bic.4h $Vd, $imm}", (BICv4i16 V64:$Vd,  imm0_255:$imm, 0)>;
def : InstAlias<"{bic $Vd.8h, $imm|bic.8h $Vd, $imm}", (BICv8i16 V128:$Vd, imm0_255:$imm, 0)>;
def : InstAlias<"{bic $Vd.2s, $imm|bic.2s $Vd, $imm}", (BICv2i32 V64:$Vd,  imm0_255:$imm, 0)>;
def : InstAlias<"{bic $Vd.4s, $imm|bic.4s $Vd, $imm}", (BICv4i32 V128:$Vd, imm0_255:$imm, 0)>;

def : InstAlias<"{orr $Vd.4h, $imm|orr.4h $Vd, $imm}", (ORRv4i16 V64:$Vd,  imm0_255:$imm, 0)>;
def : InstAlias<"{orr $Vd.8h, $imm|orr.8h $Vd, $imm}", (ORRv8i16 V128:$Vd, imm0_255:$imm, 0)>;
def : InstAlias<"{orr $Vd.2s, $imm|orr.2s $Vd, $imm}", (ORRv2i32 V64:$Vd,  imm0_255:$imm, 0)>;
def : InstAlias<"{orr $Vd.4s, $imm|orr.4s $Vd, $imm}", (ORRv4i32 V128:$Vd, imm0_255:$imm, 0)>;

// AdvSIMD FMOV
def FMOVv2f64_ns : SIMDModifiedImmVectorNoShift<1, 1, 0, 0b1111, V128, fpimm8,
                                              "fmov", ".2d",
                       [(set (v2f64 V128:$Rd), (AArch64fmov imm0_255:$imm8))]>;
def FMOVv2f32_ns : SIMDModifiedImmVectorNoShift<0, 0, 0, 0b1111, V64,  fpimm8,
                                              "fmov", ".2s",
                       [(set (v2f32 V64:$Rd), (AArch64fmov imm0_255:$imm8))]>;
def FMOVv4f32_ns : SIMDModifiedImmVectorNoShift<1, 0, 0, 0b1111, V128, fpimm8,
                                              "fmov", ".4s",
                       [(set (v4f32 V128:$Rd), (AArch64fmov imm0_255:$imm8))]>;
let Predicates = [HasNEON, HasFullFP16] in {
def FMOVv4f16_ns : SIMDModifiedImmVectorNoShift<0, 0, 1, 0b1111, V64,  fpimm8,
                                              "fmov", ".4h",
                       [(set (v4f16 V64:$Rd), (AArch64fmov imm0_255:$imm8))]>;
def FMOVv8f16_ns : SIMDModifiedImmVectorNoShift<1, 0, 1, 0b1111, V128, fpimm8,
                                              "fmov", ".8h",
                       [(set (v8f16 V128:$Rd), (AArch64fmov imm0_255:$imm8))]>;
} // Predicates = [HasNEON, HasFullFP16]

// AdvSIMD MOVI

// EDIT byte mask: scalar
let isReMaterializable = 1, isAsCheapAsAMove = 1 in
def MOVID      : SIMDModifiedImmScalarNoShift<0, 1, 0b1110, "movi",
                    [(set FPR64:$Rd, simdimmtype10:$imm8)]>;
// The movi_edit node has the immediate value already encoded, so we use
// a plain imm0_255 here.
def : Pat<(f64 (AArch64movi_edit imm0_255:$shift)),
          (MOVID imm0_255:$shift)>;

def : Pat<(v1i64 immAllZerosV), (MOVID (i32 0))>;
def : Pat<(v2i32 immAllZerosV), (MOVID (i32 0))>;
def : Pat<(v4i16 immAllZerosV), (MOVID (i32 0))>;
def : Pat<(v8i8  immAllZerosV), (MOVID (i32 0))>;

def : Pat<(v1i64 immAllOnesV), (MOVID (i32 255))>;
def : Pat<(v2i32 immAllOnesV), (MOVID (i32 255))>;
def : Pat<(v4i16 immAllOnesV), (MOVID (i32 255))>;
def : Pat<(v8i8  immAllOnesV), (MOVID (i32 255))>;

// EDIT byte mask: 2d

// The movi_edit node has the immediate value already encoded, so we use
// a plain imm0_255 in the pattern
let isReMaterializable = 1, isAsCheapAsAMove = 1 in
def MOVIv2d_ns   : SIMDModifiedImmVectorNoShift<1, 1, 0, 0b1110, V128,
                                                simdimmtype10,
                                                "movi", ".2d",
                   [(set (v2i64 V128:$Rd), (AArch64movi_edit imm0_255:$imm8))]>;


// Use movi.2d to materialize 0.0 if the HW does zero-cycle zeroing.
// Complexity is added to break a tie with a plain MOVI.
let AddedComplexity = 1 in {
def : Pat<(f16   fpimm0),
          (f16 (EXTRACT_SUBREG (v2i64 (MOVIv2d_ns (i32 0))), hsub))>,
      Requires<[HasZCZ]>;
def : Pat<(f32   fpimm0),
          (f32 (EXTRACT_SUBREG (v2i64 (MOVIv2d_ns (i32 0))), ssub))>,
      Requires<[HasZCZ]>;
def : Pat<(f64   fpimm0),
          (f64 (EXTRACT_SUBREG (v2i64 (MOVIv2d_ns (i32 0))), dsub))>,
      Requires<[HasZCZ]>;
}

def : Pat<(v2i64 immAllZerosV), (MOVIv2d_ns (i32 0))>;
def : Pat<(v4i32 immAllZerosV), (MOVIv2d_ns (i32 0))>;
def : Pat<(v8i16 immAllZerosV), (MOVIv2d_ns (i32 0))>;
def : Pat<(v16i8 immAllZerosV), (MOVIv2d_ns (i32 0))>;

def : Pat<(v2i64 immAllOnesV), (MOVIv2d_ns (i32 255))>;
def : Pat<(v4i32 immAllOnesV), (MOVIv2d_ns (i32 255))>;
def : Pat<(v8i16 immAllOnesV), (MOVIv2d_ns (i32 255))>;
def : Pat<(v16i8 immAllOnesV), (MOVIv2d_ns (i32 255))>;

def : Pat<(v2f64 (AArch64dup (f64 fpimm0))), (MOVIv2d_ns (i32 0))>;
def : Pat<(v4f32 (AArch64dup (f32 fpimm0))), (MOVIv2d_ns (i32 0))>;

// EDIT per word & halfword: 2s, 4h, 4s, & 8h
defm MOVI      : SIMDModifiedImmVectorShift<0, 0b10, 0b00, "movi">;

def : InstAlias<"movi $Vd.4h, $imm", (MOVIv4i16 V64:$Vd,  imm0_255:$imm, 0), 0>;
def : InstAlias<"movi $Vd.8h, $imm", (MOVIv8i16 V128:$Vd, imm0_255:$imm, 0), 0>;
def : InstAlias<"movi $Vd.2s, $imm", (MOVIv2i32 V64:$Vd,  imm0_255:$imm, 0), 0>;
def : InstAlias<"movi $Vd.4s, $imm", (MOVIv4i32 V128:$Vd, imm0_255:$imm, 0), 0>;

def : InstAlias<"movi.4h $Vd, $imm", (MOVIv4i16 V64:$Vd,  imm0_255:$imm, 0), 0>;
def : InstAlias<"movi.8h $Vd, $imm", (MOVIv8i16 V128:$Vd, imm0_255:$imm, 0), 0>;
def : InstAlias<"movi.2s $Vd, $imm", (MOVIv2i32 V64:$Vd,  imm0_255:$imm, 0), 0>;
def : InstAlias<"movi.4s $Vd, $imm", (MOVIv4i32 V128:$Vd, imm0_255:$imm, 0), 0>;

def : Pat<(v2i32 (AArch64movi_shift imm0_255:$imm8, (i32 imm:$shift))),
          (MOVIv2i32 imm0_255:$imm8, imm:$shift)>;
def : Pat<(v4i32 (AArch64movi_shift imm0_255:$imm8, (i32 imm:$shift))),
          (MOVIv4i32 imm0_255:$imm8, imm:$shift)>;
def : Pat<(v4i16 (AArch64movi_shift imm0_255:$imm8, (i32 imm:$shift))),
          (MOVIv4i16 imm0_255:$imm8, imm:$shift)>;
def : Pat<(v8i16 (AArch64movi_shift imm0_255:$imm8, (i32 imm:$shift))),
          (MOVIv8i16 imm0_255:$imm8, imm:$shift)>;

// EDIT per word: 2s & 4s with MSL shifter
def MOVIv2s_msl  : SIMDModifiedImmMoveMSL<0, 0, {1,1,0,?}, V64, "movi", ".2s",
                      [(set (v2i32 V64:$Rd),
                            (AArch64movi_msl imm0_255:$imm8, (i32 imm:$shift)))]>;
def MOVIv4s_msl  : SIMDModifiedImmMoveMSL<1, 0, {1,1,0,?}, V128, "movi", ".4s",
                      [(set (v4i32 V128:$Rd),
                            (AArch64movi_msl imm0_255:$imm8, (i32 imm:$shift)))]>;

// Per byte: 8b & 16b
def MOVIv8b_ns   : SIMDModifiedImmVectorNoShift<0, 0, 0, 0b1110, V64,  imm0_255,
                                                 "movi", ".8b",
                       [(set (v8i8 V64:$Rd), (AArch64movi imm0_255:$imm8))]>;
def MOVIv16b_ns  : SIMDModifiedImmVectorNoShift<1, 0, 0, 0b1110, V128, imm0_255,
                                                 "movi", ".16b",
                       [(set (v16i8 V128:$Rd), (AArch64movi imm0_255:$imm8))]>;

// AdvSIMD MVNI

// EDIT per word & halfword: 2s, 4h, 4s, & 8h
defm MVNI      : SIMDModifiedImmVectorShift<1, 0b10, 0b00, "mvni">;

def : InstAlias<"mvni $Vd.4h, $imm", (MVNIv4i16 V64:$Vd,  imm0_255:$imm, 0), 0>;
def : InstAlias<"mvni $Vd.8h, $imm", (MVNIv8i16 V128:$Vd, imm0_255:$imm, 0), 0>;
def : InstAlias<"mvni $Vd.2s, $imm", (MVNIv2i32 V64:$Vd,  imm0_255:$imm, 0), 0>;
def : InstAlias<"mvni $Vd.4s, $imm", (MVNIv4i32 V128:$Vd, imm0_255:$imm, 0), 0>;

def : InstAlias<"mvni.4h $Vd, $imm", (MVNIv4i16 V64:$Vd,  imm0_255:$imm, 0), 0>;
def : InstAlias<"mvni.8h $Vd, $imm", (MVNIv8i16 V128:$Vd, imm0_255:$imm, 0), 0>;
def : InstAlias<"mvni.2s $Vd, $imm", (MVNIv2i32 V64:$Vd,  imm0_255:$imm, 0), 0>;
def : InstAlias<"mvni.4s $Vd, $imm", (MVNIv4i32 V128:$Vd, imm0_255:$imm, 0), 0>;

def : Pat<(v2i32 (AArch64mvni_shift imm0_255:$imm8, (i32 imm:$shift))),
          (MVNIv2i32 imm0_255:$imm8, imm:$shift)>;
def : Pat<(v4i32 (AArch64mvni_shift imm0_255:$imm8, (i32 imm:$shift))),
          (MVNIv4i32 imm0_255:$imm8, imm:$shift)>;
def : Pat<(v4i16 (AArch64mvni_shift imm0_255:$imm8, (i32 imm:$shift))),
          (MVNIv4i16 imm0_255:$imm8, imm:$shift)>;
def : Pat<(v8i16 (AArch64mvni_shift imm0_255:$imm8, (i32 imm:$shift))),
          (MVNIv8i16 imm0_255:$imm8, imm:$shift)>;

// EDIT per word: 2s & 4s with MSL shifter
def MVNIv2s_msl   : SIMDModifiedImmMoveMSL<0, 1, {1,1,0,?}, V64, "mvni", ".2s",
                      [(set (v2i32 V64:$Rd),
                            (AArch64mvni_msl imm0_255:$imm8, (i32 imm:$shift)))]>;
def MVNIv4s_msl   : SIMDModifiedImmMoveMSL<1, 1, {1,1,0,?}, V128, "mvni", ".4s",
                      [(set (v4i32 V128:$Rd),
                            (AArch64mvni_msl imm0_255:$imm8, (i32 imm:$shift)))]>;

//----------------------------------------------------------------------------
// AdvSIMD indexed element
//----------------------------------------------------------------------------

let hasSideEffects = 0 in {
  defm FMLA  : SIMDFPIndexedTied<0, 0b0001, "fmla">;
  defm FMLS  : SIMDFPIndexedTied<0, 0b0101, "fmls">;
}

// NOTE: Operands are reordered in the FMLA/FMLS PatFrags because the
// instruction expects the addend first, while the intrinsic expects it last.

// On the other hand, there are quite a few valid combinatorial options due to
// the commutativity of multiplication and the fact that (-x) * y = x * (-y).
defm : SIMDFPIndexedTiedPatterns<"FMLA",
           TriOpFrag<(fma node:$RHS, node:$MHS, node:$LHS)>>;
defm : SIMDFPIndexedTiedPatterns<"FMLA",
           TriOpFrag<(fma node:$MHS, node:$RHS, node:$LHS)>>;

defm : SIMDFPIndexedTiedPatterns<"FMLS",
           TriOpFrag<(fma node:$MHS, (fneg node:$RHS), node:$LHS)> >;
defm : SIMDFPIndexedTiedPatterns<"FMLS",
           TriOpFrag<(fma node:$RHS, (fneg node:$MHS), node:$LHS)> >;
defm : SIMDFPIndexedTiedPatterns<"FMLS",
           TriOpFrag<(fma (fneg node:$RHS), node:$MHS, node:$LHS)> >;
defm : SIMDFPIndexedTiedPatterns<"FMLS",
           TriOpFrag<(fma (fneg node:$MHS), node:$RHS, node:$LHS)> >;

multiclass FMLSIndexedAfterNegPatterns<SDPatternOperator OpNode> {
  // 3 variants for the .2s version: DUPLANE from 128-bit, DUPLANE from 64-bit
  // and DUP scalar.
  def : Pat<(v2f32 (OpNode (v2f32 V64:$Rd), (v2f32 V64:$Rn),
                           (AArch64duplane32 (v4f32 (fneg V128:$Rm)),
                                           VectorIndexS:$idx))),
            (FMLSv2i32_indexed V64:$Rd, V64:$Rn, V128:$Rm, VectorIndexS:$idx)>;
  def : Pat<(v2f32 (OpNode (v2f32 V64:$Rd), (v2f32 V64:$Rn),
                           (v2f32 (AArch64duplane32
                                      (v4f32 (insert_subvector undef,
                                                 (v2f32 (fneg V64:$Rm)),
                                                 (i32 0))),
                                      VectorIndexS:$idx)))),
            (FMLSv2i32_indexed V64:$Rd, V64:$Rn,
                               (SUBREG_TO_REG (i32 0), V64:$Rm, dsub),
                               VectorIndexS:$idx)>;
  def : Pat<(v2f32 (OpNode (v2f32 V64:$Rd), (v2f32 V64:$Rn),
                           (AArch64dup (f32 (fneg FPR32Op:$Rm))))),
            (FMLSv2i32_indexed V64:$Rd, V64:$Rn,
                (SUBREG_TO_REG (i32 0), FPR32Op:$Rm, ssub), (i64 0))>;

  // 3 variants for the .4s version: DUPLANE from 128-bit, DUPLANE from 64-bit
  // and DUP scalar.
  def : Pat<(v4f32 (OpNode (v4f32 V128:$Rd), (v4f32 V128:$Rn),
                           (AArch64duplane32 (v4f32 (fneg V128:$Rm)),
                                           VectorIndexS:$idx))),
            (FMLSv4i32_indexed V128:$Rd, V128:$Rn, V128:$Rm,
                               VectorIndexS:$idx)>;
  def : Pat<(v4f32 (OpNode (v4f32 V128:$Rd), (v4f32 V128:$Rn),
                           (v4f32 (AArch64duplane32
                                      (v4f32 (insert_subvector undef,
                                                 (v2f32 (fneg V64:$Rm)),
                                                 (i32 0))),
                                      VectorIndexS:$idx)))),
            (FMLSv4i32_indexed V128:$Rd, V128:$Rn,
                               (SUBREG_TO_REG (i32 0), V64:$Rm, dsub),
                               VectorIndexS:$idx)>;
  def : Pat<(v4f32 (OpNode (v4f32 V128:$Rd), (v4f32 V128:$Rn),
                           (AArch64dup (f32 (fneg FPR32Op:$Rm))))),
            (FMLSv4i32_indexed V128:$Rd, V128:$Rn,
                (SUBREG_TO_REG (i32 0), FPR32Op:$Rm, ssub), (i64 0))>;

  // 2 variants for the .2d version: DUPLANE from 128-bit, and DUP scalar
  // (DUPLANE from 64-bit would be trivial).
  def : Pat<(v2f64 (OpNode (v2f64 V128:$Rd), (v2f64 V128:$Rn),
                           (AArch64duplane64 (v2f64 (fneg V128:$Rm)),
                                           VectorIndexD:$idx))),
            (FMLSv2i64_indexed
                V128:$Rd, V128:$Rn, V128:$Rm, VectorIndexS:$idx)>;
  def : Pat<(v2f64 (OpNode (v2f64 V128:$Rd), (v2f64 V128:$Rn),
                           (AArch64dup (f64 (fneg FPR64Op:$Rm))))),
            (FMLSv2i64_indexed V128:$Rd, V128:$Rn,
                (SUBREG_TO_REG (i32 0), FPR64Op:$Rm, dsub), (i64 0))>;

  // 2 variants for 32-bit scalar version: extract from .2s or from .4s
  def : Pat<(f32 (OpNode (f32 FPR32:$Rd), (f32 FPR32:$Rn),
                         (vector_extract (v4f32 (fneg V128:$Rm)),
                                         VectorIndexS:$idx))),
            (FMLSv1i32_indexed FPR32:$Rd, FPR32:$Rn,
                V128:$Rm, VectorIndexS:$idx)>;
  def : Pat<(f32 (OpNode (f32 FPR32:$Rd), (f32 FPR32:$Rn),
                         (vector_extract (v4f32 (insert_subvector undef,
                                                    (v2f32 (fneg V64:$Rm)),
                                                    (i32 0))),
                                         VectorIndexS:$idx))),
            (FMLSv1i32_indexed FPR32:$Rd, FPR32:$Rn,
                (SUBREG_TO_REG (i32 0), V64:$Rm, dsub), VectorIndexS:$idx)>;

  // 1 variant for 64-bit scalar version: extract from .1d or from .2d
  def : Pat<(f64 (OpNode (f64 FPR64:$Rd), (f64 FPR64:$Rn),
                         (vector_extract (v2f64 (fneg V128:$Rm)),
                                         VectorIndexS:$idx))),
            (FMLSv1i64_indexed FPR64:$Rd, FPR64:$Rn,
                V128:$Rm, VectorIndexS:$idx)>;
}

defm : FMLSIndexedAfterNegPatterns<
           TriOpFrag<(fma node:$RHS, node:$MHS, node:$LHS)> >;
defm : FMLSIndexedAfterNegPatterns<
           TriOpFrag<(fma node:$MHS, node:$RHS, node:$LHS)> >;

defm FMULX : SIMDFPIndexed<1, 0b1001, "fmulx", int_aarch64_neon_fmulx>;
defm FMUL  : SIMDFPIndexed<0, 0b1001, "fmul", fmul>;

def : Pat<(v2f32 (fmul V64:$Rn, (AArch64dup (f32 FPR32:$Rm)))),
          (FMULv2i32_indexed V64:$Rn,
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), FPR32:$Rm, ssub),
            (i64 0))>;
def : Pat<(v4f32 (fmul V128:$Rn, (AArch64dup (f32 FPR32:$Rm)))),
          (FMULv4i32_indexed V128:$Rn,
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), FPR32:$Rm, ssub),
            (i64 0))>;
def : Pat<(v2f64 (fmul V128:$Rn, (AArch64dup (f64 FPR64:$Rm)))),
          (FMULv2i64_indexed V128:$Rn,
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), FPR64:$Rm, dsub),
            (i64 0))>;

defm SQDMULH : SIMDIndexedHS<0, 0b1100, "sqdmulh", int_aarch64_neon_sqdmulh>;
defm SQRDMULH : SIMDIndexedHS<0, 0b1101, "sqrdmulh", int_aarch64_neon_sqrdmulh>;
defm MLA   : SIMDVectorIndexedHSTied<1, 0b0000, "mla",
              TriOpFrag<(add node:$LHS, (mul node:$MHS, node:$RHS))>>;
defm MLS   : SIMDVectorIndexedHSTied<1, 0b0100, "mls",
              TriOpFrag<(sub node:$LHS, (mul node:$MHS, node:$RHS))>>;
defm MUL   : SIMDVectorIndexedHS<0, 0b1000, "mul", mul>;
defm SMLAL : SIMDVectorIndexedLongSDTied<0, 0b0010, "smlal",
    TriOpFrag<(add node:$LHS, (int_aarch64_neon_smull node:$MHS, node:$RHS))>>;
defm SMLSL : SIMDVectorIndexedLongSDTied<0, 0b0110, "smlsl",
    TriOpFrag<(sub node:$LHS, (int_aarch64_neon_smull node:$MHS, node:$RHS))>>;
defm SMULL : SIMDVectorIndexedLongSD<0, 0b1010, "smull",
                int_aarch64_neon_smull>;
defm SQDMLAL : SIMDIndexedLongSQDMLXSDTied<0, 0b0011, "sqdmlal",
                                           int_aarch64_neon_sqadd>;
defm SQDMLSL : SIMDIndexedLongSQDMLXSDTied<0, 0b0111, "sqdmlsl",
                                           int_aarch64_neon_sqsub>;
defm SQRDMLAH : SIMDIndexedSQRDMLxHSDTied<1, 0b1101, "sqrdmlah",
                                          int_aarch64_neon_sqadd>;
defm SQRDMLSH : SIMDIndexedSQRDMLxHSDTied<1, 0b1111, "sqrdmlsh",
                                          int_aarch64_neon_sqsub>;
defm SQDMULL : SIMDIndexedLongSD<0, 0b1011, "sqdmull", int_aarch64_neon_sqdmull>;
defm UMLAL   : SIMDVectorIndexedLongSDTied<1, 0b0010, "umlal",
    TriOpFrag<(add node:$LHS, (int_aarch64_neon_umull node:$MHS, node:$RHS))>>;
defm UMLSL   : SIMDVectorIndexedLongSDTied<1, 0b0110, "umlsl",
    TriOpFrag<(sub node:$LHS, (int_aarch64_neon_umull node:$MHS, node:$RHS))>>;
defm UMULL   : SIMDVectorIndexedLongSD<1, 0b1010, "umull",
                int_aarch64_neon_umull>;

// A scalar sqdmull with the second operand being a vector lane can be
// handled directly with the indexed instruction encoding.
def : Pat<(int_aarch64_neon_sqdmulls_scalar (i32 FPR32:$Rn),
                                          (vector_extract (v4i32 V128:$Vm),
                                                           VectorIndexS:$idx)),
          (SQDMULLv1i64_indexed FPR32:$Rn, V128:$Vm, VectorIndexS:$idx)>;

//----------------------------------------------------------------------------
// AdvSIMD scalar shift instructions
//----------------------------------------------------------------------------
defm FCVTZS : SIMDFPScalarRShift<0, 0b11111, "fcvtzs">;
defm FCVTZU : SIMDFPScalarRShift<1, 0b11111, "fcvtzu">;
defm SCVTF  : SIMDFPScalarRShift<0, 0b11100, "scvtf">;
defm UCVTF  : SIMDFPScalarRShift<1, 0b11100, "ucvtf">;
// Codegen patterns for the above. We don't put these directly on the
// instructions because TableGen's type inference can't handle the truth.
// Having the same base pattern for fp <--> int totally freaks it out.
def : Pat<(int_aarch64_neon_vcvtfp2fxs FPR32:$Rn, vecshiftR32:$imm),
          (FCVTZSs FPR32:$Rn, vecshiftR32:$imm)>;
def : Pat<(int_aarch64_neon_vcvtfp2fxu FPR32:$Rn, vecshiftR32:$imm),
          (FCVTZUs FPR32:$Rn, vecshiftR32:$imm)>;
def : Pat<(i64 (int_aarch64_neon_vcvtfp2fxs (f64 FPR64:$Rn), vecshiftR64:$imm)),
          (FCVTZSd FPR64:$Rn, vecshiftR64:$imm)>;
def : Pat<(i64 (int_aarch64_neon_vcvtfp2fxu (f64 FPR64:$Rn), vecshiftR64:$imm)),
          (FCVTZUd FPR64:$Rn, vecshiftR64:$imm)>;
def : Pat<(v1i64 (int_aarch64_neon_vcvtfp2fxs (v1f64 FPR64:$Rn),
                                            vecshiftR64:$imm)),
          (FCVTZSd FPR64:$Rn, vecshiftR64:$imm)>;
def : Pat<(v1i64 (int_aarch64_neon_vcvtfp2fxu (v1f64 FPR64:$Rn),
                                            vecshiftR64:$imm)),
          (FCVTZUd FPR64:$Rn, vecshiftR64:$imm)>;
def : Pat<(int_aarch64_neon_vcvtfxs2fp FPR32:$Rn, vecshiftR32:$imm),
          (SCVTFs FPR32:$Rn, vecshiftR32:$imm)>;
def : Pat<(int_aarch64_neon_vcvtfxu2fp FPR32:$Rn, vecshiftR32:$imm),
          (UCVTFs FPR32:$Rn, vecshiftR32:$imm)>;
def : Pat<(f64 (int_aarch64_neon_vcvtfxs2fp (i64 FPR64:$Rn), vecshiftR64:$imm)),
          (SCVTFd FPR64:$Rn, vecshiftR64:$imm)>;
def : Pat<(f64 (int_aarch64_neon_vcvtfxu2fp (i64 FPR64:$Rn), vecshiftR64:$imm)),
          (UCVTFd FPR64:$Rn, vecshiftR64:$imm)>;
def : Pat<(v1f64 (int_aarch64_neon_vcvtfxs2fp (v1i64 FPR64:$Rn),
                                            vecshiftR64:$imm)),
          (SCVTFd FPR64:$Rn, vecshiftR64:$imm)>;
def : Pat<(v1f64 (int_aarch64_neon_vcvtfxu2fp (v1i64 FPR64:$Rn),
                                            vecshiftR64:$imm)),
          (UCVTFd FPR64:$Rn, vecshiftR64:$imm)>;

defm SHL      : SIMDScalarLShiftD<   0, 0b01010, "shl", AArch64vshl>;
defm SLI      : SIMDScalarLShiftDTied<1, 0b01010, "sli">;
defm SQRSHRN  : SIMDScalarRShiftBHS< 0, 0b10011, "sqrshrn",
                                     int_aarch64_neon_sqrshrn>;
defm SQRSHRUN : SIMDScalarRShiftBHS< 1, 0b10001, "sqrshrun",
                                     int_aarch64_neon_sqrshrun>;
defm SQSHLU   : SIMDScalarLShiftBHSD<1, 0b01100, "sqshlu", AArch64sqshlui>;
defm SQSHL    : SIMDScalarLShiftBHSD<0, 0b01110, "sqshl", AArch64sqshli>;
defm SQSHRN   : SIMDScalarRShiftBHS< 0, 0b10010, "sqshrn",
                                     int_aarch64_neon_sqshrn>;
defm SQSHRUN  : SIMDScalarRShiftBHS< 1, 0b10000, "sqshrun",
                                     int_aarch64_neon_sqshrun>;
defm SRI      : SIMDScalarRShiftDTied<   1, 0b01000, "sri">;
defm SRSHR    : SIMDScalarRShiftD<   0, 0b00100, "srshr", AArch64srshri>;
defm SRSRA    : SIMDScalarRShiftDTied<   0, 0b00110, "srsra",
    TriOpFrag<(add node:$LHS,
                   (AArch64srshri node:$MHS, node:$RHS))>>;
defm SSHR     : SIMDScalarRShiftD<   0, 0b00000, "sshr", AArch64vashr>;
defm SSRA     : SIMDScalarRShiftDTied<   0, 0b00010, "ssra",
    TriOpFrag<(add node:$LHS,
                   (AArch64vashr node:$MHS, node:$RHS))>>;
defm UQRSHRN  : SIMDScalarRShiftBHS< 1, 0b10011, "uqrshrn",
                                     int_aarch64_neon_uqrshrn>;
defm UQSHL    : SIMDScalarLShiftBHSD<1, 0b01110, "uqshl", AArch64uqshli>;
defm UQSHRN   : SIMDScalarRShiftBHS< 1, 0b10010, "uqshrn",
                                     int_aarch64_neon_uqshrn>;
defm URSHR    : SIMDScalarRShiftD<   1, 0b00100, "urshr", AArch64urshri>;
defm URSRA    : SIMDScalarRShiftDTied<   1, 0b00110, "ursra",
    TriOpFrag<(add node:$LHS,
                   (AArch64urshri node:$MHS, node:$RHS))>>;
defm USHR     : SIMDScalarRShiftD<   1, 0b00000, "ushr", AArch64vlshr>;
defm USRA     : SIMDScalarRShiftDTied<   1, 0b00010, "usra",
    TriOpFrag<(add node:$LHS,
                   (AArch64vlshr node:$MHS, node:$RHS))>>;

//----------------------------------------------------------------------------
// AdvSIMD vector shift instructions
//----------------------------------------------------------------------------
defm FCVTZS:SIMDVectorRShiftSD<0, 0b11111, "fcvtzs", int_aarch64_neon_vcvtfp2fxs>;
defm FCVTZU:SIMDVectorRShiftSD<1, 0b11111, "fcvtzu", int_aarch64_neon_vcvtfp2fxu>;
defm SCVTF: SIMDVectorRShiftToFP<0, 0b11100, "scvtf",
                                   int_aarch64_neon_vcvtfxs2fp>;
defm RSHRN   : SIMDVectorRShiftNarrowBHS<0, 0b10001, "rshrn",
                                         int_aarch64_neon_rshrn>;
defm SHL     : SIMDVectorLShiftBHSD<0, 0b01010, "shl", AArch64vshl>;
defm SHRN    : SIMDVectorRShiftNarrowBHS<0, 0b10000, "shrn",
                          BinOpFrag<(trunc (AArch64vashr node:$LHS, node:$RHS))>>;
defm SLI     : SIMDVectorLShiftBHSDTied<1, 0b01010, "sli", int_aarch64_neon_vsli>;
def : Pat<(v1i64 (int_aarch64_neon_vsli (v1i64 FPR64:$Rd), (v1i64 FPR64:$Rn),
                                      (i32 vecshiftL64:$imm))),
          (SLId FPR64:$Rd, FPR64:$Rn, vecshiftL64:$imm)>;
defm SQRSHRN : SIMDVectorRShiftNarrowBHS<0, 0b10011, "sqrshrn",
                                         int_aarch64_neon_sqrshrn>;
defm SQRSHRUN: SIMDVectorRShiftNarrowBHS<1, 0b10001, "sqrshrun",
                                         int_aarch64_neon_sqrshrun>;
defm SQSHLU : SIMDVectorLShiftBHSD<1, 0b01100, "sqshlu", AArch64sqshlui>;
defm SQSHL  : SIMDVectorLShiftBHSD<0, 0b01110, "sqshl", AArch64sqshli>;
defm SQSHRN  : SIMDVectorRShiftNarrowBHS<0, 0b10010, "sqshrn",
                                         int_aarch64_neon_sqshrn>;
defm SQSHRUN : SIMDVectorRShiftNarrowBHS<1, 0b10000, "sqshrun",
                                         int_aarch64_neon_sqshrun>;
defm SRI     : SIMDVectorRShiftBHSDTied<1, 0b01000, "sri", int_aarch64_neon_vsri>;
def : Pat<(v1i64 (int_aarch64_neon_vsri (v1i64 FPR64:$Rd), (v1i64 FPR64:$Rn),
                                      (i32 vecshiftR64:$imm))),
          (SRId FPR64:$Rd, FPR64:$Rn, vecshiftR64:$imm)>;
defm SRSHR   : SIMDVectorRShiftBHSD<0, 0b00100, "srshr", AArch64srshri>;
defm SRSRA   : SIMDVectorRShiftBHSDTied<0, 0b00110, "srsra",
                 TriOpFrag<(add node:$LHS,
                                (AArch64srshri node:$MHS, node:$RHS))> >;
defm SSHLL   : SIMDVectorLShiftLongBHSD<0, 0b10100, "sshll",
                BinOpFrag<(AArch64vshl (sext node:$LHS), node:$RHS)>>;

defm SSHR    : SIMDVectorRShiftBHSD<0, 0b00000, "sshr", AArch64vashr>;
defm SSRA    : SIMDVectorRShiftBHSDTied<0, 0b00010, "ssra",
                TriOpFrag<(add node:$LHS, (AArch64vashr node:$MHS, node:$RHS))>>;
defm UCVTF   : SIMDVectorRShiftToFP<1, 0b11100, "ucvtf",
                        int_aarch64_neon_vcvtfxu2fp>;
defm UQRSHRN : SIMDVectorRShiftNarrowBHS<1, 0b10011, "uqrshrn",
                                         int_aarch64_neon_uqrshrn>;
defm UQSHL   : SIMDVectorLShiftBHSD<1, 0b01110, "uqshl", AArch64uqshli>;
defm UQSHRN  : SIMDVectorRShiftNarrowBHS<1, 0b10010, "uqshrn",
                                         int_aarch64_neon_uqshrn>;
defm URSHR   : SIMDVectorRShiftBHSD<1, 0b00100, "urshr", AArch64urshri>;
defm URSRA   : SIMDVectorRShiftBHSDTied<1, 0b00110, "ursra",
                TriOpFrag<(add node:$LHS,
                               (AArch64urshri node:$MHS, node:$RHS))> >;
defm USHLL   : SIMDVectorLShiftLongBHSD<1, 0b10100, "ushll",
                BinOpFrag<(AArch64vshl (zext node:$LHS), node:$RHS)>>;
defm USHR    : SIMDVectorRShiftBHSD<1, 0b00000, "ushr", AArch64vlshr>;
defm USRA    : SIMDVectorRShiftBHSDTied<1, 0b00010, "usra",
                TriOpFrag<(add node:$LHS, (AArch64vlshr node:$MHS, node:$RHS))> >;

// SHRN patterns for when a logical right shift was used instead of arithmetic
// (the immediate guarantees no sign bits actually end up in the result so it
// doesn't matter).
def : Pat<(v8i8 (trunc (AArch64vlshr (v8i16 V128:$Rn), vecshiftR16Narrow:$imm))),
          (SHRNv8i8_shift V128:$Rn, vecshiftR16Narrow:$imm)>;
def : Pat<(v4i16 (trunc (AArch64vlshr (v4i32 V128:$Rn), vecshiftR32Narrow:$imm))),
          (SHRNv4i16_shift V128:$Rn, vecshiftR32Narrow:$imm)>;
def : Pat<(v2i32 (trunc (AArch64vlshr (v2i64 V128:$Rn), vecshiftR64Narrow:$imm))),
          (SHRNv2i32_shift V128:$Rn, vecshiftR64Narrow:$imm)>;

def : Pat<(v16i8 (concat_vectors (v8i8 V64:$Rd),
                                 (trunc (AArch64vlshr (v8i16 V128:$Rn),
                                                    vecshiftR16Narrow:$imm)))),
          (SHRNv16i8_shift (INSERT_SUBREG (IMPLICIT_DEF), V64:$Rd, dsub),
                           V128:$Rn, vecshiftR16Narrow:$imm)>;
def : Pat<(v8i16 (concat_vectors (v4i16 V64:$Rd),
                                 (trunc (AArch64vlshr (v4i32 V128:$Rn),
                                                    vecshiftR32Narrow:$imm)))),
          (SHRNv8i16_shift (INSERT_SUBREG (IMPLICIT_DEF), V64:$Rd, dsub),
                           V128:$Rn, vecshiftR32Narrow:$imm)>;
def : Pat<(v4i32 (concat_vectors (v2i32 V64:$Rd),
                                 (trunc (AArch64vlshr (v2i64 V128:$Rn),
                                                    vecshiftR64Narrow:$imm)))),
          (SHRNv4i32_shift (INSERT_SUBREG (IMPLICIT_DEF), V64:$Rd, dsub),
                           V128:$Rn, vecshiftR32Narrow:$imm)>;

// Vector sign and zero extensions are implemented with SSHLL and USSHLL.
// Anyexts are implemented as zexts.
def : Pat<(v8i16 (sext   (v8i8 V64:$Rn))),  (SSHLLv8i8_shift  V64:$Rn, (i32 0))>;
def : Pat<(v8i16 (zext   (v8i8 V64:$Rn))),  (USHLLv8i8_shift  V64:$Rn, (i32 0))>;
def : Pat<(v8i16 (anyext (v8i8 V64:$Rn))),  (USHLLv8i8_shift  V64:$Rn, (i32 0))>;
def : Pat<(v4i32 (sext   (v4i16 V64:$Rn))), (SSHLLv4i16_shift V64:$Rn, (i32 0))>;
def : Pat<(v4i32 (zext   (v4i16 V64:$Rn))), (USHLLv4i16_shift V64:$Rn, (i32 0))>;
def : Pat<(v4i32 (anyext (v4i16 V64:$Rn))), (USHLLv4i16_shift V64:$Rn, (i32 0))>;
def : Pat<(v2i64 (sext   (v2i32 V64:$Rn))), (SSHLLv2i32_shift V64:$Rn, (i32 0))>;
def : Pat<(v2i64 (zext   (v2i32 V64:$Rn))), (USHLLv2i32_shift V64:$Rn, (i32 0))>;
def : Pat<(v2i64 (anyext (v2i32 V64:$Rn))), (USHLLv2i32_shift V64:$Rn, (i32 0))>;
// Also match an extend from the upper half of a 128 bit source register.
def : Pat<(v8i16 (anyext (v8i8 (extract_subvector V128:$Rn, (i64 8)) ))),
          (USHLLv16i8_shift V128:$Rn, (i32 0))>;
def : Pat<(v8i16 (zext   (v8i8 (extract_subvector V128:$Rn, (i64 8)) ))),
          (USHLLv16i8_shift V128:$Rn, (i32 0))>;
def : Pat<(v8i16 (sext   (v8i8 (extract_subvector V128:$Rn, (i64 8)) ))),
          (SSHLLv16i8_shift V128:$Rn, (i32 0))>;
def : Pat<(v4i32 (anyext (v4i16 (extract_subvector V128:$Rn, (i64 4)) ))),
          (USHLLv8i16_shift V128:$Rn, (i32 0))>;
def : Pat<(v4i32 (zext   (v4i16 (extract_subvector V128:$Rn, (i64 4)) ))),
          (USHLLv8i16_shift V128:$Rn, (i32 0))>;
def : Pat<(v4i32 (sext   (v4i16 (extract_subvector V128:$Rn, (i64 4)) ))),
          (SSHLLv8i16_shift V128:$Rn, (i32 0))>;
def : Pat<(v2i64 (anyext (v2i32 (extract_subvector V128:$Rn, (i64 2)) ))),
          (USHLLv4i32_shift V128:$Rn, (i32 0))>;
def : Pat<(v2i64 (zext   (v2i32 (extract_subvector V128:$Rn, (i64 2)) ))),
          (USHLLv4i32_shift V128:$Rn, (i32 0))>;
def : Pat<(v2i64 (sext   (v2i32 (extract_subvector V128:$Rn, (i64 2)) ))),
          (SSHLLv4i32_shift V128:$Rn, (i32 0))>;

// Vector shift sxtl aliases
def : InstAlias<"sxtl.8h $dst, $src1",
                (SSHLLv8i8_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"sxtl $dst.8h, $src1.8b",
                (SSHLLv8i8_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"sxtl.4s $dst, $src1",
                (SSHLLv4i16_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"sxtl $dst.4s, $src1.4h",
                (SSHLLv4i16_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"sxtl.2d $dst, $src1",
                (SSHLLv2i32_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"sxtl $dst.2d, $src1.2s",
                (SSHLLv2i32_shift V128:$dst, V64:$src1, 0)>;

// Vector shift sxtl2 aliases
def : InstAlias<"sxtl2.8h $dst, $src1",
                (SSHLLv16i8_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"sxtl2 $dst.8h, $src1.16b",
                (SSHLLv16i8_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"sxtl2.4s $dst, $src1",
                (SSHLLv8i16_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"sxtl2 $dst.4s, $src1.8h",
                (SSHLLv8i16_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"sxtl2.2d $dst, $src1",
                (SSHLLv4i32_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"sxtl2 $dst.2d, $src1.4s",
                (SSHLLv4i32_shift V128:$dst, V128:$src1, 0)>;

// Vector shift uxtl aliases
def : InstAlias<"uxtl.8h $dst, $src1",
                (USHLLv8i8_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"uxtl $dst.8h, $src1.8b",
                (USHLLv8i8_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"uxtl.4s $dst, $src1",
                (USHLLv4i16_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"uxtl $dst.4s, $src1.4h",
                (USHLLv4i16_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"uxtl.2d $dst, $src1",
                (USHLLv2i32_shift V128:$dst, V64:$src1, 0)>;
def : InstAlias<"uxtl $dst.2d, $src1.2s",
                (USHLLv2i32_shift V128:$dst, V64:$src1, 0)>;

// Vector shift uxtl2 aliases
def : InstAlias<"uxtl2.8h $dst, $src1",
                (USHLLv16i8_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"uxtl2 $dst.8h, $src1.16b",
                (USHLLv16i8_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"uxtl2.4s $dst, $src1",
                (USHLLv8i16_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"uxtl2 $dst.4s, $src1.8h",
                (USHLLv8i16_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"uxtl2.2d $dst, $src1",
                (USHLLv4i32_shift V128:$dst, V128:$src1, 0)>;
def : InstAlias<"uxtl2 $dst.2d, $src1.4s",
                (USHLLv4i32_shift V128:$dst, V128:$src1, 0)>;

// If an integer is about to be converted to a floating point value,
// just load it on the floating point unit.
// These patterns are more complex because floating point loads do not
// support sign extension.
// The sign extension has to be explicitly added and is only supported for
// one step: byte-to-half, half-to-word, word-to-doubleword.
// SCVTF GPR -> FPR is 9 cycles.
// SCVTF FPR -> FPR is 4 cyclces.
// (sign extension with lengthen) SXTL FPR -> FPR is 2 cycles.
// Therefore, we can do 2 sign extensions and one SCVTF FPR -> FPR
// and still being faster.
// However, this is not good for code size.
// 8-bits -> float. 2 sizes step-up.
class SExtLoadi8CVTf32Pat<dag addrmode, dag INST>
  : Pat<(f32 (sint_to_fp (i32 (sextloadi8 addrmode)))),
        (SCVTFv1i32 (f32 (EXTRACT_SUBREG
                            (SSHLLv4i16_shift
                              (f64
                                (EXTRACT_SUBREG
                                  (SSHLLv8i8_shift
                                    (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                                        INST,
                                        bsub),
                                    0),
                                  dsub)),
                               0),
                             ssub)))>,
    Requires<[NotForCodeSize, UseAlternateSExtLoadCVTF32]>;

def : SExtLoadi8CVTf32Pat<(ro8.Wpat GPR64sp:$Rn, GPR32:$Rm, ro8.Wext:$ext),
                          (LDRBroW  GPR64sp:$Rn, GPR32:$Rm, ro8.Wext:$ext)>;
def : SExtLoadi8CVTf32Pat<(ro8.Xpat GPR64sp:$Rn, GPR64:$Rm, ro8.Xext:$ext),
                          (LDRBroX  GPR64sp:$Rn, GPR64:$Rm, ro8.Xext:$ext)>;
def : SExtLoadi8CVTf32Pat<(am_indexed8 GPR64sp:$Rn, uimm12s1:$offset),
                          (LDRBui GPR64sp:$Rn, uimm12s1:$offset)>;
def : SExtLoadi8CVTf32Pat<(am_unscaled8 GPR64sp:$Rn, simm9:$offset),
                          (LDURBi GPR64sp:$Rn, simm9:$offset)>;

// 16-bits -> float. 1 size step-up.
class SExtLoadi16CVTf32Pat<dag addrmode, dag INST>
  : Pat<(f32 (sint_to_fp (i32 (sextloadi16 addrmode)))),
        (SCVTFv1i32 (f32 (EXTRACT_SUBREG
                            (SSHLLv4i16_shift
                                (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                                  INST,
                                  hsub),
                                0),
                            ssub)))>, Requires<[NotForCodeSize]>;

def : SExtLoadi16CVTf32Pat<(ro16.Wpat GPR64sp:$Rn, GPR32:$Rm, ro16.Wext:$ext),
                           (LDRHroW   GPR64sp:$Rn, GPR32:$Rm, ro16.Wext:$ext)>;
def : SExtLoadi16CVTf32Pat<(ro16.Xpat GPR64sp:$Rn, GPR64:$Rm, ro16.Xext:$ext),
                           (LDRHroX   GPR64sp:$Rn, GPR64:$Rm, ro16.Xext:$ext)>;
def : SExtLoadi16CVTf32Pat<(am_indexed16 GPR64sp:$Rn, uimm12s2:$offset),
                           (LDRHui GPR64sp:$Rn, uimm12s2:$offset)>;
def : SExtLoadi16CVTf32Pat<(am_unscaled16 GPR64sp:$Rn, simm9:$offset),
                           (LDURHi GPR64sp:$Rn, simm9:$offset)>;

// 32-bits to 32-bits are handled in target specific dag combine:
// performIntToFpCombine.
// 64-bits integer to 32-bits floating point, not possible with
// SCVTF on floating point registers (both source and destination
// must have the same size).

// Here are the patterns for 8, 16, 32, and 64-bits to double.
// 8-bits -> double. 3 size step-up: give up.
// 16-bits -> double. 2 size step.
class SExtLoadi16CVTf64Pat<dag addrmode, dag INST>
  : Pat <(f64 (sint_to_fp (i32 (sextloadi16 addrmode)))),
           (SCVTFv1i64 (f64 (EXTRACT_SUBREG
                              (SSHLLv2i32_shift
                                 (f64
                                  (EXTRACT_SUBREG
                                    (SSHLLv4i16_shift
                                      (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                                        INST,
                                        hsub),
                                     0),
                                   dsub)),
                               0),
                             dsub)))>,
    Requires<[NotForCodeSize, UseAlternateSExtLoadCVTF32]>;
 
def : SExtLoadi16CVTf64Pat<(ro16.Wpat GPR64sp:$Rn, GPR32:$Rm, ro16.Wext:$ext),
                           (LDRHroW GPR64sp:$Rn, GPR32:$Rm, ro16.Wext:$ext)>;
def : SExtLoadi16CVTf64Pat<(ro16.Xpat GPR64sp:$Rn, GPR64:$Rm, ro16.Xext:$ext),
                           (LDRHroX GPR64sp:$Rn, GPR64:$Rm, ro16.Xext:$ext)>;
def : SExtLoadi16CVTf64Pat<(am_indexed16 GPR64sp:$Rn, uimm12s2:$offset),
                           (LDRHui GPR64sp:$Rn, uimm12s2:$offset)>;
def : SExtLoadi16CVTf64Pat<(am_unscaled16 GPR64sp:$Rn, simm9:$offset),
                           (LDURHi GPR64sp:$Rn, simm9:$offset)>;
// 32-bits -> double. 1 size step-up.
class SExtLoadi32CVTf64Pat<dag addrmode, dag INST>
  : Pat <(f64 (sint_to_fp (i32 (load addrmode)))),
           (SCVTFv1i64 (f64 (EXTRACT_SUBREG
                              (SSHLLv2i32_shift
                                (INSERT_SUBREG (f64 (IMPLICIT_DEF)),
                                  INST,
                                  ssub),
                               0),
                             dsub)))>, Requires<[NotForCodeSize]>;

def : SExtLoadi32CVTf64Pat<(ro32.Wpat GPR64sp:$Rn, GPR32:$Rm, ro32.Wext:$ext),
                           (LDRSroW GPR64sp:$Rn, GPR32:$Rm, ro32.Wext:$ext)>;
def : SExtLoadi32CVTf64Pat<(ro32.Xpat GPR64sp:$Rn, GPR64:$Rm, ro32.Xext:$ext),
                           (LDRSroX GPR64sp:$Rn, GPR64:$Rm, ro32.Xext:$ext)>;
def : SExtLoadi32CVTf64Pat<(am_indexed32 GPR64sp:$Rn, uimm12s4:$offset),
                           (LDRSui GPR64sp:$Rn, uimm12s4:$offset)>;
def : SExtLoadi32CVTf64Pat<(am_unscaled32 GPR64sp:$Rn, simm9:$offset),
                           (LDURSi GPR64sp:$Rn, simm9:$offset)>;

// 64-bits -> double are handled in target specific dag combine:
// performIntToFpCombine.


//----------------------------------------------------------------------------
// AdvSIMD Load-Store Structure
//----------------------------------------------------------------------------
defm LD1 : SIMDLd1Multiple<"ld1">;
defm LD2 : SIMDLd2Multiple<"ld2">;
defm LD3 : SIMDLd3Multiple<"ld3">;
defm LD4 : SIMDLd4Multiple<"ld4">;

defm ST1 : SIMDSt1Multiple<"st1">;
defm ST2 : SIMDSt2Multiple<"st2">;
defm ST3 : SIMDSt3Multiple<"st3">;
defm ST4 : SIMDSt4Multiple<"st4">;

class Ld1Pat<ValueType ty, Instruction INST>
  : Pat<(ty (load GPR64sp:$Rn)), (INST GPR64sp:$Rn)>;

def : Ld1Pat<v16i8, LD1Onev16b>;
def : Ld1Pat<v8i16, LD1Onev8h>;
def : Ld1Pat<v4i32, LD1Onev4s>;
def : Ld1Pat<v2i64, LD1Onev2d>;
def : Ld1Pat<v8i8,  LD1Onev8b>;
def : Ld1Pat<v4i16, LD1Onev4h>;
def : Ld1Pat<v2i32, LD1Onev2s>;
def : Ld1Pat<v1i64, LD1Onev1d>;

class St1Pat<ValueType ty, Instruction INST>
  : Pat<(store ty:$Vt, GPR64sp:$Rn),
        (INST ty:$Vt, GPR64sp:$Rn)>;

def : St1Pat<v16i8, ST1Onev16b>;
def : St1Pat<v8i16, ST1Onev8h>;
def : St1Pat<v4i32, ST1Onev4s>;
def : St1Pat<v2i64, ST1Onev2d>;
def : St1Pat<v8i8,  ST1Onev8b>;
def : St1Pat<v4i16, ST1Onev4h>;
def : St1Pat<v2i32, ST1Onev2s>;
def : St1Pat<v1i64, ST1Onev1d>;

//---
// Single-element
//---

defm LD1R          : SIMDLdR<0, 0b110, 0, "ld1r", "One", 1, 2, 4, 8>;
defm LD2R          : SIMDLdR<1, 0b110, 0, "ld2r", "Two", 2, 4, 8, 16>;
defm LD3R          : SIMDLdR<0, 0b111, 0, "ld3r", "Three", 3, 6, 12, 24>;
defm LD4R          : SIMDLdR<1, 0b111, 0, "ld4r", "Four", 4, 8, 16, 32>;
let mayLoad = 1, hasSideEffects = 0 in {
defm LD1 : SIMDLdSingleBTied<0, 0b000,       "ld1", VecListOneb,   GPR64pi1>;
defm LD1 : SIMDLdSingleHTied<0, 0b010, 0,    "ld1", VecListOneh,   GPR64pi2>;
defm LD1 : SIMDLdSingleSTied<0, 0b100, 0b00, "ld1", VecListOnes,   GPR64pi4>;
defm LD1 : SIMDLdSingleDTied<0, 0b100, 0b01, "ld1", VecListOned,   GPR64pi8>;
defm LD2 : SIMDLdSingleBTied<1, 0b000,       "ld2", VecListTwob,   GPR64pi2>;
defm LD2 : SIMDLdSingleHTied<1, 0b010, 0,    "ld2", VecListTwoh,   GPR64pi4>;
defm LD2 : SIMDLdSingleSTied<1, 0b100, 0b00, "ld2", VecListTwos,   GPR64pi8>;
defm LD2 : SIMDLdSingleDTied<1, 0b100, 0b01, "ld2", VecListTwod,   GPR64pi16>;
defm LD3 : SIMDLdSingleBTied<0, 0b001,       "ld3", VecListThreeb, GPR64pi3>;
defm LD3 : SIMDLdSingleHTied<0, 0b011, 0,    "ld3", VecListThreeh, GPR64pi6>;
defm LD3 : SIMDLdSingleSTied<0, 0b101, 0b00, "ld3", VecListThrees, GPR64pi12>;
defm LD3 : SIMDLdSingleDTied<0, 0b101, 0b01, "ld3", VecListThreed, GPR64pi24>;
defm LD4 : SIMDLdSingleBTied<1, 0b001,       "ld4", VecListFourb,  GPR64pi4>;
defm LD4 : SIMDLdSingleHTied<1, 0b011, 0,    "ld4", VecListFourh,  GPR64pi8>;
defm LD4 : SIMDLdSingleSTied<1, 0b101, 0b00, "ld4", VecListFours,  GPR64pi16>;
defm LD4 : SIMDLdSingleDTied<1, 0b101, 0b01, "ld4", VecListFourd,  GPR64pi32>;
}

def : Pat<(v8i8 (AArch64dup (i32 (extloadi8 GPR64sp:$Rn)))),
          (LD1Rv8b GPR64sp:$Rn)>;
def : Pat<(v16i8 (AArch64dup (i32 (extloadi8 GPR64sp:$Rn)))),
          (LD1Rv16b GPR64sp:$Rn)>;
def : Pat<(v4i16 (AArch64dup (i32 (extloadi16 GPR64sp:$Rn)))),
          (LD1Rv4h GPR64sp:$Rn)>;
def : Pat<(v8i16 (AArch64dup (i32 (extloadi16 GPR64sp:$Rn)))),
          (LD1Rv8h GPR64sp:$Rn)>;
def : Pat<(v2i32 (AArch64dup (i32 (load GPR64sp:$Rn)))),
          (LD1Rv2s GPR64sp:$Rn)>;
def : Pat<(v4i32 (AArch64dup (i32 (load GPR64sp:$Rn)))),
          (LD1Rv4s GPR64sp:$Rn)>;
def : Pat<(v2i64 (AArch64dup (i64 (load GPR64sp:$Rn)))),
          (LD1Rv2d GPR64sp:$Rn)>;
def : Pat<(v1i64 (AArch64dup (i64 (load GPR64sp:$Rn)))),
          (LD1Rv1d GPR64sp:$Rn)>;
// Grab the floating point version too
def : Pat<(v2f32 (AArch64dup (f32 (load GPR64sp:$Rn)))),
          (LD1Rv2s GPR64sp:$Rn)>;
def : Pat<(v4f32 (AArch64dup (f32 (load GPR64sp:$Rn)))),
          (LD1Rv4s GPR64sp:$Rn)>;
def : Pat<(v2f64 (AArch64dup (f64 (load GPR64sp:$Rn)))),
          (LD1Rv2d GPR64sp:$Rn)>;
def : Pat<(v1f64 (AArch64dup (f64 (load GPR64sp:$Rn)))),
          (LD1Rv1d GPR64sp:$Rn)>;
def : Pat<(v4f16 (AArch64dup (f16 (load GPR64sp:$Rn)))),
          (LD1Rv4h GPR64sp:$Rn)>;
def : Pat<(v8f16 (AArch64dup (f16 (load GPR64sp:$Rn)))),
          (LD1Rv8h GPR64sp:$Rn)>;

class Ld1Lane128Pat<SDPatternOperator scalar_load, Operand VecIndex,
                    ValueType VTy, ValueType STy, Instruction LD1>
  : Pat<(vector_insert (VTy VecListOne128:$Rd),
           (STy (scalar_load GPR64sp:$Rn)), VecIndex:$idx),
        (LD1 VecListOne128:$Rd, VecIndex:$idx, GPR64sp:$Rn)>;

def : Ld1Lane128Pat<extloadi8,  VectorIndexB, v16i8, i32, LD1i8>;
def : Ld1Lane128Pat<extloadi16, VectorIndexH, v8i16, i32, LD1i16>;
def : Ld1Lane128Pat<load,       VectorIndexS, v4i32, i32, LD1i32>;
def : Ld1Lane128Pat<load,       VectorIndexS, v4f32, f32, LD1i32>;
def : Ld1Lane128Pat<load,       VectorIndexD, v2i64, i64, LD1i64>;
def : Ld1Lane128Pat<load,       VectorIndexD, v2f64, f64, LD1i64>;
def : Ld1Lane128Pat<load,       VectorIndexH, v8f16, f16, LD1i16>;

class Ld1Lane64Pat<SDPatternOperator scalar_load, Operand VecIndex,
                   ValueType VTy, ValueType STy, Instruction LD1>
  : Pat<(vector_insert (VTy VecListOne64:$Rd),
           (STy (scalar_load GPR64sp:$Rn)), VecIndex:$idx),
        (EXTRACT_SUBREG
            (LD1 (SUBREG_TO_REG (i32 0), VecListOne64:$Rd, dsub),
                          VecIndex:$idx, GPR64sp:$Rn),
            dsub)>;

def : Ld1Lane64Pat<extloadi8,  VectorIndexB, v8i8,  i32, LD1i8>;
def : Ld1Lane64Pat<extloadi16, VectorIndexH, v4i16, i32, LD1i16>;
def : Ld1Lane64Pat<load,       VectorIndexS, v2i32, i32, LD1i32>;
def : Ld1Lane64Pat<load,       VectorIndexS, v2f32, f32, LD1i32>;
def : Ld1Lane64Pat<load,       VectorIndexH, v4f16, f16, LD1i16>;


defm LD1 : SIMDLdSt1SingleAliases<"ld1">;
defm LD2 : SIMDLdSt2SingleAliases<"ld2">;
defm LD3 : SIMDLdSt3SingleAliases<"ld3">;
defm LD4 : SIMDLdSt4SingleAliases<"ld4">;

// Stores
defm ST1 : SIMDStSingleB<0, 0b000,       "st1", VecListOneb, GPR64pi1>;
defm ST1 : SIMDStSingleH<0, 0b010, 0,    "st1", VecListOneh, GPR64pi2>;
defm ST1 : SIMDStSingleS<0, 0b100, 0b00, "st1", VecListOnes, GPR64pi4>;
defm ST1 : SIMDStSingleD<0, 0b100, 0b01, "st1", VecListOned, GPR64pi8>;

let AddedComplexity = 19 in
class St1Lane128Pat<SDPatternOperator scalar_store, Operand VecIndex,
                    ValueType VTy, ValueType STy, Instruction ST1>
  : Pat<(scalar_store
             (STy (vector_extract (VTy VecListOne128:$Vt), VecIndex:$idx)),
             GPR64sp:$Rn),
        (ST1 VecListOne128:$Vt, VecIndex:$idx, GPR64sp:$Rn)>;

def : St1Lane128Pat<truncstorei8,  VectorIndexB, v16i8, i32, ST1i8>;
def : St1Lane128Pat<truncstorei16, VectorIndexH, v8i16, i32, ST1i16>;
def : St1Lane128Pat<store,         VectorIndexS, v4i32, i32, ST1i32>;
def : St1Lane128Pat<store,         VectorIndexS, v4f32, f32, ST1i32>;
def : St1Lane128Pat<store,         VectorIndexD, v2i64, i64, ST1i64>;
def : St1Lane128Pat<store,         VectorIndexD, v2f64, f64, ST1i64>;
def : St1Lane128Pat<store,         VectorIndexH, v8f16, f16, ST1i16>;

let AddedComplexity = 19 in
class St1Lane64Pat<SDPatternOperator scalar_store, Operand VecIndex,
                   ValueType VTy, ValueType STy, Instruction ST1>
  : Pat<(scalar_store
             (STy (vector_extract (VTy VecListOne64:$Vt), VecIndex:$idx)),
             GPR64sp:$Rn),
        (ST1 (SUBREG_TO_REG (i32 0), VecListOne64:$Vt, dsub),
             VecIndex:$idx, GPR64sp:$Rn)>;

def : St1Lane64Pat<truncstorei8,  VectorIndexB, v8i8, i32, ST1i8>;
def : St1Lane64Pat<truncstorei16, VectorIndexH, v4i16, i32, ST1i16>;
def : St1Lane64Pat<store,         VectorIndexS, v2i32, i32, ST1i32>;
def : St1Lane64Pat<store,         VectorIndexS, v2f32, f32, ST1i32>;
def : St1Lane64Pat<store,         VectorIndexH, v4f16, f16, ST1i16>;

multiclass St1LanePost64Pat<SDPatternOperator scalar_store, Operand VecIndex,
                             ValueType VTy, ValueType STy, Instruction ST1,
                             int offset> {
  def : Pat<(scalar_store
              (STy (vector_extract (VTy VecListOne64:$Vt), VecIndex:$idx)),
              GPR64sp:$Rn, offset),
        (ST1 (SUBREG_TO_REG (i32 0), VecListOne64:$Vt, dsub),
             VecIndex:$idx, GPR64sp:$Rn, XZR)>;

  def : Pat<(scalar_store
              (STy (vector_extract (VTy VecListOne64:$Vt), VecIndex:$idx)),
              GPR64sp:$Rn, GPR64:$Rm),
        (ST1 (SUBREG_TO_REG (i32 0), VecListOne64:$Vt, dsub),
             VecIndex:$idx, GPR64sp:$Rn, $Rm)>;
}

defm : St1LanePost64Pat<post_truncsti8, VectorIndexB, v8i8, i32, ST1i8_POST, 1>;
defm : St1LanePost64Pat<post_truncsti16, VectorIndexH, v4i16, i32, ST1i16_POST,
                        2>;
defm : St1LanePost64Pat<post_store, VectorIndexS, v2i32, i32, ST1i32_POST, 4>;
defm : St1LanePost64Pat<post_store, VectorIndexS, v2f32, f32, ST1i32_POST, 4>;
defm : St1LanePost64Pat<post_store, VectorIndexD, v1i64, i64, ST1i64_POST, 8>;
defm : St1LanePost64Pat<post_store, VectorIndexD, v1f64, f64, ST1i64_POST, 8>;
defm : St1LanePost64Pat<post_store, VectorIndexH, v4f16, f16, ST1i16_POST, 2>;

multiclass St1LanePost128Pat<SDPatternOperator scalar_store, Operand VecIndex,
                             ValueType VTy, ValueType STy, Instruction ST1,
                             int offset> {
  def : Pat<(scalar_store
              (STy (vector_extract (VTy VecListOne128:$Vt), VecIndex:$idx)),
              GPR64sp:$Rn, offset),
        (ST1 VecListOne128:$Vt, VecIndex:$idx, GPR64sp:$Rn, XZR)>;

  def : Pat<(scalar_store
              (STy (vector_extract (VTy VecListOne128:$Vt), VecIndex:$idx)),
              GPR64sp:$Rn, GPR64:$Rm),
        (ST1 VecListOne128:$Vt, VecIndex:$idx, GPR64sp:$Rn, $Rm)>;
}

defm : St1LanePost128Pat<post_truncsti8, VectorIndexB, v16i8, i32, ST1i8_POST,
                         1>;
defm : St1LanePost128Pat<post_truncsti16, VectorIndexH, v8i16, i32, ST1i16_POST,
                         2>;
defm : St1LanePost128Pat<post_store, VectorIndexS, v4i32, i32, ST1i32_POST, 4>;
defm : St1LanePost128Pat<post_store, VectorIndexS, v4f32, f32, ST1i32_POST, 4>;
defm : St1LanePost128Pat<post_store, VectorIndexD, v2i64, i64, ST1i64_POST, 8>;
defm : St1LanePost128Pat<post_store, VectorIndexD, v2f64, f64, ST1i64_POST, 8>;
defm : St1LanePost128Pat<post_store, VectorIndexH, v8f16, f16, ST1i16_POST, 2>;

let mayStore = 1, hasSideEffects = 0 in {
defm ST2 : SIMDStSingleB<1, 0b000,       "st2", VecListTwob,   GPR64pi2>;
defm ST2 : SIMDStSingleH<1, 0b010, 0,    "st2", VecListTwoh,   GPR64pi4>;
defm ST2 : SIMDStSingleS<1, 0b100, 0b00, "st2", VecListTwos,   GPR64pi8>;
defm ST2 : SIMDStSingleD<1, 0b100, 0b01, "st2", VecListTwod,   GPR64pi16>;
defm ST3 : SIMDStSingleB<0, 0b001,       "st3", VecListThreeb, GPR64pi3>;
defm ST3 : SIMDStSingleH<0, 0b011, 0,    "st3", VecListThreeh, GPR64pi6>;
defm ST3 : SIMDStSingleS<0, 0b101, 0b00, "st3", VecListThrees, GPR64pi12>;
defm ST3 : SIMDStSingleD<0, 0b101, 0b01, "st3", VecListThreed, GPR64pi24>;
defm ST4 : SIMDStSingleB<1, 0b001,       "st4", VecListFourb,  GPR64pi4>;
defm ST4 : SIMDStSingleH<1, 0b011, 0,    "st4", VecListFourh,  GPR64pi8>;
defm ST4 : SIMDStSingleS<1, 0b101, 0b00, "st4", VecListFours,  GPR64pi16>;
defm ST4 : SIMDStSingleD<1, 0b101, 0b01, "st4", VecListFourd,  GPR64pi32>;
}

defm ST1 : SIMDLdSt1SingleAliases<"st1">;
defm ST2 : SIMDLdSt2SingleAliases<"st2">;
defm ST3 : SIMDLdSt3SingleAliases<"st3">;
defm ST4 : SIMDLdSt4SingleAliases<"st4">;

//----------------------------------------------------------------------------
// Crypto extensions
//----------------------------------------------------------------------------

def AESErr   : AESTiedInst<0b0100, "aese",   int_aarch64_crypto_aese>;
def AESDrr   : AESTiedInst<0b0101, "aesd",   int_aarch64_crypto_aesd>;
def AESMCrr  : AESInst<    0b0110, "aesmc",  int_aarch64_crypto_aesmc>;
def AESIMCrr : AESInst<    0b0111, "aesimc", int_aarch64_crypto_aesimc>;

def SHA1Crrr     : SHATiedInstQSV<0b000, "sha1c",   int_aarch64_crypto_sha1c>;
def SHA1Prrr     : SHATiedInstQSV<0b001, "sha1p",   int_aarch64_crypto_sha1p>;
def SHA1Mrrr     : SHATiedInstQSV<0b010, "sha1m",   int_aarch64_crypto_sha1m>;
def SHA1SU0rrr   : SHATiedInstVVV<0b011, "sha1su0", int_aarch64_crypto_sha1su0>;
def SHA256Hrrr   : SHATiedInstQQV<0b100, "sha256h", int_aarch64_crypto_sha256h>;
def SHA256H2rrr  : SHATiedInstQQV<0b101, "sha256h2",int_aarch64_crypto_sha256h2>;
def SHA256SU1rrr :SHATiedInstVVV<0b110, "sha256su1",int_aarch64_crypto_sha256su1>;

def SHA1Hrr     : SHAInstSS<    0b0000, "sha1h",    int_aarch64_crypto_sha1h>;
def SHA1SU1rr   : SHATiedInstVV<0b0001, "sha1su1",  int_aarch64_crypto_sha1su1>;
def SHA256SU0rr : SHATiedInstVV<0b0010, "sha256su0",int_aarch64_crypto_sha256su0>;

//----------------------------------------------------------------------------
// Compiler-pseudos
//----------------------------------------------------------------------------
// FIXME: Like for X86, these should go in their own separate .td file.

// Any instruction that defines a 32-bit result leaves the high half of the
// register. Truncate can be lowered to EXTRACT_SUBREG. CopyFromReg may
// be copying from a truncate. But any other 32-bit operation will zero-extend
// up to 64 bits.
// FIXME: X86 also checks for CMOV here. Do we need something similar?
def def32 : PatLeaf<(i32 GPR32:$src), [{
  return N->getOpcode() != ISD::TRUNCATE &&
         N->getOpcode() != TargetOpcode::EXTRACT_SUBREG &&
         N->getOpcode() != ISD::CopyFromReg;
}]>;

// In the case of a 32-bit def that is known to implicitly zero-extend,
// we can use a SUBREG_TO_REG.
def : Pat<(i64 (zext def32:$src)), (SUBREG_TO_REG (i64 0), GPR32:$src, sub_32)>;

// For an anyext, we don't care what the high bits are, so we can perform an
// INSERT_SUBREF into an IMPLICIT_DEF.
def : Pat<(i64 (anyext GPR32:$src)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), GPR32:$src, sub_32)>;

// When we need to explicitly zero-extend, we use a 32-bit MOV instruction and
// then assert the extension has happened.
def : Pat<(i64 (zext GPR32:$src)),
          (SUBREG_TO_REG (i32 0), (ORRWrs WZR, GPR32:$src, 0), sub_32)>;

// To sign extend, we use a signed bitfield move instruction (SBFM) on the
// containing super-reg.
def : Pat<(i64 (sext GPR32:$src)),
   (SBFMXri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), GPR32:$src, sub_32), 0, 31)>;
def : Pat<(i64 (sext_inreg GPR64:$src, i32)), (SBFMXri GPR64:$src, 0, 31)>;
def : Pat<(i64 (sext_inreg GPR64:$src, i16)), (SBFMXri GPR64:$src, 0, 15)>;
def : Pat<(i64 (sext_inreg GPR64:$src, i8)),  (SBFMXri GPR64:$src, 0, 7)>;
def : Pat<(i64 (sext_inreg GPR64:$src, i1)),  (SBFMXri GPR64:$src, 0, 0)>;
def : Pat<(i32 (sext_inreg GPR32:$src, i16)), (SBFMWri GPR32:$src, 0, 15)>;
def : Pat<(i32 (sext_inreg GPR32:$src, i8)),  (SBFMWri GPR32:$src, 0, 7)>;
def : Pat<(i32 (sext_inreg GPR32:$src, i1)),  (SBFMWri GPR32:$src, 0, 0)>;

def : Pat<(shl (sext_inreg GPR32:$Rn, i8), (i64 imm0_31:$imm)),
          (SBFMWri GPR32:$Rn, (i64 (i32shift_a       imm0_31:$imm)),
                              (i64 (i32shift_sext_i8 imm0_31:$imm)))>;
def : Pat<(shl (sext_inreg GPR64:$Rn, i8), (i64 imm0_63:$imm)),
          (SBFMXri GPR64:$Rn, (i64 (i64shift_a imm0_63:$imm)),
                              (i64 (i64shift_sext_i8 imm0_63:$imm)))>;

def : Pat<(shl (sext_inreg GPR32:$Rn, i16), (i64 imm0_31:$imm)),
          (SBFMWri GPR32:$Rn, (i64 (i32shift_a        imm0_31:$imm)),
                              (i64 (i32shift_sext_i16 imm0_31:$imm)))>;
def : Pat<(shl (sext_inreg GPR64:$Rn, i16), (i64 imm0_63:$imm)),
          (SBFMXri GPR64:$Rn, (i64 (i64shift_a        imm0_63:$imm)),
                              (i64 (i64shift_sext_i16 imm0_63:$imm)))>;

def : Pat<(shl (i64 (sext GPR32:$Rn)), (i64 imm0_63:$imm)),
          (SBFMXri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), GPR32:$Rn, sub_32),
                   (i64 (i64shift_a        imm0_63:$imm)),
                   (i64 (i64shift_sext_i32 imm0_63:$imm)))>;

// sra patterns have an AddedComplexity of 10, so make sure we have a higher
// AddedComplexity for the following patterns since we want to match sext + sra
// patterns before we attempt to match a single sra node.
let AddedComplexity = 20 in {
// We support all sext + sra combinations which preserve at least one bit of the
// original value which is to be sign extended. E.g. we support shifts up to
// bitwidth-1 bits.
def : Pat<(sra (sext_inreg GPR32:$Rn, i8), (i64 imm0_7:$imm)),
          (SBFMWri GPR32:$Rn, (i64 imm0_7:$imm), 7)>;
def : Pat<(sra (sext_inreg GPR64:$Rn, i8), (i64 imm0_7:$imm)),
          (SBFMXri GPR64:$Rn, (i64 imm0_7:$imm), 7)>;

def : Pat<(sra (sext_inreg GPR32:$Rn, i16), (i64 imm0_15:$imm)),
          (SBFMWri GPR32:$Rn, (i64 imm0_15:$imm), 15)>;
def : Pat<(sra (sext_inreg GPR64:$Rn, i16), (i64 imm0_15:$imm)),
          (SBFMXri GPR64:$Rn, (i64 imm0_15:$imm), 15)>;

def : Pat<(sra (i64 (sext GPR32:$Rn)), (i64 imm0_31:$imm)),
          (SBFMXri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), GPR32:$Rn, sub_32),
                   (i64 imm0_31:$imm), 31)>;
} // AddedComplexity = 20

// To truncate, we can simply extract from a subregister.
def : Pat<(i32 (trunc GPR64sp:$src)),
          (i32 (EXTRACT_SUBREG GPR64sp:$src, sub_32))>;

// __builtin_trap() uses the BRK instruction on AArch64.
def : Pat<(trap), (BRK 1)>;

// Conversions within AdvSIMD types in the same register size are free.
// But because we need a consistent lane ordering, in big endian many
// conversions require one or more REV instructions.
//
// Consider a simple memory load followed by a bitconvert then a store.
//   v0 = load v2i32
//   v1 = BITCAST v2i32 v0 to v4i16
//        store v4i16 v2
//
// In big endian mode every memory access has an implicit byte swap. LDR and
// STR do a 64-bit byte swap, whereas LD1/ST1 do a byte swap per lane - that
// is, they treat the vector as a sequence of elements to be byte-swapped.
// The two pairs of instructions are fundamentally incompatible. We've decided
// to use LD1/ST1 only to simplify compiler implementation.
//
// LD1/ST1 perform the equivalent of a sequence of LDR/STR + REV. This makes
// the original code sequence:
//   v0 = load v2i32
//   v1 = REV v2i32                  (implicit)
//   v2 = BITCAST v2i32 v1 to v4i16
//   v3 = REV v4i16 v2               (implicit)
//        store v4i16 v3
//
// But this is now broken - the value stored is different to the value loaded
// due to lane reordering. To fix this, on every BITCAST we must perform two
// other REVs:
//   v0 = load v2i32
//   v1 = REV v2i32                  (implicit)
//   v2 = REV v2i32
//   v3 = BITCAST v2i32 v2 to v4i16
//   v4 = REV v4i16
//   v5 = REV v4i16 v4               (implicit)
//        store v4i16 v5
//
// This means an extra two instructions, but actually in most cases the two REV
// instructions can be combined into one. For example:
//   (REV64_2s (REV64_4h X)) === (REV32_4h X)
//
// There is also no 128-bit REV instruction. This must be synthesized with an
// EXT instruction.
//
// Most bitconverts require some sort of conversion. The only exceptions are:
//   a) Identity conversions -  vNfX <-> vNiX
//   b) Single-lane-to-scalar - v1fX <-> fX or v1iX <-> iX
//

// Natural vector casts (64 bit)
def : Pat<(v8i8 (AArch64NvCast (v2i32 FPR64:$src))), (v8i8 FPR64:$src)>;
def : Pat<(v4i16 (AArch64NvCast (v2i32 FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4f16 (AArch64NvCast (v2i32 FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v2i32 (AArch64NvCast (v2i32 FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v2f32 (AArch64NvCast (v2i32 FPR64:$src))), (v2f32 FPR64:$src)>;
def : Pat<(v1i64 (AArch64NvCast (v2i32 FPR64:$src))), (v1i64 FPR64:$src)>;

def : Pat<(v8i8 (AArch64NvCast (v4i16 FPR64:$src))), (v8i8 FPR64:$src)>;
def : Pat<(v4i16 (AArch64NvCast (v4i16 FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4f16 (AArch64NvCast (v4i16 FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v2i32 (AArch64NvCast (v4i16 FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v1i64 (AArch64NvCast (v4i16 FPR64:$src))), (v1i64 FPR64:$src)>;

def : Pat<(v8i8 (AArch64NvCast (v8i8 FPR64:$src))), (v8i8 FPR64:$src)>;
def : Pat<(v4i16 (AArch64NvCast (v8i8 FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4f16 (AArch64NvCast (v8i8 FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v2i32 (AArch64NvCast (v8i8 FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v1i64 (AArch64NvCast (v8i8 FPR64:$src))), (v1i64 FPR64:$src)>;

def : Pat<(v8i8 (AArch64NvCast (f64 FPR64:$src))), (v8i8 FPR64:$src)>;
def : Pat<(v4i16 (AArch64NvCast (f64 FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4f16 (AArch64NvCast (f64 FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v2i32 (AArch64NvCast (f64 FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v2f32 (AArch64NvCast (f64 FPR64:$src))), (v2f32 FPR64:$src)>;
def : Pat<(v1i64 (AArch64NvCast (f64 FPR64:$src))), (v1i64 FPR64:$src)>;
def : Pat<(v1f64 (AArch64NvCast (f64 FPR64:$src))), (v1f64 FPR64:$src)>;

def : Pat<(v8i8 (AArch64NvCast (v2f32 FPR64:$src))), (v8i8 FPR64:$src)>;
def : Pat<(v4i16 (AArch64NvCast (v2f32 FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v2i32 (AArch64NvCast (v2f32 FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v2f32 (AArch64NvCast (v2f32 FPR64:$src))), (v2f32 FPR64:$src)>;
def : Pat<(v1i64 (AArch64NvCast (v2f32 FPR64:$src))), (v1i64 FPR64:$src)>;

// Natural vector casts (128 bit)
def : Pat<(v16i8 (AArch64NvCast (v4i32 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v8i16 (AArch64NvCast (v4i32 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8f16 (AArch64NvCast (v4i32 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v4i32 (AArch64NvCast (v4i32 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v4f32 (AArch64NvCast (v4i32 FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v2i64 (AArch64NvCast (v4i32 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v2f64 (AArch64NvCast (v4i32 FPR128:$src))), (v2f64 FPR128:$src)>;

def : Pat<(v16i8 (AArch64NvCast (v8i16 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v8i16 (AArch64NvCast (v8i16 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8f16 (AArch64NvCast (v8i16 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v4i32 (AArch64NvCast (v8i16 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v2i64 (AArch64NvCast (v8i16 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v4f32 (AArch64NvCast (v8i16 FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v2f64 (AArch64NvCast (v8i16 FPR128:$src))), (v2f64 FPR128:$src)>;

def : Pat<(v16i8 (AArch64NvCast (v16i8 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v8i16 (AArch64NvCast (v16i8 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8f16 (AArch64NvCast (v16i8 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v4i32 (AArch64NvCast (v16i8 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v2i64 (AArch64NvCast (v16i8 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v4f32 (AArch64NvCast (v16i8 FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v2f64 (AArch64NvCast (v16i8 FPR128:$src))), (v2f64 FPR128:$src)>;

def : Pat<(v16i8 (AArch64NvCast (v2i64 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v8i16 (AArch64NvCast (v2i64 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8f16 (AArch64NvCast (v2i64 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v4i32 (AArch64NvCast (v2i64 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v2i64 (AArch64NvCast (v2i64 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v4f32 (AArch64NvCast (v2i64 FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v2f64 (AArch64NvCast (v2i64 FPR128:$src))), (v2f64 FPR128:$src)>;

def : Pat<(v16i8 (AArch64NvCast (v4f32 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v8i16 (AArch64NvCast (v4f32 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v4i32 (AArch64NvCast (v4f32 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v4f32 (AArch64NvCast (v4f32 FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v2i64 (AArch64NvCast (v4f32 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v8f16 (AArch64NvCast (v4f32 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v2f64 (AArch64NvCast (v4f32 FPR128:$src))), (v2f64 FPR128:$src)>;

def : Pat<(v16i8 (AArch64NvCast (v2f64 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v8i16 (AArch64NvCast (v2f64 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v4i32 (AArch64NvCast (v2f64 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v2i64 (AArch64NvCast (v2f64 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v2f64 (AArch64NvCast (v2f64 FPR128:$src))), (v2f64 FPR128:$src)>;
def : Pat<(v8f16 (AArch64NvCast (v2f64 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v4f32 (AArch64NvCast (v2f64 FPR128:$src))), (v4f32 FPR128:$src)>;

let Predicates = [IsLE] in {
def : Pat<(v8i8  (bitconvert GPR64:$Xn)), (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;
def : Pat<(v4i16 (bitconvert GPR64:$Xn)), (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;
def : Pat<(v2i32 (bitconvert GPR64:$Xn)), (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;
def : Pat<(v4f16 (bitconvert GPR64:$Xn)), (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;
def : Pat<(v2f32 (bitconvert GPR64:$Xn)), (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;

def : Pat<(i64 (bitconvert (v8i8  V64:$Vn))),
          (COPY_TO_REGCLASS V64:$Vn, GPR64)>;
def : Pat<(i64 (bitconvert (v4i16 V64:$Vn))),
          (COPY_TO_REGCLASS V64:$Vn, GPR64)>;
def : Pat<(i64 (bitconvert (v2i32 V64:$Vn))),
          (COPY_TO_REGCLASS V64:$Vn, GPR64)>;
def : Pat<(i64 (bitconvert (v4f16 V64:$Vn))),
          (COPY_TO_REGCLASS V64:$Vn, GPR64)>;
def : Pat<(i64 (bitconvert (v2f32 V64:$Vn))),
          (COPY_TO_REGCLASS V64:$Vn, GPR64)>;
def : Pat<(i64 (bitconvert (v1f64 V64:$Vn))),
          (COPY_TO_REGCLASS V64:$Vn, GPR64)>;
}
let Predicates = [IsBE] in {
def : Pat<(v8i8  (bitconvert GPR64:$Xn)),
                 (REV64v8i8 (COPY_TO_REGCLASS GPR64:$Xn, FPR64))>;
def : Pat<(v4i16 (bitconvert GPR64:$Xn)),
                 (REV64v4i16 (COPY_TO_REGCLASS GPR64:$Xn, FPR64))>;
def : Pat<(v2i32 (bitconvert GPR64:$Xn)),
                 (REV64v2i32 (COPY_TO_REGCLASS GPR64:$Xn, FPR64))>;
def : Pat<(v4f16 (bitconvert GPR64:$Xn)),
                 (REV64v4i16 (COPY_TO_REGCLASS GPR64:$Xn, FPR64))>;
def : Pat<(v2f32 (bitconvert GPR64:$Xn)),
                 (REV64v2i32 (COPY_TO_REGCLASS GPR64:$Xn, FPR64))>;

def : Pat<(i64 (bitconvert (v8i8  V64:$Vn))),
          (REV64v8i8 (COPY_TO_REGCLASS V64:$Vn, GPR64))>;
def : Pat<(i64 (bitconvert (v4i16 V64:$Vn))),
          (REV64v4i16 (COPY_TO_REGCLASS V64:$Vn, GPR64))>;
def : Pat<(i64 (bitconvert (v2i32 V64:$Vn))),
          (REV64v2i32 (COPY_TO_REGCLASS V64:$Vn, GPR64))>;
def : Pat<(i64 (bitconvert (v4f16 V64:$Vn))),
          (REV64v4i16 (COPY_TO_REGCLASS V64:$Vn, GPR64))>;
def : Pat<(i64 (bitconvert (v2f32 V64:$Vn))),
          (REV64v2i32 (COPY_TO_REGCLASS V64:$Vn, GPR64))>;
}
def : Pat<(v1i64 (bitconvert GPR64:$Xn)), (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;
def : Pat<(v1f64 (bitconvert GPR64:$Xn)), (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;
def : Pat<(i64 (bitconvert (v1i64 V64:$Vn))),
          (COPY_TO_REGCLASS V64:$Vn, GPR64)>;
def : Pat<(v1i64 (scalar_to_vector GPR64:$Xn)),
          (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;
def : Pat<(v1f64 (scalar_to_vector GPR64:$Xn)),
          (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;
def : Pat<(v1f64 (scalar_to_vector (f64 FPR64:$Xn))), (v1f64 FPR64:$Xn)>;

def : Pat<(f32 (bitconvert (i32 GPR32:$Xn))),
          (COPY_TO_REGCLASS GPR32:$Xn, FPR32)>;
def : Pat<(i32 (bitconvert (f32 FPR32:$Xn))),
          (COPY_TO_REGCLASS FPR32:$Xn, GPR32)>;
def : Pat<(f64 (bitconvert (i64 GPR64:$Xn))),
          (COPY_TO_REGCLASS GPR64:$Xn, FPR64)>;
def : Pat<(i64 (bitconvert (f64 FPR64:$Xn))),
          (COPY_TO_REGCLASS FPR64:$Xn, GPR64)>;
def : Pat<(i64 (bitconvert (v1f64 V64:$Vn))),
          (COPY_TO_REGCLASS V64:$Vn, GPR64)>;

let Predicates = [IsLE] in {
def : Pat<(v1i64 (bitconvert (v2i32 FPR64:$src))), (v1i64 FPR64:$src)>;
def : Pat<(v1i64 (bitconvert (v4i16 FPR64:$src))), (v1i64 FPR64:$src)>;
def : Pat<(v1i64 (bitconvert (v8i8  FPR64:$src))), (v1i64 FPR64:$src)>;
def : Pat<(v1i64 (bitconvert (v4f16 FPR64:$src))), (v1i64 FPR64:$src)>;
def : Pat<(v1i64 (bitconvert (v2f32 FPR64:$src))), (v1i64 FPR64:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v1i64 (bitconvert (v2i32 FPR64:$src))),
                             (v1i64 (REV64v2i32 FPR64:$src))>;
def : Pat<(v1i64 (bitconvert (v4i16 FPR64:$src))),
                             (v1i64 (REV64v4i16 FPR64:$src))>;
def : Pat<(v1i64 (bitconvert (v8i8  FPR64:$src))),
                             (v1i64 (REV64v8i8 FPR64:$src))>;
def : Pat<(v1i64 (bitconvert (v4f16 FPR64:$src))),
                             (v1i64 (REV64v4i16 FPR64:$src))>;
def : Pat<(v1i64 (bitconvert (v2f32 FPR64:$src))),
                             (v1i64 (REV64v2i32 FPR64:$src))>;
}
def : Pat<(v1i64 (bitconvert (v1f64 FPR64:$src))), (v1i64 FPR64:$src)>;
def : Pat<(v1i64 (bitconvert (f64   FPR64:$src))), (v1i64 FPR64:$src)>;

let Predicates = [IsLE] in {
def : Pat<(v2i32 (bitconvert (v1i64 FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v2i32 (bitconvert (v4i16 FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v2i32 (bitconvert (v8i8  FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v2i32 (bitconvert (f64   FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v2i32 (bitconvert (v1f64 FPR64:$src))), (v2i32 FPR64:$src)>;
def : Pat<(v2i32 (bitconvert (v4f16 FPR64:$src))), (v2i32 FPR64:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v2i32 (bitconvert (v1i64 FPR64:$src))),
                             (v2i32 (REV64v2i32 FPR64:$src))>;
def : Pat<(v2i32 (bitconvert (v4i16 FPR64:$src))),
                             (v2i32 (REV32v4i16 FPR64:$src))>;
def : Pat<(v2i32 (bitconvert (v8i8  FPR64:$src))),
                             (v2i32 (REV32v8i8 FPR64:$src))>;
def : Pat<(v2i32 (bitconvert (f64   FPR64:$src))),
                             (v2i32 (REV64v2i32 FPR64:$src))>;
def : Pat<(v2i32 (bitconvert (v1f64 FPR64:$src))),
                             (v2i32 (REV64v2i32 FPR64:$src))>;
def : Pat<(v2i32 (bitconvert (v4f16 FPR64:$src))),
                             (v2i32 (REV64v4i16 FPR64:$src))>;
}
def : Pat<(v2i32 (bitconvert (v2f32 FPR64:$src))), (v2i32 FPR64:$src)>;

let Predicates = [IsLE] in {
def : Pat<(v4i16 (bitconvert (v1i64 FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4i16 (bitconvert (v2i32 FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4i16 (bitconvert (v8i8  FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4i16 (bitconvert (f64   FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4i16 (bitconvert (v4f16 FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4i16 (bitconvert (v2f32 FPR64:$src))), (v4i16 FPR64:$src)>;
def : Pat<(v4i16 (bitconvert (v1f64 FPR64:$src))), (v4i16 FPR64:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v4i16 (bitconvert (v1i64 FPR64:$src))),
                             (v4i16 (REV64v4i16 FPR64:$src))>;
def : Pat<(v4i16 (bitconvert (v2i32 FPR64:$src))),
                             (v4i16 (REV32v4i16 FPR64:$src))>;
def : Pat<(v4i16 (bitconvert (v8i8  FPR64:$src))),
                             (v4i16 (REV16v8i8 FPR64:$src))>;
def : Pat<(v4i16 (bitconvert (f64   FPR64:$src))),
                             (v4i16 (REV64v4i16 FPR64:$src))>;
def : Pat<(v4i16 (bitconvert (v4f16 FPR64:$src))),
                             (v4i16 (REV32v4i16 FPR64:$src))>;
def : Pat<(v4i16 (bitconvert (v2f32 FPR64:$src))),
                             (v4i16 (REV32v4i16 FPR64:$src))>;
def : Pat<(v4i16 (bitconvert (v1f64 FPR64:$src))),
                             (v4i16 (REV64v4i16 FPR64:$src))>;
}

let Predicates = [IsLE] in {
def : Pat<(v4f16 (bitconvert (v1i64 FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v4f16 (bitconvert (v2i32 FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v4f16 (bitconvert (v4i16 FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v4f16 (bitconvert (v8i8  FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v4f16 (bitconvert (f64   FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v4f16 (bitconvert (v2f32 FPR64:$src))), (v4f16 FPR64:$src)>;
def : Pat<(v4f16 (bitconvert (v1f64 FPR64:$src))), (v4f16 FPR64:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v4f16 (bitconvert (v1i64 FPR64:$src))),
                             (v4f16 (REV64v4i16 FPR64:$src))>;
def : Pat<(v4f16 (bitconvert (v2i32 FPR64:$src))),
                             (v4f16 (REV64v4i16 FPR64:$src))>;
def : Pat<(v4f16 (bitconvert (v4i16 FPR64:$src))),
                             (v4f16 (REV64v4i16 FPR64:$src))>;
def : Pat<(v4f16 (bitconvert (v8i8  FPR64:$src))),
                             (v4f16 (REV16v8i8 FPR64:$src))>;
def : Pat<(v4f16 (bitconvert (f64   FPR64:$src))),
                             (v4f16 (REV64v4i16 FPR64:$src))>;
def : Pat<(v4f16 (bitconvert (v2f32 FPR64:$src))),
                             (v4f16 (REV64v4i16 FPR64:$src))>;
def : Pat<(v4f16 (bitconvert (v1f64 FPR64:$src))),
                             (v4f16 (REV64v4i16 FPR64:$src))>;
}



let Predicates = [IsLE] in {
def : Pat<(v8i8  (bitconvert (v1i64 FPR64:$src))), (v8i8  FPR64:$src)>;
def : Pat<(v8i8  (bitconvert (v2i32 FPR64:$src))), (v8i8  FPR64:$src)>;
def : Pat<(v8i8  (bitconvert (v4i16 FPR64:$src))), (v8i8  FPR64:$src)>;
def : Pat<(v8i8  (bitconvert (f64   FPR64:$src))), (v8i8  FPR64:$src)>;
def : Pat<(v8i8  (bitconvert (v2f32 FPR64:$src))), (v8i8  FPR64:$src)>;
def : Pat<(v8i8  (bitconvert (v1f64 FPR64:$src))), (v8i8  FPR64:$src)>;
def : Pat<(v8i8  (bitconvert (v4f16 FPR64:$src))), (v8i8  FPR64:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v8i8  (bitconvert (v1i64 FPR64:$src))),
                             (v8i8 (REV64v8i8 FPR64:$src))>;
def : Pat<(v8i8  (bitconvert (v2i32 FPR64:$src))),
                             (v8i8 (REV32v8i8 FPR64:$src))>;
def : Pat<(v8i8  (bitconvert (v4i16 FPR64:$src))),
                             (v8i8 (REV16v8i8 FPR64:$src))>;
def : Pat<(v8i8  (bitconvert (f64   FPR64:$src))),
                             (v8i8 (REV64v8i8 FPR64:$src))>;
def : Pat<(v8i8  (bitconvert (v2f32 FPR64:$src))),
                             (v8i8 (REV32v8i8 FPR64:$src))>;
def : Pat<(v8i8  (bitconvert (v1f64 FPR64:$src))),
                             (v8i8 (REV64v8i8 FPR64:$src))>;
def : Pat<(v8i8  (bitconvert (v4f16 FPR64:$src))),
                             (v8i8 (REV16v8i8 FPR64:$src))>;
}

let Predicates = [IsLE] in {
def : Pat<(f64   (bitconvert (v2i32 FPR64:$src))), (f64   FPR64:$src)>;
def : Pat<(f64   (bitconvert (v4i16 FPR64:$src))), (f64   FPR64:$src)>;
def : Pat<(f64   (bitconvert (v2f32 FPR64:$src))), (f64   FPR64:$src)>;
def : Pat<(f64   (bitconvert (v8i8  FPR64:$src))), (f64   FPR64:$src)>;
def : Pat<(f64   (bitconvert (v4f16 FPR64:$src))), (f64   FPR64:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(f64   (bitconvert (v2i32 FPR64:$src))),
                             (f64 (REV64v2i32 FPR64:$src))>;
def : Pat<(f64   (bitconvert (v4i16 FPR64:$src))),
                             (f64 (REV64v4i16 FPR64:$src))>;
def : Pat<(f64   (bitconvert (v2f32 FPR64:$src))),
                             (f64 (REV64v2i32 FPR64:$src))>;
def : Pat<(f64   (bitconvert (v8i8  FPR64:$src))),
                             (f64 (REV64v8i8 FPR64:$src))>;
def : Pat<(f64   (bitconvert (v4f16 FPR64:$src))),
                             (f64 (REV64v4i16 FPR64:$src))>;
}
def : Pat<(f64   (bitconvert (v1i64 FPR64:$src))), (f64   FPR64:$src)>;
def : Pat<(f64   (bitconvert (v1f64 FPR64:$src))), (f64   FPR64:$src)>;

let Predicates = [IsLE] in {
def : Pat<(v1f64 (bitconvert (v2i32 FPR64:$src))), (v1f64 FPR64:$src)>;
def : Pat<(v1f64 (bitconvert (v4i16 FPR64:$src))), (v1f64 FPR64:$src)>;
def : Pat<(v1f64 (bitconvert (v8i8  FPR64:$src))), (v1f64 FPR64:$src)>;
def : Pat<(v1f64 (bitconvert (v2f32 FPR64:$src))), (v1f64 FPR64:$src)>;
def : Pat<(v1f64 (bitconvert (v4f16 FPR64:$src))), (v1f64 FPR64:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v1f64 (bitconvert (v2i32 FPR64:$src))),
                             (v1f64 (REV64v2i32 FPR64:$src))>;
def : Pat<(v1f64 (bitconvert (v4i16 FPR64:$src))),
                             (v1f64 (REV64v4i16 FPR64:$src))>;
def : Pat<(v1f64 (bitconvert (v8i8  FPR64:$src))),
                             (v1f64 (REV64v8i8 FPR64:$src))>;
def : Pat<(v1f64 (bitconvert (v2f32 FPR64:$src))),
                             (v1f64 (REV64v2i32 FPR64:$src))>;
def : Pat<(v1f64 (bitconvert (v4f16 FPR64:$src))),
                             (v1f64 (REV64v4i16 FPR64:$src))>;
}
def : Pat<(v1f64 (bitconvert (v1i64 FPR64:$src))), (v1f64 FPR64:$src)>;
def : Pat<(v1f64 (bitconvert (f64   FPR64:$src))), (v1f64 FPR64:$src)>;

let Predicates = [IsLE] in {
def : Pat<(v2f32 (bitconvert (v1i64 FPR64:$src))), (v2f32 FPR64:$src)>;
def : Pat<(v2f32 (bitconvert (v4i16 FPR64:$src))), (v2f32 FPR64:$src)>;
def : Pat<(v2f32 (bitconvert (v8i8  FPR64:$src))), (v2f32 FPR64:$src)>;
def : Pat<(v2f32 (bitconvert (v1f64 FPR64:$src))), (v2f32 FPR64:$src)>;
def : Pat<(v2f32 (bitconvert (f64   FPR64:$src))), (v2f32 FPR64:$src)>;
def : Pat<(v2f32 (bitconvert (v4f16 FPR64:$src))), (v2f32 FPR64:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v2f32 (bitconvert (v1i64 FPR64:$src))),
                             (v2f32 (REV64v2i32 FPR64:$src))>;
def : Pat<(v2f32 (bitconvert (v4i16 FPR64:$src))),
                             (v2f32 (REV32v4i16 FPR64:$src))>;
def : Pat<(v2f32 (bitconvert (v8i8  FPR64:$src))),
                             (v2f32 (REV32v8i8 FPR64:$src))>;
def : Pat<(v2f32 (bitconvert (v1f64 FPR64:$src))),
                             (v2f32 (REV64v2i32 FPR64:$src))>;
def : Pat<(v2f32 (bitconvert (f64   FPR64:$src))),
                             (v2f32 (REV64v2i32 FPR64:$src))>;
def : Pat<(v2f32 (bitconvert (v4f16 FPR64:$src))),
                             (v2f32 (REV64v4i16 FPR64:$src))>;
}
def : Pat<(v2f32 (bitconvert (v2i32 FPR64:$src))), (v2f32 FPR64:$src)>;

let Predicates = [IsLE] in {
def : Pat<(f128 (bitconvert (v2i64 FPR128:$src))), (f128 FPR128:$src)>;
def : Pat<(f128 (bitconvert (v4i32 FPR128:$src))), (f128 FPR128:$src)>;
def : Pat<(f128 (bitconvert (v8i16 FPR128:$src))), (f128 FPR128:$src)>;
def : Pat<(f128 (bitconvert (v2f64 FPR128:$src))), (f128 FPR128:$src)>;
def : Pat<(f128 (bitconvert (v4f32 FPR128:$src))), (f128 FPR128:$src)>;
def : Pat<(f128 (bitconvert (v8f16 FPR128:$src))), (f128 FPR128:$src)>;
def : Pat<(f128 (bitconvert (v16i8 FPR128:$src))), (f128 FPR128:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(f128 (bitconvert (v2i64 FPR128:$src))),
                            (f128 (EXTv16i8 FPR128:$src, FPR128:$src, (i32 8)))>;
def : Pat<(f128 (bitconvert (v4i32 FPR128:$src))),
                            (f128 (EXTv16i8 (REV64v4i32 FPR128:$src),
                                            (REV64v4i32 FPR128:$src), (i32 8)))>;
def : Pat<(f128 (bitconvert (v8i16 FPR128:$src))),
                            (f128 (EXTv16i8 (REV64v8i16 FPR128:$src),
                                            (REV64v8i16 FPR128:$src), (i32 8)))>;
def : Pat<(f128 (bitconvert (v8f16 FPR128:$src))),
                            (f128 (EXTv16i8 (REV64v8i16 FPR128:$src),
                                            (REV64v8i16 FPR128:$src), (i32 8)))>;
def : Pat<(f128 (bitconvert (v2f64 FPR128:$src))),
                            (f128 (EXTv16i8 FPR128:$src, FPR128:$src, (i32 8)))>;
def : Pat<(f128 (bitconvert (v4f32 FPR128:$src))),
                            (f128 (EXTv16i8 (REV64v4i32 FPR128:$src),
                                            (REV64v4i32 FPR128:$src), (i32 8)))>;
def : Pat<(f128 (bitconvert (v16i8 FPR128:$src))),
                            (f128 (EXTv16i8 (REV64v16i8 FPR128:$src),
                                            (REV64v16i8 FPR128:$src), (i32 8)))>;
}

let Predicates = [IsLE] in {
def : Pat<(v2f64 (bitconvert (f128  FPR128:$src))), (v2f64 FPR128:$src)>;
def : Pat<(v2f64 (bitconvert (v4i32 FPR128:$src))), (v2f64 FPR128:$src)>;
def : Pat<(v2f64 (bitconvert (v8i16 FPR128:$src))), (v2f64 FPR128:$src)>;
def : Pat<(v2f64 (bitconvert (v8f16 FPR128:$src))), (v2f64 FPR128:$src)>;
def : Pat<(v2f64 (bitconvert (v16i8 FPR128:$src))), (v2f64 FPR128:$src)>;
def : Pat<(v2f64 (bitconvert (v4f32 FPR128:$src))), (v2f64 FPR128:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v2f64 (bitconvert (f128  FPR128:$src))),
                             (v2f64 (EXTv16i8 FPR128:$src,
                                              FPR128:$src, (i32 8)))>;
def : Pat<(v2f64 (bitconvert (v4i32 FPR128:$src))),
                             (v2f64 (REV64v4i32 FPR128:$src))>;
def : Pat<(v2f64 (bitconvert (v8i16 FPR128:$src))),
                             (v2f64 (REV64v8i16 FPR128:$src))>;
def : Pat<(v2f64 (bitconvert (v8f16 FPR128:$src))),
                             (v2f64 (REV64v8i16 FPR128:$src))>;
def : Pat<(v2f64 (bitconvert (v16i8 FPR128:$src))),
                             (v2f64 (REV64v16i8 FPR128:$src))>;
def : Pat<(v2f64 (bitconvert (v4f32 FPR128:$src))),
                             (v2f64 (REV64v4i32 FPR128:$src))>;
}
def : Pat<(v2f64 (bitconvert (v2i64 FPR128:$src))), (v2f64 FPR128:$src)>;

let Predicates = [IsLE] in {
def : Pat<(v4f32 (bitconvert (f128  FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v4f32 (bitconvert (v8i16 FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v4f32 (bitconvert (v8f16 FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v4f32 (bitconvert (v16i8 FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v4f32 (bitconvert (v2i64 FPR128:$src))), (v4f32 FPR128:$src)>;
def : Pat<(v4f32 (bitconvert (v2f64 FPR128:$src))), (v4f32 FPR128:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v4f32 (bitconvert (f128  FPR128:$src))),
                             (v4f32 (EXTv16i8 (REV64v4i32 FPR128:$src),
                                    (REV64v4i32 FPR128:$src), (i32 8)))>;
def : Pat<(v4f32 (bitconvert (v8i16 FPR128:$src))),
                             (v4f32 (REV32v8i16 FPR128:$src))>;
def : Pat<(v4f32 (bitconvert (v8f16 FPR128:$src))),
                             (v4f32 (REV32v8i16 FPR128:$src))>;
def : Pat<(v4f32 (bitconvert (v16i8 FPR128:$src))),
                             (v4f32 (REV32v16i8 FPR128:$src))>;
def : Pat<(v4f32 (bitconvert (v2i64 FPR128:$src))),
                             (v4f32 (REV64v4i32 FPR128:$src))>;
def : Pat<(v4f32 (bitconvert (v2f64 FPR128:$src))),
                             (v4f32 (REV64v4i32 FPR128:$src))>;
}
def : Pat<(v4f32 (bitconvert (v4i32 FPR128:$src))), (v4f32 FPR128:$src)>;

let Predicates = [IsLE] in {
def : Pat<(v2i64 (bitconvert (f128  FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v2i64 (bitconvert (v4i32 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v2i64 (bitconvert (v8i16 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v2i64 (bitconvert (v16i8 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v2i64 (bitconvert (v4f32 FPR128:$src))), (v2i64 FPR128:$src)>;
def : Pat<(v2i64 (bitconvert (v8f16 FPR128:$src))), (v2i64 FPR128:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v2i64 (bitconvert (f128  FPR128:$src))),
                             (v2i64 (EXTv16i8 FPR128:$src,
                                              FPR128:$src, (i32 8)))>;
def : Pat<(v2i64 (bitconvert (v4i32 FPR128:$src))),
                             (v2i64 (REV64v4i32 FPR128:$src))>;
def : Pat<(v2i64 (bitconvert (v8i16 FPR128:$src))),
                             (v2i64 (REV64v8i16 FPR128:$src))>;
def : Pat<(v2i64 (bitconvert (v16i8 FPR128:$src))),
                             (v2i64 (REV64v16i8 FPR128:$src))>;
def : Pat<(v2i64 (bitconvert (v4f32 FPR128:$src))),
                             (v2i64 (REV64v4i32 FPR128:$src))>;
def : Pat<(v2i64 (bitconvert (v8f16 FPR128:$src))),
                             (v2i64 (REV64v8i16 FPR128:$src))>;
}
def : Pat<(v2i64 (bitconvert (v2f64 FPR128:$src))), (v2i64 FPR128:$src)>;

let Predicates = [IsLE] in {
def : Pat<(v4i32 (bitconvert (f128  FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v4i32 (bitconvert (v2i64 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v4i32 (bitconvert (v8i16 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v4i32 (bitconvert (v16i8 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v4i32 (bitconvert (v2f64 FPR128:$src))), (v4i32 FPR128:$src)>;
def : Pat<(v4i32 (bitconvert (v8f16 FPR128:$src))), (v4i32 FPR128:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v4i32 (bitconvert (f128  FPR128:$src))),
                             (v4i32 (EXTv16i8 (REV64v4i32 FPR128:$src),
                                              (REV64v4i32 FPR128:$src),
                                              (i32 8)))>;
def : Pat<(v4i32 (bitconvert (v2i64 FPR128:$src))),
                             (v4i32 (REV64v4i32 FPR128:$src))>;
def : Pat<(v4i32 (bitconvert (v8i16 FPR128:$src))),
                             (v4i32 (REV32v8i16 FPR128:$src))>;
def : Pat<(v4i32 (bitconvert (v16i8 FPR128:$src))),
                             (v4i32 (REV32v16i8 FPR128:$src))>;
def : Pat<(v4i32 (bitconvert (v2f64 FPR128:$src))),
                             (v4i32 (REV64v4i32 FPR128:$src))>;
def : Pat<(v4i32 (bitconvert (v8f16 FPR128:$src))),
                             (v4i32 (REV32v8i16 FPR128:$src))>;
}
def : Pat<(v4i32 (bitconvert (v4f32 FPR128:$src))), (v4i32 FPR128:$src)>;

let Predicates = [IsLE] in {
def : Pat<(v8i16 (bitconvert (f128  FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8i16 (bitconvert (v2i64 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8i16 (bitconvert (v4i32 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8i16 (bitconvert (v16i8 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8i16 (bitconvert (v2f64 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8i16 (bitconvert (v4f32 FPR128:$src))), (v8i16 FPR128:$src)>;
def : Pat<(v8i16 (bitconvert (v8f16 FPR128:$src))), (v8i16 FPR128:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v8i16 (bitconvert (f128  FPR128:$src))),
                             (v8i16 (EXTv16i8 (REV64v8i16 FPR128:$src),
                                              (REV64v8i16 FPR128:$src),
                                              (i32 8)))>;
def : Pat<(v8i16 (bitconvert (v2i64 FPR128:$src))),
                             (v8i16 (REV64v8i16 FPR128:$src))>;
def : Pat<(v8i16 (bitconvert (v4i32 FPR128:$src))),
                             (v8i16 (REV32v8i16 FPR128:$src))>;
def : Pat<(v8i16 (bitconvert (v16i8 FPR128:$src))),
                             (v8i16 (REV16v16i8 FPR128:$src))>;
def : Pat<(v8i16 (bitconvert (v2f64 FPR128:$src))),
                             (v8i16 (REV64v8i16 FPR128:$src))>;
def : Pat<(v8i16 (bitconvert (v4f32 FPR128:$src))),
                             (v8i16 (REV32v8i16 FPR128:$src))>;
def : Pat<(v8i16 (bitconvert (v8f16 FPR128:$src))),
                             (v8i16 (REV32v8i16 FPR128:$src))>;
}

let Predicates = [IsLE] in {
def : Pat<(v8f16 (bitconvert (f128  FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v8f16 (bitconvert (v2i64 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v8f16 (bitconvert (v4i32 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v8f16 (bitconvert (v8i16 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v8f16 (bitconvert (v16i8 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v8f16 (bitconvert (v2f64 FPR128:$src))), (v8f16 FPR128:$src)>;
def : Pat<(v8f16 (bitconvert (v4f32 FPR128:$src))), (v8f16 FPR128:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v8f16 (bitconvert (f128  FPR128:$src))),
                             (v8f16 (EXTv16i8 (REV64v8i16 FPR128:$src),
                                              (REV64v8i16 FPR128:$src),
                                              (i32 8)))>;
def : Pat<(v8f16 (bitconvert (v2i64 FPR128:$src))),
                             (v8f16 (REV64v8i16 FPR128:$src))>;
def : Pat<(v8f16 (bitconvert (v4i32 FPR128:$src))),
                             (v8f16 (REV32v8i16 FPR128:$src))>;
def : Pat<(v8f16 (bitconvert (v8i16 FPR128:$src))),
                             (v8f16 (REV64v8i16 FPR128:$src))>;
def : Pat<(v8f16 (bitconvert (v16i8 FPR128:$src))),
                             (v8f16 (REV16v16i8 FPR128:$src))>;
def : Pat<(v8f16 (bitconvert (v2f64 FPR128:$src))),
                             (v8f16 (REV64v8i16 FPR128:$src))>;
def : Pat<(v8f16 (bitconvert (v4f32 FPR128:$src))),
                             (v8f16 (REV32v8i16 FPR128:$src))>;
}

let Predicates = [IsLE] in {
def : Pat<(v16i8 (bitconvert (f128  FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v16i8 (bitconvert (v2i64 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v16i8 (bitconvert (v4i32 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v16i8 (bitconvert (v8i16 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v16i8 (bitconvert (v2f64 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v16i8 (bitconvert (v4f32 FPR128:$src))), (v16i8 FPR128:$src)>;
def : Pat<(v16i8 (bitconvert (v8f16 FPR128:$src))), (v16i8 FPR128:$src)>;
}
let Predicates = [IsBE] in {
def : Pat<(v16i8 (bitconvert (f128  FPR128:$src))),
                             (v16i8 (EXTv16i8 (REV64v16i8 FPR128:$src),
                                              (REV64v16i8 FPR128:$src),
                                              (i32 8)))>;
def : Pat<(v16i8 (bitconvert (v2i64 FPR128:$src))),
                             (v16i8 (REV64v16i8 FPR128:$src))>;
def : Pat<(v16i8 (bitconvert (v4i32 FPR128:$src))),
                             (v16i8 (REV32v16i8 FPR128:$src))>;
def : Pat<(v16i8 (bitconvert (v8i16 FPR128:$src))),
                             (v16i8 (REV16v16i8 FPR128:$src))>;
def : Pat<(v16i8 (bitconvert (v2f64 FPR128:$src))),
                             (v16i8 (REV64v16i8 FPR128:$src))>;
def : Pat<(v16i8 (bitconvert (v4f32 FPR128:$src))),
                             (v16i8 (REV32v16i8 FPR128:$src))>;
def : Pat<(v16i8 (bitconvert (v8f16 FPR128:$src))),
                             (v16i8 (REV16v16i8 FPR128:$src))>;
}

def : Pat<(v4i16 (extract_subvector V128:$Rn, (i64 0))),
           (EXTRACT_SUBREG V128:$Rn, dsub)>;
def : Pat<(v8i8 (extract_subvector V128:$Rn, (i64 0))),
           (EXTRACT_SUBREG V128:$Rn, dsub)>;
def : Pat<(v2f32 (extract_subvector V128:$Rn, (i64 0))),
           (EXTRACT_SUBREG V128:$Rn, dsub)>;
def : Pat<(v4f16 (extract_subvector V128:$Rn, (i64 0))),
           (EXTRACT_SUBREG V128:$Rn, dsub)>;
def : Pat<(v2i32 (extract_subvector V128:$Rn, (i64 0))),
           (EXTRACT_SUBREG V128:$Rn, dsub)>;
def : Pat<(v1i64 (extract_subvector V128:$Rn, (i64 0))),
           (EXTRACT_SUBREG V128:$Rn, dsub)>;
def : Pat<(v1f64 (extract_subvector V128:$Rn, (i64 0))),
           (EXTRACT_SUBREG V128:$Rn, dsub)>;

def : Pat<(v8i8 (extract_subvector (v16i8 FPR128:$Rn), (i64 1))),
          (EXTRACT_SUBREG (DUPv2i64lane FPR128:$Rn, 1), dsub)>;
def : Pat<(v4i16 (extract_subvector (v8i16 FPR128:$Rn), (i64 1))),
          (EXTRACT_SUBREG (DUPv2i64lane FPR128:$Rn, 1), dsub)>;
def : Pat<(v2i32 (extract_subvector (v4i32 FPR128:$Rn), (i64 1))),
          (EXTRACT_SUBREG (DUPv2i64lane FPR128:$Rn, 1), dsub)>;
def : Pat<(v1i64 (extract_subvector (v2i64 FPR128:$Rn), (i64 1))),
          (EXTRACT_SUBREG (DUPv2i64lane FPR128:$Rn, 1), dsub)>;

// A 64-bit subvector insert to the first 128-bit vector position
// is a subregister copy that needs no instruction.
def : Pat<(insert_subvector undef, (v1i64 FPR64:$src), (i32 0)),
          (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), FPR64:$src, dsub)>;
def : Pat<(insert_subvector undef, (v1f64 FPR64:$src), (i32 0)),
          (INSERT_SUBREG (v2f64 (IMPLICIT_DEF)), FPR64:$src, dsub)>;
def : Pat<(insert_subvector undef, (v2i32 FPR64:$src), (i32 0)),
          (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), FPR64:$src, dsub)>;
def : Pat<(insert_subvector undef, (v2f32 FPR64:$src), (i32 0)),
          (INSERT_SUBREG (v4f32 (IMPLICIT_DEF)), FPR64:$src, dsub)>;
def : Pat<(insert_subvector undef, (v4i16 FPR64:$src), (i32 0)),
          (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)), FPR64:$src, dsub)>;
def : Pat<(insert_subvector undef, (v4f16 FPR64:$src), (i32 0)),
          (INSERT_SUBREG (v8f16 (IMPLICIT_DEF)), FPR64:$src, dsub)>;
def : Pat<(insert_subvector undef, (v8i8 FPR64:$src), (i32 0)),
          (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)), FPR64:$src, dsub)>;

// Use pair-wise add instructions when summing up the lanes for v2f64, v2i64
// or v2f32.
def : Pat<(i64 (add (vector_extract (v2i64 FPR128:$Rn), (i64 0)),
                    (vector_extract (v2i64 FPR128:$Rn), (i64 1)))),
           (i64 (ADDPv2i64p (v2i64 FPR128:$Rn)))>;
def : Pat<(f64 (fadd (vector_extract (v2f64 FPR128:$Rn), (i64 0)),
                     (vector_extract (v2f64 FPR128:$Rn), (i64 1)))),
           (f64 (FADDPv2i64p (v2f64 FPR128:$Rn)))>;
    // vector_extract on 64-bit vectors gets promoted to a 128 bit vector,
    // so we match on v4f32 here, not v2f32. This will also catch adding
    // the low two lanes of a true v4f32 vector.
def : Pat<(fadd (vector_extract (v4f32 FPR128:$Rn), (i64 0)),
                (vector_extract (v4f32 FPR128:$Rn), (i64 1))),
          (f32 (FADDPv2i32p (EXTRACT_SUBREG FPR128:$Rn, dsub)))>;

// Scalar 64-bit shifts in FPR64 registers.
def : Pat<(i64 (int_aarch64_neon_sshl (i64 FPR64:$Rn), (i64 FPR64:$Rm))),
          (SSHLv1i64 FPR64:$Rn, FPR64:$Rm)>;
def : Pat<(i64 (int_aarch64_neon_ushl (i64 FPR64:$Rn), (i64 FPR64:$Rm))),
          (USHLv1i64 FPR64:$Rn, FPR64:$Rm)>;
def : Pat<(i64 (int_aarch64_neon_srshl (i64 FPR64:$Rn), (i64 FPR64:$Rm))),
          (SRSHLv1i64 FPR64:$Rn, FPR64:$Rm)>;
def : Pat<(i64 (int_aarch64_neon_urshl (i64 FPR64:$Rn), (i64 FPR64:$Rm))),
          (URSHLv1i64 FPR64:$Rn, FPR64:$Rm)>;

// Patterns for nontemporal/no-allocate stores.
// We have to resort to tricks to turn a single-input store into a store pair,
// because there is no single-input nontemporal store, only STNP.
let Predicates = [IsLE] in {
let AddedComplexity = 15 in {
class NTStore128Pat<ValueType VT> :
  Pat<(nontemporalstore (VT FPR128:$Rt),
        (am_indexed7s64 GPR64sp:$Rn, simm7s8:$offset)),
      (STNPDi (EXTRACT_SUBREG FPR128:$Rt, dsub),
              (CPYi64 FPR128:$Rt, (i64 1)),
              GPR64sp:$Rn, simm7s8:$offset)>;

def : NTStore128Pat<v2i64>;
def : NTStore128Pat<v4i32>;
def : NTStore128Pat<v8i16>;
def : NTStore128Pat<v16i8>;

class NTStore64Pat<ValueType VT> :
  Pat<(nontemporalstore (VT FPR64:$Rt),
        (am_indexed7s32 GPR64sp:$Rn, simm7s4:$offset)),
      (STNPSi (EXTRACT_SUBREG FPR64:$Rt, ssub),
              (CPYi32 (SUBREG_TO_REG (i64 0), FPR64:$Rt, dsub), (i64 1)),
              GPR64sp:$Rn, simm7s4:$offset)>;

// FIXME: Shouldn't v1f64 loads/stores be promoted to v1i64?
def : NTStore64Pat<v1f64>;
def : NTStore64Pat<v1i64>;
def : NTStore64Pat<v2i32>;
def : NTStore64Pat<v4i16>;
def : NTStore64Pat<v8i8>;

def : Pat<(nontemporalstore GPR64:$Rt,
            (am_indexed7s32 GPR64sp:$Rn, simm7s4:$offset)),
          (STNPWi (EXTRACT_SUBREG GPR64:$Rt, sub_32),
                  (EXTRACT_SUBREG (UBFMXri GPR64:$Rt, 32, 63), sub_32),
                  GPR64sp:$Rn, simm7s4:$offset)>;
} // AddedComplexity=10
} // Predicates = [IsLE]

// Tail call return handling. These are all compiler pseudo-instructions,
// so no encoding information or anything like that.
let isCall = 1, isTerminator = 1, isReturn = 1, isBarrier = 1, Uses = [SP] in {
  def TCRETURNdi : Pseudo<(outs), (ins i64imm:$dst, i32imm:$FPDiff), []>,
                   Sched<[WriteBrReg]>;
  def TCRETURNri : Pseudo<(outs), (ins tcGPR64:$dst, i32imm:$FPDiff), []>,
                   Sched<[WriteBrReg]>;
}

def : Pat<(AArch64tcret tcGPR64:$dst, (i32 timm:$FPDiff)),
          (TCRETURNri tcGPR64:$dst, imm:$FPDiff)>;
def : Pat<(AArch64tcret tglobaladdr:$dst, (i32 timm:$FPDiff)),
          (TCRETURNdi texternalsym:$dst, imm:$FPDiff)>;
def : Pat<(AArch64tcret texternalsym:$dst, (i32 timm:$FPDiff)),
          (TCRETURNdi texternalsym:$dst, imm:$FPDiff)>;

include "AArch64InstrAtomics.td"
