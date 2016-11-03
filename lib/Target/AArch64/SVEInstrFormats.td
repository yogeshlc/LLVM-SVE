def MulImm4Operand : AsmOperandClass {
  let Name = "MulImm4";
  let DiagnosticType = "InvalidImm1_16";
  let ParserMethod = "tryParseMulImm4";
  let PredicateMethod = "isImmRange<1,16>";
  let RenderMethod = "addImmOperands";
}

def sve_incdec_imm : Operand<i32>, ImmLeaf<i32, [{
    return (((uint32_t)Imm) > 0) && (((uint32_t)Imm) < 17);
  }]> {

  let EncoderMethod = "getSVEIncDecImm";
  let DecoderMethod = "DecodeSVEIncDecImm";
  let PrintMethod = "printMulImm4";
  let ParserMatchClass = MulImm4Operand;
}

def SVENamedFPImmOperandHalfOne : AsmOperandClass {
  let Name = "SVENamedFPImmOperandHalfOne";
  let ParserMethod = "tryParseNamedFPImm<AArch64SVEFpImmHalfOne::Mapper>";
  let PredicateMethod = "isImm";
  let RenderMethod = "addImmOperands";
}

def sve_fpimm_half_one : Operand<i32> {
  let PrintMethod = "printNamedFPImm<AArch64SVEFpImmHalfOne::Mapper>";
  let ParserMatchClass = SVENamedFPImmOperandHalfOne;
}

def SVENamedFPImmOperandHalfTwo : AsmOperandClass {
  let Name = "SVENamedFPImmOperandHalfTwo";
  let ParserMethod = "tryParseNamedFPImm<AArch64SVEFpImmHalfTwo::Mapper>";
  let PredicateMethod = "isImm";
  let RenderMethod = "addImmOperands";
}

def sve_fpimm_half_two : Operand<i32> {
  let PrintMethod = "printNamedFPImm<AArch64SVEFpImmHalfTwo::Mapper>";
  let ParserMatchClass = SVENamedFPImmOperandHalfTwo;
}

def SVENamedFPImmOperandZeroOne : AsmOperandClass {
  let Name = "SVENamedFPImmOperandZeroOne";
  let ParserMethod = "tryParseNamedFPImm<AArch64SVEFpImmZeroOne::Mapper>";
  let PredicateMethod = "isImm";
  let RenderMethod = "addImmOperands";
}

def sve_fpimm_zero_one : Operand<i32> {
  let PrintMethod = "printNamedFPImm<AArch64SVEFpImmZeroOne::Mapper>";
  let ParserMatchClass = SVENamedFPImmOperandZeroOne;
}

def SVEPatternOperand : AsmOperandClass {
  let Name = "SVEPattern";
  let ParserMethod = "tryParseSVEPattern";
  let PredicateMethod = "isSVEPattern";
  let RenderMethod = "addImmOperands";
}

def sve_pred_enum : Operand<i32>, ImmLeaf<i32, [{
  return (((uint32_t)Imm) < 32);
  }]> {

  let PrintMethod = "printNamedOpOrImm<AArch64SVEPredPattern::Mapper>";
  let ParserMatchClass = SVEPatternOperand;
}

def SVEShift3Operand : AsmOperandClass {
  let SuperClasses = [ShifterOperand];
  let Name = "SVEShift";
  let RenderMethod = "addSVEShiftOperands";
  let DiagnosticType = "InvalidSVEShiftExtend";
  let PredicateMethod = "isSVEShift<3>";
}

class SVEExtend3Operand<int Signed> : AsmOperandClass {
  let SuperClasses = [ShifterOperand];
  let Name = "SVEExtend" # Signed;
  let RenderMethod = "addSVEExtendOperands";
  let DiagnosticType = "InvalidSVEShiftExtend";
  let PredicateMethod = "isSVEExtend<3," # Signed # ">";
}

def SVESxtw3Operand : SVEExtend3Operand<1>;
def SVEUxtw3Operand : SVEExtend3Operand<0>;

def sve_adr_shift : Operand<i32> {
  let PrintMethod = "printOffsetLslImm3";
  let ParserMatchClass = SVEShift3Operand;
}

def sve_adr_sxtw : Operand<i32> {
  let PrintMethod = "printSVEExtImm3";
  let ParserMatchClass = SVESxtw3Operand;
  let DecoderMethod = "DecodeSxtwImm3";
}

def sve_adr_uxtw : Operand<i32> {
  let PrintMethod = "printSVEExtImm3";
  let ParserMatchClass = SVEUxtw3Operand;
}

def SVECpyImmOperand : AsmOperandClass {
  let Name = "SVECpyImm";
  let DiagnosticType = "DupCpyImm8Operand";
  let RenderMethod = "addAddSubImmOperands<8>";
  let ParserMethod = "tryParseAddSubImm";
  let PredicateMethod = "isSVECpyImm";
}

def SVECpyImmByteOperand : AsmOperandClass {
  let Name = "SVECpyImmByte";
  let DiagnosticType = "DupCpyByteImm8Operand";
  let RenderMethod = "addAddSubImmOperands<8>";
  let ParserMethod = "tryParseAddSubImm";
  let PredicateMethod = "isSVECpyImmByte";
}

class simm8_opt_lsl<int Width, ValueType Ty, Operand Op>
: Operand<Ty>, ImmLeaf<Ty, [{
    return AArch64_AM::isSVECpyImm(Imm);
  }]> {

  let DecoderMethod = "DecodeSImm8OptLsl";
  let EncoderMethod = "getSImm8OptLsl";
  let PrintMethod = "printImm8OptLsl<int" # Width # "_t>";
  let ParserMatchClass = SVECpyImmOperand;
  let MIOperandInfo = (ops Op, Op);
}
def simm8_opt_lsl_i16 : simm8_opt_lsl<16, i32, i32imm>;
def simm8_opt_lsl_i32 : simm8_opt_lsl<32, i32, i32imm>;
def simm8_opt_lsl_i64 : simm8_opt_lsl<64, i64, i64imm>;

// A special case for bytes as they support a slightly different immedite range.
def simm8_opt_lsl_i8 : Operand<i32>, ImmLeaf<i32, [{
    return AArch64_AM::isSVECpyImmByte(Imm);
  }]> {

  let DecoderMethod = "DecodeSImm8OptLslByte";
  let EncoderMethod = "getSImm8OptLsl";
  let PrintMethod = "printImm8OptLsl<int8_t>";
  let ParserMatchClass = SVECpyImmByteOperand;
  let MIOperandInfo = (ops i32imm, i32imm);
}

def AddSubImm8Operand : AddSubImmOperand<8> {
  let DiagnosticType = "AddSubImm8Operand";
}

class uimm8_opt_lsl<int Width>
: Operand<i32>, ImmLeaf<i32, [{
    return ((uint8_t)Imm == Imm) || ((uint16_t)(Imm & ~0xff) == Imm);
  }]> {

  let DecoderMethod = "DecodeUImm8OptLsl";
  let EncoderMethod = "getAddSubImmOpValue";
  let PrintMethod = "printImm8OptLsl<uint" # Width # "_t>";
  let ParserMatchClass = AddSubImm8Operand;
  let MIOperandInfo = (ops i32imm, i32imm);
}
def uimm8_opt_lsl_i16 : uimm8_opt_lsl<16>;
def uimm8_opt_lsl_i32 : uimm8_opt_lsl<32>;
def uimm8_opt_lsl_i64 : uimm8_opt_lsl<64>;

def uimm8_opt_lsl_i8 : Operand<i32>, ImmLeaf<i32, [{
    return ((uint8_t)Imm == Imm) || ((uint16_t)(Imm & ~0xff) == Imm);
  }]> {

  let DecoderMethod = "DecodeUImm8OptLslByte";
  let EncoderMethod = "getAddSubImmOpValue";
  let PrintMethod = "printImm8OptLsl<uint8_t>";
  let ParserMatchClass = AddSubImm8Operand;
  let MIOperandInfo = (ops i32imm, i32imm);
}

// TODO: As part of a later clean-up we can probably unify these with some
// pre-existing signed immediate classes in AArch64InstrFormats.td. I have left
// these alone for now until we have a clearer idea of what needs doing.
class SImmMulVlOperand<int Bits, int Scale> : AsmOperandClass {
  let Name = "SImm" # Bits # "Scale" # Scale # "MulVl";
  let DiagnosticType = "InvalidMemoryIndexed" # Scale # "SImm" # Bits;
  let PredicateMethod = "isSImmScaled<" # Bits # ", " # Scale # ">";
  let RenderMethod = "addImmScaledOperands<" # Scale # ">";
}

def SImm4MulVlOperand : SImmMulVlOperand<4,1>;
def SImm6MulVlOperand : SImmMulVlOperand<6,1>;
def SImm9MulVlOperand : SImmMulVlOperand<9,1>;
def SImm4Scale2MulVlOperand : SImmMulVlOperand<4,2>;
def SImm4Scale3MulVlOperand : SImmMulVlOperand<4,3>;
def SImm4Scale4MulVlOperand : SImmMulVlOperand<4,4>;

def simm4MulVl : Operand<i64>, ImmLeaf<i64, [{ return Imm >= -8 && Imm < 8; }]> {
  let DecoderMethod = "DecodeSImm<4>";
  let ParserMatchClass = SImm4MulVlOperand;
}

def simm6MulVl : Operand<i64>, ImmLeaf<i64, [{ return Imm >= -32 && Imm < 32; }]> {
  let DecoderMethod = "DecodeSImm<6>";
  let ParserMatchClass = SImm6MulVlOperand;
}

def simm9MulVl : Operand<i64>, ImmLeaf<i64, [{ return Imm >= -256 && Imm < 256; }]> {
  let DecoderMethod = "DecodeSImm<9>";
  let ParserMatchClass = SImm9MulVlOperand;
}

def simm4Scale2MulVl : Operand<i64>, ImmLeaf<i64, [{
    return (Imm >= -16 && Imm <= 14) && ((Imm % 2) == 0x0);
  }]> {
  let DecoderMethod = "DecodeSImm<4>";
  let PrintMethod = "printImmScale<2>";
  let ParserMatchClass = SImm4Scale2MulVlOperand;
}

def simm4Scale3MulVl : Operand<i64>, ImmLeaf<i64, [{
    return (Imm >= -24 && Imm <= 21) && ((Imm % 3) == 0x0);
  }]> {
  let DecoderMethod = "DecodeSImm<4>";
  let PrintMethod = "printImmScale<3>";
  let ParserMatchClass = SImm4Scale3MulVlOperand;
}

def simm4Scale4MulVl : Operand<i64>, ImmLeaf<i64, [{
    return (Imm >= -32 && Imm <= 28) && ((Imm % 4) == 0x0);
  }]> {
  let DecoderMethod = "DecodeSImm<4>";
  let PrintMethod = "printImmScale<4>";
  let ParserMatchClass = SImm4Scale4MulVlOperand;
}

//===----------------------------------------------------------------------===//

// SVE Vector lane operands
class SVEVectorIndex<string Suffix> : AsmOperandClass {
  let Name = "SVEVectorIndex" # Suffix;
  let DiagnosticType = "InvalidSVEVectorIndex" # Suffix;
  let RenderMethod = "addVectorIndex";
}

def SVEVectorIndexBOperand : SVEVectorIndex<"B">;
def SVEVectorIndexHOperand : SVEVectorIndex<"H">;
def SVEVectorIndexSOperand : SVEVectorIndex<"S">;
def SVEVectorIndexDOperand : SVEVectorIndex<"D">;

def sve_elm_idx_b : Operand<i64>, ImmLeaf<i64, [{
    return ((uint64_t)Imm) < 64;
  }]> {
  let ParserMatchClass = SVEVectorIndexBOperand;
  let PrintMethod = "printVectorIndex";
}

def sve_elm_idx_h : Operand<i64>, ImmLeaf<i64, [{
    return ((uint64_t)Imm) < 32;
  }]> {
  let ParserMatchClass = SVEVectorIndexHOperand;
  let PrintMethod = "printVectorIndex";
}

def sve_elm_idx_s : Operand<i64>, ImmLeaf<i64, [{
    return ((uint64_t)Imm) < 16;
  }]> {
  let ParserMatchClass = SVEVectorIndexSOperand;
  let PrintMethod = "printVectorIndex";
}

def sve_elm_idx_d : Operand<i64>, ImmLeaf<i64, [{
    return ((uint64_t)Imm) < 8;
  }]> {
  let ParserMatchClass = SVEVectorIndexDOperand;
  let PrintMethod = "printVectorIndex";
}

//===----------------------------------------------------------------------===//

def SVEPrefetchOperand : AsmOperandClass {
  let Name = "SVEPrefetch";
  let ParserMethod = "tryParsePrefetch<AArch64SVEPrefetchOp::Mapper, 15>";
}

def sve_prfop : Operand<i32> {
  let PrintMethod = "printNamedOpOrImm<AArch64SVEPrefetchOp::Mapper>";
  let ParserMatchClass = SVEPrefetchOperand;
}
//===----------------------------------------------------------------------===//

class SVELogicalImmOperand<int Width> : AsmOperandClass {
  let Name = "SVELogicalImm" # Width;
  let DiagnosticType = "LogicalSecondSource";
  let PredicateMethod = "isLogicalImm<int" # Width # "_t>";
  let RenderMethod = "addLogicalImmOperands<int" # Width # "_t>";
}

def sve_logical_imm8 : Operand<i64> {
  let ParserMatchClass = SVELogicalImmOperand<8>;
  let PrintMethod = "printLogicalImm<int8_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int8_t>(Val);
  }];
}

def sve_logical_imm16 : Operand<i64> {
  let ParserMatchClass = SVELogicalImmOperand<16>;
  let PrintMethod = "printLogicalImm<int16_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int16_t>(Val);
  }];
}

def sve_logical_imm32 : Operand<i64> {
  let ParserMatchClass = SVELogicalImmOperand<32>;
  let PrintMethod = "printLogicalImm<int32_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int32_t>(Val);
  }];
}

//===----------------------------------------------------------------------===//

class SVELogicalImmNotOperand<int Width> : AsmOperandClass {
  let Name = "SVELogicalImm" # Width # "Not";
  let DiagnosticType = "LogicalSecondSource";
  let PredicateMethod = "isLogicalImm<int" # Width # "_t>";
  let RenderMethod = "addLogicalImmNotOperands<int" # Width # "_t>";
}

def sve_logical_imm8_not : Operand<i64> {
  let ParserMatchClass = SVELogicalImmNotOperand<8>;
}

def sve_logical_imm16_not : Operand<i64> {
  let ParserMatchClass = SVELogicalImmNotOperand<16>;
}

def sve_logical_imm32_not : Operand<i64> {
  let ParserMatchClass = SVELogicalImmNotOperand<32>;
}

//===----------------------------------------------------------------------===//

class SVEPreferredLogicalImmOperand<int Width> : AsmOperandClass {
  let Name = "SVEPreferredLogicalImm" # Width;
  let PredicateMethod = "isSVEPreferredLogicalImm<int" # Width # "_t>";
  let RenderMethod = "addLogicalImmOperands<int" # Width # "_t>";
}

def sve_preferred_logical_imm16 : Operand<i64> {
  let ParserMatchClass = SVEPreferredLogicalImmOperand<16>;
  let PrintMethod = "printSVELogicalImm<int16_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int16_t>(Val) &&
           AArch64_AM::isSVEMoveMaskPreferredLogicalImmediate(Val);
  }];
}

def sve_preferred_logical_imm32 : Operand<i64> {
  let ParserMatchClass =  SVEPreferredLogicalImmOperand<32>;
  let PrintMethod = "printSVELogicalImm<int32_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int32_t>(Val) &&
           AArch64_AM::isSVEMoveMaskPreferredLogicalImmediate(Val);
  }];
}

def sve_preferred_logical_imm64 : Operand<i64> {
  let ParserMatchClass = SVEPreferredLogicalImmOperand<64>;
  let PrintMethod = "printSVELogicalImm<int64_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int64_t>(Val) &&
           AArch64_AM::isSVEMoveMaskPreferredLogicalImmediate(Val);
  }];
}

//===----------------------------------------------------------------------===//

// 8-bit floating-point immediate encodings.
def SVEFPImm8Operand : AsmOperandClass {
  let Name = "SVEFPImm8";
  let DiagnosticType = "InvalidFPImm";
  let ParserMethod = "tryParseFPImm";
  let RenderMethod = "addFPImmOperands";
}

def sve_fpimm32 : Operand<f32>,
                  PatLeaf<(f32 fpimm), [{
      return AArch64_AM::getFP32Imm(N->getValueAPF()) != -1;
    }], SDNodeXForm<fpimm, [{
      APFloat InVal = N->getValueAPF();
      uint32_t enc = AArch64_AM::getFP32Imm(InVal);
      return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i32);
    }]>> {
  let ParserMatchClass = SVEFPImm8Operand;
  let PrintMethod = "printFPImmOperand";
}

def sve_fpimm64 : Operand<f64>,
              PatLeaf<(f64 fpimm), [{
      return AArch64_AM::getFP64Imm(N->getValueAPF()) != -1;
    }], SDNodeXForm<fpimm, [{
      APFloat InVal = N->getValueAPF();
      uint32_t enc = AArch64_AM::getFP64Imm(InVal);
      return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i32);
    }]>> {
  let ParserMatchClass = SVEFPImm8Operand;
  let PrintMethod = "printFPImmOperand";
}


def sve_fpimm8 : Operand<i32> {
  let ParserMatchClass = SVEFPImm8Operand;
  let PrintMethod = "printFPImmOperand";
}

// #0.0
def SVEFPImmZeroOperand : AsmOperandClass {
  let Name = "SVEFPImmZero";
  let DiagnosticType = "InvalidFPImm";
  let ParserMethod = "tryParseFPImm";
}

class _sve_fpzero<ValueType Ty> : Operand<Ty> {
  let ParserMatchClass = SVEFPImmZeroOperand;
  let PrintMethod = "printFPImmOperand";
}

def sve_fpzero : _sve_fpzero<i32>;
def sve_fpzero_f64 : _sve_fpzero<i64>;

//===----------------------------------------------------------------------===//
// SVE PTrue - These are used extensively throughout the pattern matching so
//             it's important we define them first.
//===----------------------------------------------------------------------===//

class sve_int_ptrue<bits<2> sz8_64, bits<3> opc, string asm, string suffix,
                    ValueType vt, SDPatternOperator op>
: I<(outs PPROp:$Pd), (ins sve_pred_enum:$pattern),
  asm, "\t$Pd"#suffix#", $pattern",
  "",
  [(set (vt PPROp:$Pd), (op sve_pred_enum:$pattern))]>, Sched<[]> {
  bits<4> Pd;
  bits<5> pattern;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b011;
  let Inst{18-17} = opc{2-1};
  let Inst{16}    = opc{0};
  let Inst{15-10} = 0b111000;
  let Inst{9-5}   = pattern;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pd;

  let Defs = !if(!eq (opc{0}, 1), [NZCV], []);
  let isReMaterializable = 1;
}

multiclass sve_int_ptrue<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_ptrue<0b00, opc, asm, ".b", nxv16i1, op>;
  def _H : sve_int_ptrue<0b01, opc, asm, ".h", nxv8i1, op>;
  def _S : sve_int_ptrue<0b10, opc, asm, ".s", nxv4i1, op>;
  def _D : sve_int_ptrue<0b11, opc, asm, ".d", nxv2i1, op>;

  def : InstAlias<asm # "\t$Pd.b",
                  (!cast<Instruction>(NAME # _B) PPROp:$Pd, 0b11111), 1>;
  def : InstAlias<asm # "\t$Pd.h",
                  (!cast<Instruction>(NAME # _H) PPROp:$Pd, 0b11111), 1>;
  def : InstAlias<asm # "\t$Pd.s",
                  (!cast<Instruction>(NAME # _S) PPROp:$Pd, 0b11111), 1>;
  def : InstAlias<asm # "\t$Pd.d",
                  (!cast<Instruction>(NAME # _D) PPROp:$Pd, 0b11111), 1>;
}

def SDT_AArch64PTrue : SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisVT<1, i32>]>;
def AArch64ptrue : SDNode<"AArch64ISD::PTRUE", SDT_AArch64PTrue>;

let Predicates = [HasSVE] in {
  defm PTRUE  : sve_int_ptrue<0b000, "ptrue", AArch64ptrue>;
  defm PTRUES : sve_int_ptrue<0b001, "ptrues", null_frag>;
}

//===----------------------------------------------------------------------===//
// SVE pattern match helpers.
//===----------------------------------------------------------------------===//

class SVE_1_Op_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   Instruction inst>
: Pat<(vtd (op vt1:$Op1)),
      (inst $Op1)>;

class SVE_2_Op_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   ValueType vt2, Instruction inst>
: Pat<(vtd (op vt1:$Op1, vt2:$Op2)),
      (inst $Op1, $Op2)>;

class SVE_3_Op_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   ValueType vt2, ValueType vt3, Instruction inst>
: Pat<(vtd (op vt1:$Op1, vt2:$Op2, vt3:$Op3)),
      (inst $Op1, $Op2, $Op3)>;

class SVE_4_Op_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   ValueType vt2, ValueType vt3, ValueType vt4,
                   Instruction inst>
: Pat<(vtd (op vt1:$Op1, vt2:$Op2, vt3:$Op3, vt4:$Op4)),
      (inst $Op1, $Op2, $Op3, $Op4)>;

//
// Common but less generic patterns.
//

class SVE_1_Op_AllActive_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                             Instruction inst, Instruction ptrue>
: Pat<(vtd (op vt1:$Op1)),
      (inst (IMPLICIT_DEF), (ptrue 31), $Op1)>;

class SVE_2_Op_AllActive_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                             ValueType vt2, Instruction inst, Instruction ptrue>
: Pat<(vtd (op vt1:$Op1, vt2:$Op2)),
      (inst (ptrue 31), $Op1, $Op2)>;

//
// Instruction specific patterns.
//

class SVE_Cmp_Pat0<ValueType pt, ValueType vt, CondCode cc, Instruction inst,
                   Instruction ptrue>
: Pat<(pt (setcc vt:$Zn, vt:$Zm, cc)),
      (inst (ptrue 31), $Zn, $Zm)>;

class SVE_Cmp_Pat1<ValueType pt, ValueType vt, CondCode cc, Instruction inst>
: Pat<(pt (and pt:$Pg, (setcc vt:$Zn, vt:$Zm, cc))),
      (inst $Pg, $Zn, $Zm)>;

//
// Pseudos for destructive operands
//
let hasNoSchedulingInfo = 1 in {
  class PredTwoOpPseudo
  : Pseudo<(outs ZPROp:$Zd), (ins PPRROp:$Pg, ZPROp:$Zs1, ZPROp:$Zs2), []>;

  class PredThreeOpPseudo
  : Pseudo<(outs ZPROp:$Zd), (ins PPRROp:$Pg, ZPROp:$Zs1, ZPROp:$Zs2, ZPROp:$Zs3), []>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Compare - with Zero Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_p_pd<bit sz, bits<3> opc, string asm, string suffix>
: I<(outs PPROp:$Pd), (ins PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Pd"#suffix#", $Pg/z, $Zn"#suffix#", #0.0",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zn;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21-18} = 0b0100;
  let Inst{17-16} = opc{2-1};
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;
}

multiclass sve_fp_2op_p_pd<bits<3> opc, string asm,
                           SDPatternOperator int_op = null_frag,
                           SDPatternOperator ir_op = null_frag,
                           SDPatternOperator inv_int_op = null_frag,
                           SDPatternOperator inv_ir_op = null_frag> {
  def _S : sve_fp_2op_p_pd<0b0, opc, asm, ".s">;
  def _D : sve_fp_2op_p_pd<0b1, opc, asm, ".d">;

  // Intrinsics
  def : Pat<(nxv4i1 (int_op (nxv4i1 PPRR:$Pg),
                            (nxv4f32 ZPR:$Zs1),
                            (nxv4f32 (AArch64dup (f32 fpimm0))))),
            (!cast<Instruction>(NAME # "_S") PPRR:$Pg, ZPR:$Zs1)>;
  def : Pat<(nxv2i1 (int_op (nxv2i1 PPRR:$Pg),
                            (nxv2f64 ZPR:$Zs1),
                            (nxv2f64 (AArch64dup (f64 fpimm0))))),
            (!cast<Instruction>(NAME # "_D") PPRR:$Pg, ZPR:$Zs1)>;

  // IR
  def : Pat<(nxv4i1 (ir_op (nxv4f32 ZPR:$Zs1),
                           (nxv4f32 (AArch64dup (f32 fpimm0))))),
            (!cast<Instruction>(NAME # "_S") (PTRUE_S 31), ZPR:$Zs1)>;
  def : Pat<(nxv2i1 (ir_op (nxv2f64 ZPR:$Zs1),
                           (nxv2f64 (AArch64dup (f64 fpimm0))))),
            (!cast<Instruction>(NAME # "_D") (PTRUE_D 31), ZPR:$Zs1)>;

  // Inverted Intrinsics (e.g. LT -> GE)
  def : Pat<(nxv4i1 (inv_int_op (nxv4i1 PPRR:$Pg),
                                (nxv4f32 (AArch64dup (f32 fpimm0))),
                                (nxv4f32 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_S") PPRR:$Pg, ZPR:$Zs1)>;
  def : Pat<(nxv2i1 (inv_int_op (nxv2i1 PPRR:$Pg),
                                (nxv2f64 (AArch64dup (f64 fpimm0))),
                                (nxv2f64 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_D") PPRR:$Pg, ZPR:$Zs1)>;

  // Inverted IR
  def : Pat<(nxv4i1 (inv_ir_op (nxv4f32 (AArch64dup (f32 fpimm0))),
                               (nxv4f32 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_S") (PTRUE_S 31), ZPR:$Zs1)>;
  def : Pat<(nxv2i1 (inv_ir_op (nxv2f64 (AArch64dup (f64 fpimm0))),
                               (nxv2f64 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_D") (PTRUE_D 31), ZPR:$Zs1)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Misc - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_misc_0_b<bit sz, bits<2> opc, string asm, string suffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Zd"#suffix#", $Zn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23}    = opc{1};
  let Inst{22}    = sz;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-11} = 0b10110;
  let Inst{10}    = opc{0};
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_bin_cons_misc_0_b<bits<2> opc, string asm,
                                     SDPatternOperator op> {
  def _S : sve_int_bin_cons_misc_0_b<0b0, opc, asm, ".s">;
  def _D : sve_int_bin_cons_misc_0_b<0b1, opc, asm, ".d">;

  def : SVE_2_Op_Pat<nxv4f32, op, nxv4f32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2f64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_bin_cons_misc_0_c<bits<8> opc, string asm, string suffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn),
  asm, "\t$Zd"#suffix#", $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{7-6};
  let Inst{21}    = 0b1;
  let Inst{20-16} = opc{5-1};
  let Inst{15-11} = 0b10111;
  let Inst{10}    = opc{0};
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Unary Operations - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_u_zd<bit sz, bits<3> opc, string asm, string suffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn),
  asm, "\t$Zd"#suffix#", $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21-19} = 0b001;
  let Inst{18-16} = opc;
  let Inst{15-10} = 0b001100;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_fp_2op_u_zd<bits<3> opc, string asm, SDPatternOperator op> {
  def _S : sve_fp_2op_u_zd<0b0, opc, asm, ".s">;
  def _D : sve_fp_2op_u_zd<0b1, opc, asm, ".d">;

  def : SVE_1_Op_Pat<nxv4f32, op, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_1_Op_Pat<nxv2f64, op, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Multiply-Add Group
//===----------------------------------------------------------------------===//

class sve_int_mladdsub_vvv_pred<bits<2> sz8_64, bits<1> opc, string asm,
                                string suffix>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, ZPROp:$Zm, ZPROp:$Za),
  asm, "\t$Zdn"#suffix#", $Pg/m, $Zm"#suffix#", $Za"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Za;
  bits<5> Zm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15-14} = 0b11;
  let Inst{13}    = opc;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Za;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_mladdsub_vvv_pred<bits<1> opc, string asm,
                                     SDPatternOperator op> {
  def _B : sve_int_mladdsub_vvv_pred<0b00, opc, asm, ".b">;
  def _H : sve_int_mladdsub_vvv_pred<0b01, opc, asm, ".h">;
  def _S : sve_int_mladdsub_vvv_pred<0b10, opc, asm, ".s">;
  def _D : sve_int_mladdsub_vvv_pred<0b11, opc, asm, ".d">;

  def : SVE_4_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_4_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_4_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_4_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_mlas_vvv_pred<bits<2> sz8_64, bits<1> opc, string asm,
                            string suffix>
: I<(outs ZPROp:$Zda), (ins PPRROp:$Pg, ZPROp:$_Zda, ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Zda"#suffix#", $Pg/m, $Zn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zda;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15-14} = 0b01;
  let Inst{13}    = opc;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zda;

  let Constraints = "$Zda = $_Zda";
}

multiclass sve_int_mlas_vvv_pred<bits<1> opc, string asm,
                                 SDPatternOperator op> {
  def _B : sve_int_mlas_vvv_pred<0b00, opc, asm, ".b">;
  def _H : sve_int_mlas_vvv_pred<0b01, opc, asm, ".h">;
  def _S : sve_int_mlas_vvv_pred<0b10, opc, asm, ".s">;
  def _D : sve_int_mlas_vvv_pred<0b11, opc, asm, ".d">;

  def : SVE_4_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_4_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_4_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_4_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Reduction Group
//===----------------------------------------------------------------------===//

class sve_int_movprfx_pred<bits<2> sz8_32, bits<3> opc, string asm,
                           string suffix, string pg_suffix>
: I<(outs ZPROp:$Zd), (ins PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Zd"#suffix#", $Pg"#pg_suffix#", $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_32;
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_movprfx_pred<bits<3> opc, string asm, string pg_suffix> {
  def _B : sve_int_movprfx_pred<0b00, opc, asm, ".b", pg_suffix>;
  def _H : sve_int_movprfx_pred<0b01, opc, asm, ".h", pg_suffix>;
  def _S : sve_int_movprfx_pred<0b10, opc, asm, ".s", pg_suffix>;
  def _D : sve_int_movprfx_pred<0b11, opc, asm, ".d", pg_suffix>;
}

class sve_int_reduce<bits<2> sz8_32, bits<2> fmt, bits<3> opc, string asm,
                     string suffix, RegisterClass regtype>
: I<(outs regtype:$Vd), (ins PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Vd, $Pg, $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Vd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_32;
  let Inst{21}    = 0b0;
  let Inst{20-19} = fmt;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Vd;
}

multiclass sve_int_reduce_0_saddv<bits<3> opc, string asm,
                                  SDPatternOperator op> {
  def _B : sve_int_reduce<0b00, 0b00, opc, asm, ".b", FPR64>;
  def _H : sve_int_reduce<0b01, 0b00, opc, asm, ".h", FPR64>;
  def _S : sve_int_reduce<0b10, 0b00, opc, asm, ".s", FPR64>;

  def : Pat<(v2i64 (op (nxv16i1 PPRROp:$Pg), (nxv16i8 ZPROp:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_B) PPRROp:$Pg, ZPROp:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv8i1 PPRROp:$Pg), (nxv8i16 ZPROp:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_H) PPRROp:$Pg, ZPROp:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv4i1 PPRROp:$Pg), (nxv4i32 ZPROp:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_S) PPRROp:$Pg, ZPROp:$Zn), dsub)>;
}

multiclass sve_int_reduce_0<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_reduce<0b00, 0b00, opc, asm, ".b", FPR64>;
  def _H : sve_int_reduce<0b01, 0b00, opc, asm, ".h", FPR64>;
  def _S : sve_int_reduce<0b10, 0b00, opc, asm, ".s", FPR64>;
  def _D : sve_int_reduce<0b11, 0b00, opc, asm, ".d", FPR64>;

  def : Pat<(v2i64 (op (nxv16i1 PPRROp:$Pg), (nxv16i8 ZPROp:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_B) PPRROp:$Pg, ZPROp:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv8i1 PPRROp:$Pg), (nxv8i16 ZPROp:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_H) PPRROp:$Pg, ZPROp:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv4i1 PPRROp:$Pg), (nxv4i32 ZPROp:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_S) PPRROp:$Pg, ZPROp:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv2i1 PPRROp:$Pg), (nxv2i64 ZPROp:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_D) PPRROp:$Pg, ZPROp:$Zn), dsub)>;
}

multiclass sve_int_reduce_1<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_reduce<0b00, 0b01, opc, asm, ".b", FPR8>;
  def _H : sve_int_reduce<0b01, 0b01, opc, asm, ".h", FPR16>;
  def _S : sve_int_reduce<0b10, 0b01, opc, asm, ".s", FPR32>;
  def _D : sve_int_reduce<0b11, 0b01, opc, asm, ".d", FPR64>;

  def : Pat<(v16i8 (op (nxv16i1 PPRROp:$Pg), (nxv16i8 ZPROp:$Zn))),
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_B) PPRROp:$Pg, ZPROp:$Zn), bsub)>;
  def : Pat<(v8i16 (op (nxv8i1 PPRROp:$Pg), (nxv8i16 ZPROp:$Zn))),
            (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_H) PPRROp:$Pg, ZPROp:$Zn), hsub)>;
  def : Pat<(v4i32 (op (nxv4i1 PPRROp:$Pg), (nxv4i32 ZPROp:$Zn))),
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_S) PPRROp:$Pg, ZPROp:$Zn), ssub)>;
  def : Pat<(v2i64 (op (nxv2i1 PPRROp:$Pg), (nxv2i64 ZPROp:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_D) PPRROp:$Pg, ZPROp:$Zn), dsub)>;
}

multiclass sve_int_reduce_2<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_reduce<0b00, 0b11, opc, asm, ".b", FPR8>;
  def _H : sve_int_reduce<0b01, 0b11, opc, asm, ".h", FPR16>;
  def _S : sve_int_reduce<0b10, 0b11, opc, asm, ".s", FPR32>;
  def _D : sve_int_reduce<0b11, 0b11, opc, asm, ".d", FPR64>;

  def : Pat<(v16i8 (op (nxv16i1 PPRROp:$Pg), (nxv16i8 ZPROp:$Zn))),
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_B) PPRROp:$Pg, ZPROp:$Zn), bsub)>;
  def : Pat<(v8i16 (op (nxv8i1 PPRROp:$Pg), (nxv8i16 ZPROp:$Zn))),
            (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_H) PPRROp:$Pg, ZPROp:$Zn), hsub)>;
  def : Pat<(v4i32 (op (nxv4i1 PPRROp:$Pg), (nxv4i32 ZPROp:$Zn))),
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_S) PPRROp:$Pg, ZPROp:$Zn), ssub)>;
  def : Pat<(v2i64 (op (nxv2i1 PPRROp:$Pg), (nxv2i64 ZPROp:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_D) PPRROp:$Pg, ZPROp:$Zn), dsub)>;
}

//===----------------------------------------------------------------------===//
// SVE Permute - Extract Group
//===----------------------------------------------------------------------===//

class sve_int_perm_extract_i<string asm, SDPatternOperator op>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, ZPROp:$Zm, imm0_255dec:$imm8),
  asm, "\t$Zdn.b, $_Zdn.b, $Zm.b, $imm8",
  "",
  [(set ZPROp:$Zdn, (nxv16i8 (op (nxv16i8 ZPROp:$_Zdn), (nxv16i8 ZPROp:$Zm), (imm0_255dec:$imm8))))]>, Sched<[]> {
  bits<5> Zdn;
  bits<5> Zm;
  bits<8> imm8;
  let Inst{31-21} = 0b00000101001;
  let Inst{20-16} = imm8{7-3};
  let Inst{15-13} = 0b000;
  let Inst{12-10} = imm8{2-0};
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

//===----------------------------------------------------------------------===//
// SVE Permute - Cross Lane Group
//===----------------------------------------------------------------------===//

class sve_int_perm_dup_i<bits<4> tsz, Operand immtype, string asm,
                         string suffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn, immtype:$idx),
  asm, "\t$Zd"#suffix#", $Zn"#suffix#"$idx",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  bits<7> idx;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = {?,?}; // imm3h
  let Inst{21}    = 0b1;
  let Inst{20}    = {?}; // imm3l
  let Inst{19-16} = tsz;
  let Inst{15-10} = 0b001000;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_dup_i<string asm> {
  def _B : sve_int_perm_dup_i<{?,?,?,1}, sve_elm_idx_b, asm, ".b"> {
    let Inst{23-22} = idx{5-4};
    let Inst{20}    = idx{3};
    let Inst{19-17} = idx{2-0};
  }
  def _H : sve_int_perm_dup_i<{?,?,1,0}, sve_elm_idx_h, asm, ".h"> {
    let Inst{23-22} = idx{4-3};
    let Inst{20}    = idx{2};
    let Inst{19-18} = idx{1-0};
  }
  def _S : sve_int_perm_dup_i<{?,1,0,0}, sve_elm_idx_s, asm, ".s"> {
    let Inst{23-22} = idx{3-2};
    let Inst{20}    = idx{1};
    let Inst{19}    = idx{0};
  }
  def _D : sve_int_perm_dup_i<{1,0,0,0}, sve_elm_idx_d, asm, ".d"> {
    let Inst{23-22} = idx{2-1};
    let Inst{20}    = idx{0};
  }

  def : InstAlias<"mov $Zd.b, $Zn.b$idx",
                  (!cast<Instruction>(NAME # _B) ZPROp:$Zd, ZPROp:$Zn, sve_elm_idx_b:$idx), 1>;
  def : InstAlias<"mov $Zd.h, $Zn.h$idx",
                  (!cast<Instruction>(NAME # _H) ZPROp:$Zd, ZPROp:$Zn, sve_elm_idx_h:$idx), 1>;
  def : InstAlias<"mov $Zd.s, $Zn.s$idx",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, ZPROp:$Zn, sve_elm_idx_s:$idx), 1>;
  def : InstAlias<"mov $Zd.d, $Zn.d$idx",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, ZPROp:$Zn, sve_elm_idx_d:$idx), 1>;
  def : InstAlias<"mov $Zd.b, $Bn",
                  (!cast<Instruction>(NAME # _B) ZPROp:$Zd, FPR8asZPR:$Bn, 0), 2>;
  def : InstAlias<"mov $Zd.h, $Hn",
                  (!cast<Instruction>(NAME # _H) ZPROp:$Zd, FPR16asZPR:$Hn, 0), 2>;
  def : InstAlias<"mov $Zd.s, $Sn",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, FPR32asZPR:$Sn, 0), 2>;
  def : InstAlias<"mov $Zd.d, $Dn",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, FPR64asZPR:$Dn, 0), 2>;
}

class sve_int_perm_dup_r<bits<2> sz8_64, string asm, string suffix,
                         RegisterClass srcRegType>
: I<(outs ZPROp:$Zd), (ins srcRegType:$Rn),
  asm, "\t$Zd"#suffix#", $Rn",
  "",
  []>, Sched<[]> {
  bits<5> Rn;
  bits<5> Zd;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-10} = 0b100000001110;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_dup_r<string asm> {
  def _B : sve_int_perm_dup_r<0b00, asm, ".b", GPR32sp>;
  def _H : sve_int_perm_dup_r<0b01, asm, ".h", GPR32sp>;
  def _S : sve_int_perm_dup_r<0b10, asm, ".s", GPR32sp>;
  def _D : sve_int_perm_dup_r<0b11, asm, ".d", GPR64sp>;

  def : InstAlias<"mov $Zd.b, $Rn",
                  (!cast<Instruction>(NAME # _B) ZPROp:$Zd, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd.h, $Rn",
                  (!cast<Instruction>(NAME # _H) ZPROp:$Zd, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd.s, $Rn",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd.d, $Rn",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, GPR64sp:$Rn), 1>;
}

class sve_int_perm_insrs<bits<2> sz8_64, string asm, string suffix,
                         RegisterClass srcRegType>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, srcRegType:$Rm),
  asm, "\t$Zdn"#suffix#", $Rm",
  "",
  []>, Sched<[]> {
  bits<5> Rm;
  bits<5> Zdn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-10} = 0b100100001110;
  let Inst{9-5}   = Rm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_perm_insrs<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_insrs<0b00, asm, ".b", GPR32>;
  def _H : sve_int_perm_insrs<0b01, asm, ".h", GPR32>;
  def _S : sve_int_perm_insrs<0b10, asm, ".s", GPR32>;
  def _D : sve_int_perm_insrs<0b11, asm, ".d", GPR64>;

  def : SVE_2_Op_Pat<nxv16i8, op, nxv16i8, i32, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<nxv8i16, op, nxv8i16, i32, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i32, i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i64, i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_insrv<bits<2> sz8_64, string asm, string suffix,
                         RegisterClass srcRegType>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, srcRegType:$Vm),
  asm, "\t$Zdn"#suffix#", $Vm",
  "",
  []>, Sched<[]> {
  bits<5> Vm;
  bits<5> Zdn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-10} = 0b110100001110;
  let Inst{9-5}   = Vm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_perm_insrv<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_insrv<0b00, asm, ".b", FPR8>;
  def _H : sve_int_perm_insrv<0b01, asm, ".h", FPR16>;
  def _S : sve_int_perm_insrv<0b10, asm, ".s", FPR32>;
  def _D : sve_int_perm_insrv<0b11, asm, ".d", FPR64>;

  def : SVE_2_Op_Pat<nxv8f16, op, nxv8f16, f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4f32, op, nxv4f32, f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2f64, f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_reverse_z<bits<2> sz8_64, string asm, string suffix,
                             ValueType vt, SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn),
  asm, "\t$Zd"#suffix#", $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-10} = 0b111000001110;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_reverse_z<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_reverse_z<0b00, asm, ".b", nxv16i8, op>;
  def _H : sve_int_perm_reverse_z<0b01, asm, ".h", nxv8i16, op>;
  def _S : sve_int_perm_reverse_z<0b10, asm, ".s", nxv4i32, op>;
  def _D : sve_int_perm_reverse_z<0b11, asm, ".d", nxv2i64, op>;

  def : SVE_1_Op_Pat<nxv16i8, op, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_1_Op_Pat<nxv8i16, op, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_1_Op_Pat<nxv4i32, op, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_1_Op_Pat<nxv2i64, op, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_1_Op_Pat<nxv8f16, op, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_1_Op_Pat<nxv4f32, op, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_1_Op_Pat<nxv2f64, op, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_tbl<bits<2> sz8_64, string asm, string suffix,
                       RegisterOperand VecList, ValueType vt,
                       SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins VecList:$Zn, ZPROp:$Zm),
  asm, "\t$Zd"#suffix#", $Zn, $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-10} = 0b001100;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_tbl<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_tbl<0b00, asm, ".b", Z_b, nxv16i8, op>;
  def _H : sve_int_perm_tbl<0b01, asm, ".h", Z_h, nxv8i16, op>;
  def _S : sve_int_perm_tbl<0b10, asm, ".s", Z_s, nxv4i32, op>;
  def _D : sve_int_perm_tbl<0b11, asm, ".d", Z_d, nxv2i64, op>;

  def : InstAlias<asm # "\t$Zd.b, $Zn.b, $Zm.b",
                 (!cast<Instruction>(NAME # _B) ZPROp:$Zd, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<asm # "\t$Zd.h, $Zn.h, $Zm.h",
                 (!cast<Instruction>(NAME # _H) ZPROp:$Zd, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<asm # "\t$Zd.s, $Zn.s, $Zm.s",
                 (!cast<Instruction>(NAME # _S) ZPROp:$Zd, ZPROp:$Zn, ZPROp:$Zm), 0>;
  def : InstAlias<asm # "\t$Zd.d, $Zn.d, $Zm.d",
                 (!cast<Instruction>(NAME # _D) ZPROp:$Zd, ZPROp:$Zn, ZPROp:$Zm), 0>;

  def : SVE_2_Op_Pat<nxv16i8, op, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<nxv8i16, op, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
  def : SVE_2_Op_Pat<nxv8f16, op, nxv8f16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4f32, op, nxv4f32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2f64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_unpk<bits<2> sz16_64, bits<2> opc, string asm,
                        string suffix1, string suffix2, ValueType out_vt,
                        ValueType in_vt, SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn),
  asm, "\t$Zd"#suffix1#", $Zn"#suffix2,
  "",
  [(set ZPROp:$Zd, (out_vt (op (in_vt ZPROp:$Zn))))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz16_64;
  let Inst{21-18} = 0b1100;
  let Inst{17-16} = opc;
  let Inst{15-10} = 0b001110;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_unpk<bits<2> opc, string asm, SDPatternOperator op> {
  def _H : sve_int_perm_unpk<0b01, opc, asm, ".h", ".b", nxv8i16, nxv16i8, op>;
  def _S : sve_int_perm_unpk<0b10, opc, asm, ".s", ".h", nxv4i32, nxv8i16, op>;
  def _D : sve_int_perm_unpk<0b11, opc, asm, ".d", ".s", nxv2i64, nxv4i32, op>;
}

//===----------------------------------------------------------------------===//
// SVE Logical Mask Immediate Group
//===----------------------------------------------------------------------===//

class sve_int_dup_mask_imm<string asm>
: I<(outs ZPROp:$Zd), (ins logical_imm64:$imms),
  asm, "\t$Zd.d, $imms",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<13> imms;
  let Inst{31-18} = 0b00000101110000;
  let Inst{17-5} = imms;
  let Inst{4-0} = Zd;

  let isReMaterializable = 1;
  let DecoderMethod = "DecodeSVELogicalImmInstruction";
}

multiclass sve_int_dup_mask_imm<string asm> {
  def NAME : sve_int_dup_mask_imm<asm>;

  def : InstAlias<"dupm $Zd.b, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zd, sve_logical_imm8:$imm), 4>;
  def : InstAlias<"dupm $Zd.h, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zd, sve_logical_imm16:$imm), 3>;
  def : InstAlias<"dupm $Zd.s, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zd, sve_logical_imm32:$imm), 2>;

  // NOTE: All Zd.b forms have a CPY/DUP equivalent, hence no byte alias here.
  def : InstAlias<"mov $Zd.h, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zd, sve_preferred_logical_imm16:$imm), 7>;
  def : InstAlias<"mov $Zd.s, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zd, sve_preferred_logical_imm32:$imm), 6>;
  def : InstAlias<"mov $Zd.d, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zd, sve_preferred_logical_imm64:$imm), 5>;
}

class sve_int_log_imm<bits<2> opc, string asm, SDPatternOperator op>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, logical_imm64:$imms13),
  asm, "\t$Zdn.d, $_Zdn.d, $imms13",
  "",
  [(set ZPROp:$Zdn, (nxv2i64 (op (nxv2i64 ZPROp:$_Zdn), (logical_imm64:$imms13))))]>,
  Sched<[]> {
  bits<5> Zdn;
  bits<13> imms13;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = opc;
  let Inst{21-18} = 0b0000;
  let Inst{17-5}  = imms13;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DecoderMethod = "DecodeSVELogicalImmInstruction";
}

multiclass sve_int_log_imm<bits<2> opc, string asm, SDPatternOperator op,
                           string alias> {
  def NAME : sve_int_log_imm<opc, asm, op>;

  def : InstAlias<asm # "\t$Zdn.b, $Zdn.b, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zdn, sve_logical_imm8:$imm), 4>;
  def : InstAlias<asm # "\t$Zdn.h, $Zdn.h, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zdn, sve_logical_imm16:$imm), 3>;
  def : InstAlias<asm # "\t$Zdn.s, $Zdn.s, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zdn, sve_logical_imm32:$imm), 2>;

  def : InstAlias<alias # "\t$Zdn.b, $_Zdn.b, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zdn, sve_logical_imm8_not:$imm), 0>;
  def : InstAlias<alias # "\t$Zdn.h, $_Zdn.h, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zdn, sve_logical_imm16_not:$imm), 0>;
  def : InstAlias<alias # "\t$Zdn.s, $_Zdn.s, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zdn, sve_logical_imm32_not:$imm), 0>;
  def : InstAlias<alias # "\t$Zdn.d, $_Zdn.d, $imm",
                  (!cast<Instruction>(NAME) ZPROp:$Zdn, logical_imm64_not:$imm), 0>;
}

//===----------------------------------------------------------------------===//
// SVE Permute - Predicated Group
//===----------------------------------------------------------------------===//

class sve_int_perm_clast_rz<bits<2> sz8_64, bit ab, string asm, string suffix,
                            RegisterClass rt>
: I<(outs rt:$Rdn), (ins PPRROp:$Pg, rt:$_Rdn, ZPROp:$Zm),
  asm, "\t$Rdn, $Pg, $_Rdn, $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b11000;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Rdn;

  let Constraints = "$Rdn = $_Rdn";
}

multiclass sve_int_perm_clast_rz<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_clast_rz<0b00, ab, asm, ".b", GPR32>;
  def _H : sve_int_perm_clast_rz<0b01, ab, asm, ".h", GPR32>;
  def _S : sve_int_perm_clast_rz<0b10, ab, asm, ".s", GPR32>;
  def _D : sve_int_perm_clast_rz<0b11, ab, asm, ".d", GPR64>;

  def : SVE_3_Op_Pat<i32, op, nxv16i1, i32, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<i32, op, nxv8i1,  i32, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<i32, op, nxv4i1,  i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<i64, op, nxv2i1,  i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_clast_vz<bits<2> sz8_64, bit ab, string asm, string suffix,
                            RegisterClass rt>
: I<(outs rt:$Vdn), (ins PPRROp:$Pg, rt:$_Vdn, ZPROp:$Zm),
  asm, "\t$Vdn, $Pg, $_Vdn, $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Vdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b10101;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Vdn;

  let Constraints = "$Vdn = $_Vdn";
}

multiclass sve_int_perm_clast_vz<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_clast_vz<0b00, ab, asm, ".b", FPR8>;
  def _H : sve_int_perm_clast_vz<0b01, ab, asm, ".h", FPR16>;
  def _S : sve_int_perm_clast_vz<0b10, ab, asm, ".s", FPR32>;
  def _D : sve_int_perm_clast_vz<0b11, ab, asm, ".d", FPR64>;

  def : SVE_3_Op_Pat<f16, op, nxv8i1,  f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<f32, op, nxv4i1,  f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<f64, op, nxv2i1,  f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_clast_zz<bits<2> sz8_64, bit ab, string asm, string suffix>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, ZPROp:$Zm),
  asm, "\t$Zdn"#suffix#", $Pg, $_Zdn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b10100;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_perm_clast_zz<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_clast_zz<0b00, ab, asm, ".b">;
  def _H : sve_int_perm_clast_zz<0b01, ab, asm, ".h">;
  def _S : sve_int_perm_clast_zz<0b10, ab, asm, ".s">;
  def _D : sve_int_perm_clast_zz<0b11, ab, asm, ".d">;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8i1, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_compact<bit sz, string asm, string suffix>
: I<(outs ZPROp:$Zd), (ins PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Zd"#suffix#", $Pg, $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-23} = 0b000001011;
  let Inst{22}    = sz;
  let Inst{21-13} = 0b100001100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_compact<string asm, SDPatternOperator op> {
  def _S : sve_int_perm_compact<0b0, asm, ".s">;
  def _D : sve_int_perm_compact<0b1, asm, ".d">;

  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, !cast<Instruction>(NAME # _D)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_cpy_r<bits<2> sz8_64, string asm, string suffix,
                         RegisterClass srcRegType>
: I<(outs ZPROp:$Zd), (ins ZPROp:$_Zd, PPRROp:$Pg, srcRegType:$Rn),
  asm, "\t$Zd"#suffix#", $Pg/m, $Rn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zd;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-13} = 0b101000101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
}

multiclass sve_int_perm_cpy_r<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_cpy_r<0b00, asm, ".b", GPR32sp>;
  def _H : sve_int_perm_cpy_r<0b01, asm, ".h", GPR32sp>;
  def _S : sve_int_perm_cpy_r<0b10, asm, ".s", GPR32sp>;
  def _D : sve_int_perm_cpy_r<0b11, asm, ".d", GPR64sp>;

  def : InstAlias<"mov $Zd.b, $Pg/m, $Rn",
                  (!cast<Instruction>(NAME # _B) ZPROp:$Zd, PPRROp:$Pg, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd.h, $Pg/m, $Rn",
                  (!cast<Instruction>(NAME # _H) ZPROp:$Zd, PPRROp:$Pg, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd.s, $Pg/m, $Rn",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, PPRROp:$Pg, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd.d, $Pg/m, $Rn",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, PPRROp:$Pg, GPR64sp:$Rn), 1>;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i8, nxv16i1, i32, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  i32, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_cpy_v<bits<2> sz8_64, string asm, string suffix,
                         RegisterClass srcRegtype>
: I<(outs ZPROp:$Zd), (ins ZPROp:$_Zd, PPRROp:$Pg, srcRegtype:$Vn),
  asm, "\t$Zd"#suffix#", $Pg/m, $Vn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Vn;
  bits<5> Zd;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-13} = 0b100000100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Vn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
}

multiclass sve_int_perm_cpy_v<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_cpy_v<0b00, asm, ".b", FPR8>;
  def _H : sve_int_perm_cpy_v<0b01, asm, ".h", FPR16>;
  def _S : sve_int_perm_cpy_v<0b10, asm, ".s", FPR32>;
  def _D : sve_int_perm_cpy_v<0b11, asm, ".d", FPR64>;

  def : InstAlias<"mov $Zd.b, $Pg/m, $Vn",
                  (!cast<Instruction>(NAME # _B) ZPROp:$Zd, PPRROp:$Pg, FPR8:$Vn), 1>;
  def : InstAlias<"mov $Zd.h, $Pg/m, $Vn",
                  (!cast<Instruction>(NAME # _H) ZPROp:$Zd, PPRROp:$Pg, FPR16:$Vn), 1>;
  def : InstAlias<"mov $Zd.s, $Pg/m, $Vn",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, PPRROp:$Pg, FPR32:$Vn), 1>;
  def : InstAlias<"mov $Zd.d, $Pg/m, $Vn",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, PPRROp:$Pg, FPR64:$Vn), 1>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8f16, nxv8i1, f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4f32, nxv4i1, f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f32, op, nxv2f32, nxv2i1, f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2f64, nxv2i1, f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_last_r<bits<2> sz8_64, bit ab, string asm, string suffix,
                          RegisterClass resultRegType>
: I<(outs resultRegType:$Rd), (ins PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Rd, $Pg, $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b10000;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Rd;
}

multiclass sve_int_perm_last_r<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_last_r<0b00, ab, asm, ".b", GPR32>;
  def _H : sve_int_perm_last_r<0b01, ab, asm, ".h", GPR32>;
  def _S : sve_int_perm_last_r<0b10, ab, asm, ".s", GPR32>;
  def _D : sve_int_perm_last_r<0b11, ab, asm, ".d", GPR64>;

  def : SVE_2_Op_Pat<i32, op, nxv16i1, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<i32, op, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<i32, op, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<i64, op, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_last_v<bits<2> sz8_64, bit ab, string asm, string suffix,
                          RegisterClass dstRegtype>
: I<(outs dstRegtype:$Vd), (ins PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Vd, $Pg, $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Vd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b10001;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Vd;
}

multiclass sve_int_perm_last_v<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_last_v<0b00, ab, asm, ".b", FPR8>;
  def _H : sve_int_perm_last_v<0b01, ab, asm, ".h", FPR16>;
  def _S : sve_int_perm_last_v<0b10, ab, asm, ".s", FPR32>;
  def _D : sve_int_perm_last_v<0b11, ab, asm, ".d", FPR64>;

  def : SVE_2_Op_Pat<f16, op, nxv8i1,  nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<f32, op, nxv4i1,  nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<f32, op, nxv2i1,  nxv2f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<f64, op, nxv2i1,  nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_rev<bits<2> sz8_64, bits<2> opc, string asm,
                       string suffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$_Zd, PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Zd"#suffix#", $Pg/m, $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<3> Pg;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-18} = 0b1001;
  let Inst{17-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
}

multiclass sve_int_perm_rev_rbit<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_rev<0b00, 0b11, asm, ".b">;
  def _H : sve_int_perm_rev<0b01, 0b11, asm, ".h">;
  def _S : sve_int_perm_rev<0b10, 0b11, asm, ".s">;
  def _D : sve_int_perm_rev<0b11, 0b11, asm, ".d">;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i8, nxv16i1, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_perm_rev_revb<string asm, SDPatternOperator int_op,
                                 SDPatternOperator ir_op> {
  def _H : sve_int_perm_rev<0b01, 0b00, asm, ".h">;
  def _S : sve_int_perm_rev<0b10, 0b00, asm, ".s">;
  def _D : sve_int_perm_rev<0b11, 0b00, asm, ".d">;

  def : SVE_3_Op_Pat<nxv8i16, int_op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, int_op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, int_op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_1_Op_AllActive_Pat<nxv8i16, ir_op, nxv8i16, !cast<Instruction>(NAME # _H), PTRUE_H>;
  def : SVE_1_Op_AllActive_Pat<nxv4i32, ir_op, nxv4i32, !cast<Instruction>(NAME # _S), PTRUE_S>;
  def : SVE_1_Op_AllActive_Pat<nxv2i64, ir_op, nxv2i64, !cast<Instruction>(NAME # _D), PTRUE_D>;
}

multiclass sve_int_perm_rev_revh<string asm, SDPatternOperator op> {
  def _S : sve_int_perm_rev<0b10, 0b01, asm, ".s">;
  def _D : sve_int_perm_rev<0b11, 0b01, asm, ".d">;

  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_perm_rev_revw<string asm, SDPatternOperator op> {
  def _D : sve_int_perm_rev<0b11, 0b10, asm, ".d">;

  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_splice<bits<2> sz8_64, string asm, string suffix>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, ZPROp:$Zm),
  asm, "\t$Zdn"#suffix#", $Pg, $_Zdn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-13} = 0b101100100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_perm_splice<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_splice<0b00, asm, ".b">;
  def _H : sve_int_perm_splice<0b01, asm, ".h">;
  def _S : sve_int_perm_splice<0b10, asm, ".s">;
  def _D : sve_int_perm_splice<0b11, asm, ".d">;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8i1, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Stack Allocation Group
//===----------------------------------------------------------------------===//

class sve_int_arith_vl<bit opc, string asm>
: I<(outs GPR64sp:$Rd), (ins GPR64sp:$Rn, simm6:$imm6),
  asm, "\t$Rd, $Rn, $imm6",
  "",
  []>, Sched<[]> {
  bits<5> Rd;
  bits<5> Rn;
  bits<6> imm6;
  let Inst{31-23} = 0b000001000;
  let Inst{22}    = opc;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rn;
  let Inst{15-11} = 0b01010;
  let Inst{10-5}  = imm6;
  let Inst{4-0}   = Rd;
}

class sve_int_read_vl_a<bits<6> opc, string asm>
: I<(outs GPR64:$Rd), (ins simm6:$imm6),
  asm, "\t$Rd, $imm6",
  "",
  []>, Sched<[]> {
  bits<5> Rd;
  bits<6> imm6;
  let Inst{31-23} = 0b000001001;
  let Inst{22}    = opc{5};
  let Inst{21}    = 0b1;
  let Inst{20-16} = opc{4-0};
  let Inst{15-11} = 0b01010;
  let Inst{10-5}  = imm6;
  let Inst{4-0}   = Rd;
}

//===----------------------------------------------------------------------===//
// SVE Element Count Group
//===----------------------------------------------------------------------===//

class sve_int_count<bits<3> opc, string asm>
: I<(outs GPR64:$Rd), (ins sve_pred_enum:$pattern, sve_incdec_imm:$imm4),
  asm, "\t$Rd, $pattern, mul $imm4",
  "",
  []>, Sched<[]> {
  bits<5> Rd;
  bits<4> imm4;
  bits<5> pattern;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{2-1};
  let Inst{21-20} = 0b10;
  let Inst{19-16} = imm4;
  let Inst{15-11} = 0b11100;
  let Inst{10}    = opc{0};
  let Inst{9-5}   = pattern;
  let Inst{4-0}   = Rd;
}

multiclass sve_int_count<bits<3> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_count<opc, asm>;

  def : InstAlias<asm # "\t$Rd, $pattern",
                  (!cast<Instruction>(NAME) GPR64:$Rd, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rd",
                  (!cast<Instruction>(NAME) GPR64:$Rd, 0b11111, 1), 2>;

  def : Pat<(i64 (op sve_pred_enum:$pattern)),
            (!cast<Instruction>(NAME) sve_pred_enum:$pattern, 1)>;
}

class sve_int_countvlv<bits<5> opc, string asm, string suffix>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4),
  asm, "\t$Zdn"#suffix#", $pattern, mul $imm4",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<5> pattern;
  bits<4> imm4;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{4-3};
  let Inst{21}    = 0b1;
  let Inst{20}    = opc{2};
  let Inst{19-16} = imm4;
  let Inst{15-12} = 0b1100;
  let Inst{11-10} = opc{1-0};
  let Inst{9-5}   = pattern;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_countvlv<bits<5> opc, string asm, string suffix,
                            SDPatternOperator op = null_frag,
                            ValueType vt = OtherVT> {
  def NAME : sve_int_countvlv<opc, asm, suffix>;

  def : InstAlias<asm # "\t$Zdn" # suffix # ", $pattern",
                  (!cast<Instruction>(NAME) ZPROp:$Zdn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Zdn" # suffix,
                  (!cast<Instruction>(NAME) ZPROp:$Zdn, 0b11111, 1), 2>;

  def : Pat<(vt (op (vt ZPROp:$Zn), (sve_pred_enum:$pattern), (sve_incdec_imm:$imm4))),
            (!cast<Instruction>(NAME) $Zn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4)>;

}

class sve_int_pred_pattern_a<bits<3> opc, string asm>
: I<(outs GPR64:$Rdn), (ins GPR64:$_Rdn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4),
  asm, "\t$Rdn, $pattern, mul $imm4",
  "",
  []>, Sched<[]> {
  bits<5> Rdn;
  bits<5> pattern;
  bits<4> imm4;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{2-1};
  let Inst{21-20} = 0b11;
  let Inst{19-16} = imm4;
  let Inst{15-11} = 0b11100;
  let Inst{10}    = opc{0};
  let Inst{9-5}   = pattern;
  let Inst{4-0}   = Rdn;

  let Constraints = "$Rdn = $_Rdn";
}

multiclass sve_int_pred_pattern_a<bits<3> opc, string asm> {
  def NAME : sve_int_pred_pattern_a<opc, asm>;

  def : InstAlias<asm # "\t$Rdn, $pattern",
                  (!cast<Instruction>(NAME) GPR64:$Rdn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rdn",
                  (!cast<Instruction>(NAME) GPR64:$Rdn, 0b11111, 1), 2>;
}

class sve_int_pred_pattern_b<bits<5> opc, string asm, RegisterOperand dt,
                             RegisterOperand st>
: I<(outs dt:$Rdn), (ins st:$_Rdn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4),
  asm, "\t$Rdn, $pattern, mul $imm4",
  "",
  []>, Sched<[]> {
  bits<5> Rdn;
  bits<5> pattern;
  bits<4> imm4;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{4-3};
  let Inst{21}    = 0b1;
  let Inst{20}    = opc{2};
  let Inst{19-16} = imm4;
  let Inst{15-12} = 0b1111;
  let Inst{11-10} = opc{1-0};
  let Inst{9-5}   = pattern;
  let Inst{4-0}   = Rdn;

  // Signed 32bit forms require their GPR operand printed.
  let AsmString = !if(!eq(opc{2,0}, 0b00),
                      !strconcat(asm, "\t$Rdn, $_Rdn, $pattern, mul $imm4"),
                      !strconcat(asm, "\t$Rdn, $pattern, mul $imm4"));

  let AsmMatchConverter = !if(!eq(opc{2,0}, 0b00), "cvtXWPatternImm", "");
  let Constraints = "$Rdn = $_Rdn";
}

multiclass sve_int_pred_pattern_b_s32<bits<5> opc, string asm,
                                      SDPatternOperator op> {
  def NAME : sve_int_pred_pattern_b<opc, asm, GPR64Op, GPR64as32>;

  def : InstAlias<asm # "\t$Rd, $Rn, $pattern",
                  (!cast<Instruction>(NAME) GPR64Op:$Rd, GPR64as32:$Rn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rd, $Rn",
                  (!cast<Instruction>(NAME) GPR64Op:$Rd, GPR64as32:$Rn, 0b11111, 1), 2>;

  // NOTE: Register allocation doesn't like tied operands of differing register
  //       class, hence the extra INSERT_SUBREG complication.

  def : Pat<(i32 (op GPR32:$Rn, (sve_pred_enum:$pattern), (sve_incdec_imm:$imm4))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME) (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32), sve_pred_enum:$pattern, sve_incdec_imm:$imm4), sub_32)>;
}

multiclass sve_int_pred_pattern_b_u32<bits<5> opc, string asm,
                                      SDPatternOperator op> {
  def NAME : sve_int_pred_pattern_b<opc, asm, GPR32Op, GPR32Op>;

  def : InstAlias<asm # "\t$Rdn, $pattern",
                  (!cast<Instruction>(NAME) GPR32Op:$Rdn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rdn",
                  (!cast<Instruction>(NAME) GPR32Op:$Rdn, 0b11111, 1), 2>;

  def : Pat<(i32 (op GPR32:$Rn, (sve_pred_enum:$pattern), (sve_incdec_imm:$imm4))),
            (!cast<Instruction>(NAME) $Rn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4)>;
}

multiclass sve_int_pred_pattern_b_x64<bits<5> opc, string asm,
                                      SDPatternOperator op> {
  def NAME : sve_int_pred_pattern_b<opc, asm, GPR64Op, GPR64Op>;

  def : InstAlias<asm # "\t$Rdn, $pattern",
                  (!cast<Instruction>(NAME) GPR64Op:$Rdn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rdn",
                  (!cast<Instruction>(NAME) GPR64Op:$Rdn, 0b11111, 1), 2>;

  def : Pat<(i64 (op GPR64:$Rn, (sve_pred_enum:$pattern), (sve_incdec_imm:$imm4))),
            (!cast<Instruction>(NAME) $Rn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Wide Immediate - Predicated Group
//===----------------------------------------------------------------------===//

class sve_int_dup_fpimm_pred<bit sz, Operand fpimmtype,
                             string asm, string suffix>
: I<(outs ZPROp:$Zd), (ins PPROp:$Pg, fpimmtype:$imm8),
  asm, "\t$Zd"#suffix#", $Pg/m, $imm8",
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<5> Zd;
  bits<8> imm8;
  let Inst{31-23} = 0b000001011;
  let Inst{22}    = sz;
  let Inst{21-20} = 0b01;
  let Inst{19-16} = Pg;
  let Inst{15-13} = 0b110;
  let Inst{12-5}  = imm8;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_dup_fpimm_pred<string asm> {
  def _S : sve_int_dup_fpimm_pred<0b0, sve_fpimm32, asm, ".s">;
  def _D : sve_int_dup_fpimm_pred<0b1, sve_fpimm64, asm, ".d">;

  def : InstAlias<"fmov $Zd.s, $Pg/m, $imm8",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, PPROp:$Pg, sve_fpimm32:$imm8), 1>;
  def : InstAlias<"fmov $Zd.d, $Pg/m, $imm8",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, PPROp:$Pg, sve_fpimm64:$imm8), 1>;
}

class sve_int_dup_imm_pred<bits<2> sz8_64, bit m, string asm, string suffix,
                           string pred_qual, dag iops>
: I<(outs ZPROp:$Zd), iops,
  asm, "\t$Zd"#suffix#", $Pg"#pred_qual#", $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<4> Pg;
  bits<9> imm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-20} = 0b01;
  let Inst{19-16} = Pg;
  let Inst{15}    = 0b0;
  let Inst{14}    = m;
  let Inst{13}    = imm{8};   // sh
  let Inst{12-5}  = imm{7-0}; // imm8
  let Inst{4-0}   = Zd;
}

multiclass sve_int_dup_imm_pred_merge<string asm> {
let Constraints = "$Zd = $_Zd" in {
  def _B : sve_int_dup_imm_pred<0b00, 1, asm, ".b", "/m", (ins ZPROp:$_Zd, PPROp:$Pg, simm8_opt_lsl_i8:$imm)>;
  def _H : sve_int_dup_imm_pred<0b01, 1, asm, ".h", "/m", (ins ZPROp:$_Zd, PPROp:$Pg, simm8_opt_lsl_i16:$imm)>;
  def _S : sve_int_dup_imm_pred<0b10, 1, asm, ".s", "/m", (ins ZPROp:$_Zd, PPROp:$Pg, simm8_opt_lsl_i32:$imm)>;
  def _D : sve_int_dup_imm_pred<0b11, 1, asm, ".d", "/m", (ins ZPROp:$_Zd, PPROp:$Pg, simm8_opt_lsl_i64:$imm)>;
}

  def : InstAlias<"mov $Zd.b, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _B) ZPROp:$Zd, PPROp:$Pg, simm8_opt_lsl_i8:$imm), 1>;
  def : InstAlias<"mov $Zd.h, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _H) ZPROp:$Zd, PPROp:$Pg, simm8_opt_lsl_i16:$imm), 1>;
  def : InstAlias<"mov $Zd.s, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, PPROp:$Pg, simm8_opt_lsl_i32:$imm), 1>;
  def : InstAlias<"mov $Zd.d, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, PPROp:$Pg, simm8_opt_lsl_i64:$imm), 1>;

  def : InstAlias<"fmov $Zd.s, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, PPROp:$Pg, sve_fpzero:$imm), 0>;
  def : InstAlias<"fmov $Zd.d, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, PPROp:$Pg, sve_fpzero_f64:$imm), 0>;
}

multiclass sve_int_dup_imm_pred_zero<string asm> {
  def _B : sve_int_dup_imm_pred<0b00, 0, asm, ".b", "/z", (ins PPROp:$Pg, simm8_opt_lsl_i8:$imm)>;
  def _H : sve_int_dup_imm_pred<0b01, 0, asm, ".h", "/z", (ins PPROp:$Pg, simm8_opt_lsl_i16:$imm)>;
  def _S : sve_int_dup_imm_pred<0b10, 0, asm, ".s", "/z", (ins PPROp:$Pg, simm8_opt_lsl_i32:$imm)>;
  def _D : sve_int_dup_imm_pred<0b11, 0, asm, ".d", "/z", (ins PPROp:$Pg, simm8_opt_lsl_i64:$imm)>;

  def : InstAlias<"mov $Zd.b, $Pg/z, $imm",
                  (!cast<Instruction>(NAME # _B) ZPROp:$Zd, PPROp:$Pg, simm8_opt_lsl_i8:$imm), 1>;
  def : InstAlias<"mov $Zd.h, $Pg/z, $imm",
                  (!cast<Instruction>(NAME # _H) ZPROp:$Zd, PPROp:$Pg, simm8_opt_lsl_i16:$imm), 1>;
  def : InstAlias<"mov $Zd.s, $Pg/z, $imm",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, PPROp:$Pg, simm8_opt_lsl_i32:$imm), 1>;
  def : InstAlias<"mov $Zd.d, $Pg/z, $imm",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, PPROp:$Pg, simm8_opt_lsl_i64:$imm), 1>;
}

//===----------------------------------------------------------------------===//
// SVE Memory - Gather/Scatter 32-bit Group
//===----------------------------------------------------------------------===//

class sve_mem_32b_fill<string asm>
: I<(outs ZPROp:$Zt), (ins GPR64sp:$Rn, simm9MulVl:$imm9),
  asm, "\t$Zt, [$Rn, $imm9, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Rn;
  bits<5> Zt;
  bits<9> imm9;
  let Inst{31-22} = 0b1000010110;
  let Inst{21-16} = imm9{8-3};
  let Inst{15-13} = 0b010;
  let Inst{12-10} = imm9{2-0};
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_32b_fill<string asm> {
  def NAME : sve_mem_32b_fill<asm>;

  def : InstAlias<asm # "\t$Zt, [$Rn]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_32b_gld_sv<bits<3> dtype, bit xs, bit ff, string asm, string mod>
: I<(outs Z_s:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm.s, "#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = dtype{2-1};
  let Inst{22}    = xs;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14}    = dtype{0};
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_32b_gld_sv_32_scaled<bits<3> dtype, string asm,
                                        string scale> {
  def _UXTW_SCALED : sve_mem_32b_gld_sv<dtype, 0, 0, asm, "uxtw #"#scale>;
  def _SXTW_SCALED : sve_mem_32b_gld_sv<dtype, 1, 0, asm, "sxtw #"#scale>;

  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Rn, $Zm.s, uxtw #"#scale#"]",
                  (!cast<Instruction>(NAME # _UXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Rn, $Zm.s, sxtw #"#scale#"]",
                  (!cast<Instruction>(NAME # _SXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

multiclass sve_mem_32b_gld_sv_32_scaled_ff<bits<3> dtype, string asm,
                                           string scale> {
  def _UXTW_SCALED : sve_mem_32b_gld_sv<dtype, 0, 1, asm, "uxtw #"#scale>;
  def _SXTW_SCALED : sve_mem_32b_gld_sv<dtype, 1, 1, asm, "sxtw #"#scale>;

  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Rn, $Zm.s, uxtw #"#scale#"]",
                  (!cast<Instruction>(NAME # _UXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Rn, $Zm.s, sxtw #"#scale#"]",
                  (!cast<Instruction>(NAME # _SXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

class sve_mem_32b_gld_vi<bits<3> dtype, bit ff, string asm, Operand imm_ty>
: I<(outs Z_s:$Zt), (ins PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5),
  asm, "\t$Zt, $Pg/z, [$Zn.s, $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zn;
  bits<5> Zt;
  bits<5> imm5;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = dtype{2-1};
  let Inst{22-21} = 0b01;
  let Inst{20-16} = imm5;
  let Inst{15}    = 0b1;
  let Inst{14}    = dtype{0};
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_32b_gld_vi_32_ptrs<bits<3> dtype, string asm,
                                      Operand imm_ty> {
  def _IMM : sve_mem_32b_gld_vi<dtype, 0, asm, imm_ty>;

  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Zn.s]",
                  (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 0>;
  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Zn.s, $imm5]",
                  (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn.s]",
                  (!cast<Instruction>(NAME # _IMM) Z_s:$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 1>;
}

multiclass sve_mem_32b_gld_vi_32_ptrs_ff<bits<3> dtype, string asm,
                                         Operand imm_ty> {
  def _IMM : sve_mem_32b_gld_vi<dtype, 1, asm, imm_ty>;

  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Zn.s]",
                  (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 0>;
  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Zn.s, $imm5]",
                  (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn.s]",
                  (!cast<Instruction>(NAME # _IMM) Z_s:$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 1>;
}

class sve_mem_32b_gld_vs<bits<3> dtype, bit xs, bit ff, string asm, string mod>
: I<(outs Z_s:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm.s, "#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = dtype{2-1};
  let Inst{22}    = xs;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14}    = dtype{0};
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_32b_gld_vs_32_unscaled<bits<3> dtype, string asm> {
  def _UXTW : sve_mem_32b_gld_vs<dtype, 0, 0, asm, "uxtw">;
  def _SXTW : sve_mem_32b_gld_vs<dtype, 1, 0, asm, "sxtw">;

  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Rn, $Zm.s, uxtw]",
                  (!cast<Instruction>(NAME # _UXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Rn, $Zm.s, sxtw]",
                  (!cast<Instruction>(NAME # _SXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

multiclass sve_mem_32b_gld_vs_32_unscaled_ff<bits<3> dtype, string asm> {
  def _UXTW : sve_mem_32b_gld_vs<dtype, 0, 1, asm, "uxtw">;
  def _SXTW : sve_mem_32b_gld_vs<dtype, 1, 1, asm, "sxtw">;

  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Rn, $Zm.s, uxtw]",
                  (!cast<Instruction>(NAME # _UXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt.s, $Pg/z, [$Rn, $Zm.s, sxtw]",
                  (!cast<Instruction>(NAME # _SXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

class sve_mem_32b_pfill<string asm>
: I<(outs PPROp:$Pt), (ins GPR64sp:$Rn, simm9MulVl:$imm9),
  asm, "\t$Pt, [$Rn, $imm9, mul vl]",
  "",
  []>, Sched<[]> {
  bits<4> Pt;
  bits<5> Rn;
  bits<9> imm9;
  let Inst{31-22} = 0b1000010110;
  let Inst{21-16} = imm9{8-3};
  let Inst{15-13} = 0b000;
  let Inst{12-10} = imm9{2-0};
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pt;

  let mayLoad = 1;
}

multiclass sve_mem_32b_pfill<string asm> {
  def NAME : sve_mem_32b_pfill<asm>;

  def : InstAlias<asm # "\t$Pt, [$Rn]",
                  (!cast<Instruction>(NAME) PPROp:$Pt, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_32b_prfm_sv<bits<3> opc, string asm, string mod>
: I<(outs), (ins sve_prfop:$prfop, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$prfop, $Pg, [$Rn, $Zm.s"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<4> prfop;
  let Inst{31-23} = 0b100001000;
  let Inst{22}    = opc{2};   // xs
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = opc{1-0}; // msz
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

class sve_mem_32b_prfm_vi<bits<2> msz, string asm, Operand imm_ty>
: I<(outs), (ins sve_prfop:$prfop, PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5),
  asm, "\t$prfop, $Pg, [$Zn.s, $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zn;
  bits<5> imm5;
  bits<4> prfop;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = msz;
  let Inst{22-21} = 0b00;
  let Inst{20-16} = imm5;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;
}

multiclass sve_mem_32b_prfm_vi<bits<2> msz, string asm, Operand imm_ty> {
  def NAME : sve_mem_32b_prfm_vi<msz, asm, imm_ty>;

  def : InstAlias<asm # "\t$prfop, $Pg, [$Zn.s]",
                  (!cast<Instruction>(NAME) sve_prfop:$prfop, PPRROp:$Pg, ZPROp:$Zn, 0), 1>;
}

class sve_mem_ld_dup<bits<2> dtypeh, bits<2> dtypel, string asm,
                     RegisterOperand VecList, Operand immtype>
: I<(outs VecList:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, immtype:$imm6),
  asm, "\t$Zt, $Pg/z, [$Rn, $imm6]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<6> imm6;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = dtypeh;
  let Inst{22}    = 1;
  let Inst{21-16} = imm6;
  let Inst{15}    = 0b1;
  let Inst{14-13} = dtypel;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_ld_dup<bits<2> dtypeh, bits<2> dtypel, string asm,
                          string suffix, Operand immtype> {
  def NAME : sve_mem_ld_dup<dtypeh, dtypel, asm, !cast<RegisterOperand>("Z_"#suffix), immtype>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $imm6]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, immtype:$imm6), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) !cast<RegisterOperand>("Z_"#suffix):$Zt,
                                             PPRROp:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_prfm_si<bits<2> msz, string asm>
: I<(outs), (ins sve_prfop:$prfop, PPRROp:$Pg, GPR64sp:$Rn, simm6MulVl:$imm6),
  asm, "\t$prfop, $Pg, [$Rn, $imm6, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Rn;
  bits<3> Pg;
  bits<6> imm6;
  bits<4> prfop;
  let Inst{31-22} = 0b1000010111;
  let Inst{21-16} = imm6;
  let Inst{15}    = 0b0;
  let Inst{14-13} = msz;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

multiclass sve_mem_prfm_si<bits<2> msz, string asm> {
  def NAME : sve_mem_prfm_si<msz, asm>;

  def : InstAlias<asm # "\t$prfop, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) sve_prfop:$prfop, PPRROp:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_prfm_ss_base<bits<3> opc, string asm, string mod, dag iops>
: I<(outs), iops,
  asm, "\t$prfop, $Pg, [$Rn, $Rm"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<5> Rm;
  bits<5> Rn;
  bits<3> Pg;
  bits<4> prfop;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = opc{2-1};
  let Inst{22-21} = 0b00;
  let Inst{20-16} = Rm;
  let Inst{15}    = 0b1;
  let Inst{14}    = opc{0};
  let Inst{13}    = 0b0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

class sve_mem_prfm_ss_b<bits<3> opc, string asm>:
  sve_mem_prfm_ss_base<opc, asm, "",
                       (ins sve_prfop:$prfop, PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm)> {
}

class sve_mem_prfm_ss<bits<3> opc, string asm, string mod>:
  sve_mem_prfm_ss_base<opc, asm, mod,
                       (ins sve_prfop:$prfop, PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm)> {
}

//===----------------------------------------------------------------------===//
// SVE Compute Vector Address Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_misc_0_a<bits<2> opc, string asm, string suffix,
                                Operand immtype>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn, ZPROp:$Zm, immtype:$msz),
  asm, "\t$Zd"#suffix#", [$Zn"#suffix#", $Zm"#suffix#"$msz]",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  bits<5> Zm;
  bits<2> msz;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-12} = 0b1010;
  let Inst{11-10} = msz;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Arithmetic - Predicated Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_i_p_zds<bit sz, bits<3> opc, string asm, string suffix,
                         Operand imm_ty>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, imm_ty:$i1),
  asm, "\t$Zdn"#suffix#", $Pg/m, $_Zdn"#suffix#", $i1",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bit i1;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-6}   = 0b0000;
  let Inst{5}     = i1;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_fp_2op_i_p_zds<bits<3> opc, string asm, Operand imm_ty> {
  def _S : sve_fp_2op_i_p_zds<0b0, opc, asm, ".s", imm_ty>;
  def _D : sve_fp_2op_i_p_zds<0b1, opc, asm, ".d", imm_ty>;
}

class sve_fp_2op_p_zds<bit sz, bits<4> opc, string asm, string suffix>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, ZPROp:$Zm),
  asm, "\t$Zdn"#suffix#", $Pg/m, $_Zdn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21-20} = 0b00;
  let Inst{19-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_fp_2op_p_zds<bits<4> opc, string asm, SDPatternOperator op> {
  def _S : sve_fp_2op_p_zds<0b0, opc, asm, ".s">;
  def _D : sve_fp_2op_p_zds<0b1, opc, asm, ".d">;

  def Z_S : PredTwoOpPseudo;
  def Z_D : PredTwoOpPseudo;

  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, !cast<Pseudo>(NAME # Z_S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, !cast<Pseudo>(NAME # Z_D)>;
}

multiclass sve_fp_2op_p_zds_fscale<bits<4> opc, string asm,
                                   SDPatternOperator op> {
  def _S : sve_fp_2op_p_zds<0b0, opc, asm, ".s">;
  def _D : sve_fp_2op_p_zds<0b1, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_fp_ftmad<bit sz, string asm, string suffix>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, ZPROp:$Zm, imm32_0_7:$imm3),
  asm, "\t$Zdn"#suffix#", $_Zdn"#suffix#", $Zm"#suffix#", $imm3",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<5> Zm;
  bits<3> imm3;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21-19} = 0b010;
  let Inst{18-16} = imm3;
  let Inst{15-10} = 0b100000;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_fp_ftmad<string asm, SDPatternOperator op> {
  def _S : sve_fp_ftmad<0b0, asm, ".s">;
  def _D : sve_fp_ftmad<0b1, asm, ".d">;

  def : Pat<(nxv4f32 (op (nxv4f32 ZPROp:$Zn), (nxv4f32 ZPROp:$Zm), (i32 imm32_0_7:$imm))),
            (!cast<Instruction>(NAME # _S) ZPROp:$Zn, ZPROp:$Zm, imm32_0_7:$imm)>;
  def : Pat<(nxv2f64 (op (nxv2f64 ZPROp:$Zn), (nxv2f64 ZPROp:$Zm), (i32 imm32_0_7:$imm))),
            (!cast<Instruction>(NAME # _D) ZPROp:$Zn, ZPROp:$Zm, imm32_0_7:$imm)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Arithmetic - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_arit_0<bits<2> sz8_64, bits<3> opc, string asm,
                              string suffix, ValueType vt, SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Zd"#suffix#", $Zn"#suffix#", $Zm"#suffix,
  "",
  [(set (vt ZPROp:$Zd), (op (vt ZPROp:$Zn), (vt ZPROp:$Zm)))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b000;
  let Inst{12-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_bin_cons_arit_0<bits<3> opc, string asm,
                                   SDPatternOperator op> {
  def _B : sve_int_bin_cons_arit_0<0b00, opc, asm, ".b", nxv16i8, op>;
  def _H : sve_int_bin_cons_arit_0<0b01, opc, asm, ".h", nxv8i16, op>;
  def _S : sve_int_bin_cons_arit_0<0b10, opc, asm, ".s", nxv4i32, op>;
  def _D : sve_int_bin_cons_arit_0<0b11, opc, asm, ".d", nxv2i64, op>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Fast Reduction Group
//===----------------------------------------------------------------------===//

class sve_fp_fast_red<bit sz, bits<3> opc, string asm, string suffix,
                      RegisterClass dstRegClass>
: I<(outs dstRegClass:$Vd), (ins PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Vd, $Pg, $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<5> Zn;
  bits<5> Vd;
  bits<3> Pg;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21-19} = 0b000;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Vd;
}

multiclass sve_fp_fast_red<bits<3> opc, string asm, SDPatternOperator op> {
  def _S : sve_fp_fast_red<0b0, opc, asm, ".s", FPR32>;
  def _D : sve_fp_fast_red<0b1, opc, asm, ".d", FPR64>;

  def : SVE_2_Op_Pat<f32, op, nxv4i1, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<f32, op, nxv2i1, nxv2f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<f64, op, nxv2i1, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Compare - Vectors Group
//===----------------------------------------------------------------------===//

class sve_fp_3op_p_pd<bit sz, bits<3> opc, string asm, string suffix>
: I<(outs PPROp:$Pd), (ins PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Pd"#suffix#", $Pg/z, $Zn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = opc{2};
  let Inst{14}    = 0b1;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;
}

multiclass sve_fp_3op_p_pd<bits<3> opc, string asm, SDPatternOperator int_op,
                           SDPatternOperator ir_op = null_frag> {
  def _S : sve_fp_3op_p_pd<0b0, opc, asm, ".s">;
  def _D : sve_fp_3op_p_pd<0b1, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv4i1, int_op, nxv4i1, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i1, int_op, nxv2i1, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;

  def : SVE_2_Op_AllActive_Pat<nxv4i1, ir_op, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S), PTRUE_S>;
  def : SVE_2_Op_AllActive_Pat<nxv2i1, ir_op, nxv2f32, nxv2f32, !cast<Instruction>(NAME # _S), PTRUE_D>;
  def : SVE_2_Op_AllActive_Pat<nxv2i1, ir_op, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D), PTRUE_D>;
}

//===----------------------------------------------------------------------===//
// SVE Select Vectors Group
//===----------------------------------------------------------------------===//

class sve_int_sel_vvv<bits<2> sz8_64, string asm, string suffix>
: I<(outs ZPROp:$Zd), (ins PPROp:$Pg, ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Zd"#suffix#", $Pg, $Zn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-14} = 0b11;
  let Inst{13-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_sel_vvv<string asm, SDPatternOperator op> {
  def _B : sve_int_sel_vvv<0b00, asm, ".b">;
  def _H : sve_int_sel_vvv<0b01, asm, ".h">;
  def _S : sve_int_sel_vvv<0b10, asm, ".s">;
  def _D : sve_int_sel_vvv<0b11, asm, ".d">;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8i1,  nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1,  nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f32, op, nxv2i1,  nxv2f32, nxv2f32, !cast<Instruction>(NAME # _D)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1,  nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;

  def : InstAlias<"mov $Zd.b, $Pd/m, $Zn.b",
                  (!cast<Instruction>(NAME # _B) ZPROp:$Zd, PPROp:$Pd, ZPROp:$Zn, ZPROp:$Zd), 1>;
  def : InstAlias<"mov $Zd.h, $Pd/m, $Zn.h",
                  (!cast<Instruction>(NAME # _H) ZPROp:$Zd, PPROp:$Pd, ZPROp:$Zn, ZPROp:$Zd), 1>;
  def : InstAlias<"mov $Zd.s, $Pd/m, $Zn.s",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, PPROp:$Pd, ZPROp:$Zn, ZPROp:$Zd), 1>;
  def : InstAlias<"mov $Zd.d, $Pd/m, $Zn.d",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, PPROp:$Pd, ZPROp:$Zn, ZPROp:$Zd), 1>;
}

//===----------------------------------------------------------------------===//
// SVE Memory - Gather/Scatter 64-bit Group
//===----------------------------------------------------------------------===//

class sve_mem_64b_gld_sv<bits<3> dtype, bit xs, bit ff, string asm, string mod>
: I<(outs Z_d:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm.d, "#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = dtype{2-1};
  let Inst{22}    = xs;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14}    = dtype{0};
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_64b_gld_sv_32_scaled<bits<3> dtype, string asm,
                                        string scale> {
  def _UXTW_SCALED : sve_mem_64b_gld_sv<dtype, 0, 0, asm, "uxtw #"#scale>;
  def _SXTW_SCALED : sve_mem_64b_gld_sv<dtype, 1, 0, asm, "sxtw #"#scale>;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, uxtw #"#scale#"]",
                  (!cast<Instruction>(NAME # _UXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, sxtw #"#scale#"]",
                  (!cast<Instruction>(NAME # _SXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

multiclass sve_mem_64b_gld_sv_32_scaled_ff<bits<3> dtype, string asm,
                                           string scale> {
  def _UXTW_SCALED : sve_mem_64b_gld_sv<dtype, 0, 1, asm, "uxtw #"#scale>;
  def _SXTW_SCALED : sve_mem_64b_gld_sv<dtype, 1, 1, asm, "sxtw #"#scale>;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, uxtw #"#scale#"]",
                  (!cast<Instruction>(NAME # _UXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, sxtw #"#scale#"]",
                  (!cast<Instruction>(NAME # _SXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

class sve_mem_64b_gld_sv2<bits<3> dtype, bit ff, string asm, string mod>
: I<(outs Z_d:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm.d, "#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = dtype{2-1};
  let Inst{22-21} = 0b11;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14}    = dtype{0};
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_64b_gld_sv2_64_scaled<bits<3> dtype, string asm,
                                         string scale> {
  def _SCALED : sve_mem_64b_gld_sv2<dtype, 0, asm, "lsl #"#scale>;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, lsl #"#scale#"]",
                  (!cast<Instruction>(NAME # _SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

multiclass sve_mem_64b_gld_sv2_64_scaled_ff<bits<3> dtype, string asm,
                                            string scale> {
  def _SCALED : sve_mem_64b_gld_sv2<dtype, 1, asm, "lsl #"#scale>;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, lsl #"#scale#"]",
                  (!cast<Instruction>(NAME # _SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

class sve_mem_64b_gld_vi<bits<3> dtype, bit ff, string asm, Operand imm_ty>
: I<(outs Z_d:$Zt), (ins PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5),
  asm, "\t$Zt, $Pg/z, [$Zn.d, $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zn;
  bits<5> Zt;
  bits<5> imm5;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = dtype{2-1};
  let Inst{22-21} = 0b01;
  let Inst{20-16} = imm5;
  let Inst{15}    = 0b1;
  let Inst{14}    = dtype{0};
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_64b_gld_vi_64_ptrs<bits<3> dtype, string asm,
                                      Operand imm_ty> {
  def _IMM : sve_mem_64b_gld_vi<dtype, 0, asm, imm_ty>;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Zn.d]",
                  (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 0>;
  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Zn.d, $imm5]",
                 (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn.d]",
                  (!cast<Instruction>(NAME # _IMM) Z_d:$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 1>;
}

multiclass sve_mem_64b_gld_vi_64_ptrs_ff<bits<3> dtype, string asm,
                                         Operand imm_ty> {
  def _IMM : sve_mem_64b_gld_vi<dtype, 1, asm, imm_ty>;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Zn.d]",
                  (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 0>;
  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Zn.d, $imm5]",
                 (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn.d]",
                  (!cast<Instruction>(NAME # _IMM) Z_d:$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 1>;
}

class sve_mem_64b_gld_vs<bits<3> dtype, bit xs, bit ff, string asm, string mod>
: I<(outs Z_d:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm.d, "#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = dtype{2-1};
  let Inst{22}    = xs;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14}    = dtype{0};
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_64b_gld_vs_32_unscaled<bits<3> dtype, string asm> {
  def _UXTW : sve_mem_64b_gld_vs<dtype, 0, 0, asm, "uxtw">;
  def _SXTW : sve_mem_64b_gld_vs<dtype, 1, 0, asm, "sxtw">;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, uxtw]",
                  (!cast<Instruction>(NAME # _UXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, sxtw]",
                  (!cast<Instruction>(NAME # _SXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

multiclass sve_mem_64b_gld_vs_32_unscaled_ff<bits<3> dtype, string asm> {
  def _UXTW : sve_mem_64b_gld_vs<dtype, 0, 1, asm, "uxtw">;
  def _SXTW : sve_mem_64b_gld_vs<dtype, 1, 1, asm, "sxtw">;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, uxtw]",
                  (!cast<Instruction>(NAME # _UXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d, sxtw]",
                  (!cast<Instruction>(NAME # _SXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

class sve_mem_64b_gld_vs2<bits<3> dtype, bit ff, string asm>
: I<(outs Z_d:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, ZPROp:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm.d]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = dtype{2-1};
  let Inst{22-21} = 0b10;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14}    = dtype{0};
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_64b_gld_vs2_64_unscaled<bits<3> dtype, string asm> {
  def "" : sve_mem_64b_gld_vs2<dtype, 0, asm>;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPROp:$Zm), 0>;
}

multiclass sve_mem_64b_gld_vs2_64_unscaled_ff<bits<3> dtype, string asm> {
  def "" : sve_mem_64b_gld_vs2<dtype, 1, asm>;

  def : InstAlias<asm # "\t$Zt.d, $Pg/z, [$Rn, $Zm.d]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPROp:$Zm), 0>;
}

class sve_mem_64b_prfm_sv<bits<3> opc, string asm, string mod>
: I<(outs), (ins sve_prfop:$prfop, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$prfop, $Pg, [$Rn, $Zm.d"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<4> prfop;
  let Inst{31-23} = 0b110001000;
  let Inst{22}    = opc{2};   // xs
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = opc{1-0}; // msz
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

class sve_mem_64b_prfm_sv2<bits<2> msz, string asm, string mod>
: I<(outs), (ins sve_prfop:$prfop, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$prfop, $Pg, [$Rn, $Zm.d"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<4> prfop;
  let Inst{31-21} = 0b11000100011;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14-13} = msz;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

class sve_mem_64b_prfm_vi<bits<2> msz, string asm, Operand imm_ty>
: I<(outs), (ins sve_prfop:$prfop, PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5),
  asm, "\t$prfop, $Pg, [$Zn.d, $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zn;
  bits<5> imm5;
  bits<4> prfop;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = msz;
  let Inst{22-21} = 0b00;
  let Inst{20-16} = imm5;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

multiclass sve_mem_64b_prfm_vi<bits<2> msz, string asm, Operand imm_ty> {
  def NAME : sve_mem_64b_prfm_vi<msz, asm, imm_ty>;

  def : InstAlias<asm # "\t$prfop, $Pg, [$Zn.d]",
                  (!cast<Instruction>(NAME) sve_prfop:$prfop, PPRROp:$Pg, ZPROp:$Zn, 0), 1>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Arithmetic - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_fp_3op_u_zd<bit sz, bits<3> opc, string asm, string suffix,
                      ValueType vt, ValueType vt2, SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins  ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Zd"#suffix#", $Zn"#suffix#", $Zm"#suffix,
  "",
  [(set (vt ZPROp:$Zd), (op (vt ZPROp:$Zn), (vt2 ZPROp:$Zm)))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b000;
  let Inst{12-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_fp_3op_u_zd<bits<3> opc, string asm, SDPatternOperator op> {
  def _S : sve_fp_3op_u_zd<0b0, opc, asm, ".s", nxv4f32, nxv4f32, op>;
  def _D : sve_fp_3op_u_zd<0b1, opc, asm, ".d", nxv2f64, nxv2f64, op>;
}

multiclass sve_fp_3op_u_zd_ftsmul<bits<3> opc, string asm,
                                  SDPatternOperator op> {
  def _S : sve_fp_3op_u_zd<0b0, opc, asm, ".s", nxv4f32, nxv4i32, op>;
  def _D : sve_fp_3op_u_zd<0b1, opc, asm, ".d", nxv2f64, nxv2i64, op>;
}

//===----------------------------------------------------------------------===//
// SVE Permute - In Lane Group
//===----------------------------------------------------------------------===//

class sve_int_perm_bin_perm_zz<bits<3> opc, bits<2> sz8_64, string asm,
                               string suffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Zd"#suffix#", $Zn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b011;
  let Inst{12-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_bin_perm_zz<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _B : sve_int_perm_bin_perm_zz<opc, 0b00, asm, ".b">;
  def _H : sve_int_perm_bin_perm_zz<opc, 0b01, asm, ".h">;
  def _S : sve_int_perm_bin_perm_zz<opc, 0b10, asm, ".s">;
  def _D : sve_int_perm_bin_perm_zz<opc, 0b11, asm, ".d">;

  def : SVE_2_Op_Pat<nxv16i8, op, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<nxv8i16, op, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_2_Op_Pat<nxv8f16, op, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4f32, op, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Shift by Immediate - Predicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_pred_shift_0<bits<4> tsz8_64, bits<3> opc, string asm,
                               string suffix, Operand immtype>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, immtype:$imm),
  asm, "\t$Zdn"#suffix#", $Pg/m, $_Zdn"#suffix#", $imm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<6> imm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = tsz8_64{3-2};
  let Inst{21-19} = 0b000;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-8}   = tsz8_64{1-0};
  let Inst{7-5}   = imm{2-0}; // imm3
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_bin_pred_shift_0_left<bits<3> opc, string asm> {
  def _B : sve_int_bin_pred_shift_0<{0,0,0,1}, opc, asm, ".b", vecshiftL8>;
  def _H : sve_int_bin_pred_shift_0<{0,0,1,?}, opc, asm, ".h", vecshiftL16> {
    let Inst{8} = imm{3};
  }
  def _S : sve_int_bin_pred_shift_0<{0,1,?,?}, opc, asm, ".s", vecshiftL32> {
    let Inst{9-8} = imm{4-3};
  }
  def _D : sve_int_bin_pred_shift_0<{1,?,?,?}, opc, asm, ".d", vecshiftL64> {
    let Inst{22}  = imm{5};
    let Inst{9-8} = imm{4-3};
  }
}

multiclass sve_int_bin_pred_shift_0_right<bits<3> opc, string asm,
                                          SDPatternOperator op = null_frag> {
  def _B : sve_int_bin_pred_shift_0<{0,0,0,1}, opc, asm, ".b", vecshiftR8>;
  def _H : sve_int_bin_pred_shift_0<{0,0,1,?}, opc, asm, ".h", vecshiftR16> {
    let Inst{8} = imm{3};
  }
  def _S : sve_int_bin_pred_shift_0<{0,1,?,?}, opc, asm, ".s", vecshiftR32> {
    let Inst{9-8} = imm{4-3};
  }
  def _D : sve_int_bin_pred_shift_0<{1,?,?,?}, opc, asm, ".d", vecshiftR64> {
    let Inst{22}  = imm{5};
    let Inst{9-8} = imm{4-3};
  }

  def : Pat<(nxv16i8 (op (nxv16i1 PPRROp:$Pg), (nxv16i8 ZPROp:$Zn), (i32 vecshiftR8:$imm))),
            (!cast<Instruction>(NAME # _B) PPRROp:$Pg, ZPROp:$Zn, vecshiftR8:$imm)>;
  def : Pat<(nxv8i16 (op (nxv8i1 PPRROp:$Pg), (nxv8i16 ZPROp:$Zn), (i32 vecshiftR16:$imm))),
            (!cast<Instruction>(NAME # _H) PPRROp:$Pg, ZPROp:$Zn, vecshiftR16:$imm)>;
  def : Pat<(nxv4i32 (op (nxv4i1 PPRROp:$Pg), (nxv4i32 ZPROp:$Zn), (i32 vecshiftR32:$imm))),
            (!cast<Instruction>(NAME # _S) PPRROp:$Pg, ZPROp:$Zn, vecshiftR32:$imm)>;
  def : Pat<(nxv2i64 (op (nxv2i1 PPRROp:$Pg), (nxv2i64 ZPROp:$Zn), (i32 vecshiftR64:$imm))),
            (!cast<Instruction>(NAME # _D) PPRROp:$Pg, ZPROp:$Zn, vecshiftR64:$imm)>;
}

class sve_int_bin_pred_shift_1<bits<2> sz8_64, bits<3> opc, string asm,
                               string suffix>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, ZPROp:$Zm),
  asm, "\t$Zdn"#suffix#", $Pg/m, $_Zdn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_bin_pred_shift_1<bits<3> opc, string asm,
                                    SDPatternOperator op = null_frag> {
  def _B : sve_int_bin_pred_shift_1<0b00, opc, asm, ".b">;
  def _H : sve_int_bin_pred_shift_1<0b01, opc, asm, ".h">;
  def _S : sve_int_bin_pred_shift_1<0b10, opc, asm, ".s">;
  def _D : sve_int_bin_pred_shift_1<0b11, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_bin_pred_shift_2<bits<2> sz8_64, bits<3> opc, string asm,
                               string suffix>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, ZPROp:$Zm),
  asm, "\t$Zdn"#suffix#", $Pg/m, $_Zdn"#suffix#", $Zm.d",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_bin_pred_shift_2<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _B : sve_int_bin_pred_shift_2<0b00, opc, asm, ".b">;
  def _H : sve_int_bin_pred_shift_2<0b01, opc, asm, ".h">;
  def _S : sve_int_bin_pred_shift_2<0b10, opc, asm, ".s">;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv2i64, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv2i64, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv2i64, !cast<Instruction>(NAME # _S)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Compare - Vectors Group
//===----------------------------------------------------------------------===//

// NOTE: Covers the non-wide instructions within sve_int_cmp_0.
class sve_int_cmp<bits<2> sz8_64, bits<3> opc, string asm, string suffix>
: I<(outs PPROp:$Pd), (ins PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Pd"#suffix#", $Pg/z, $Zn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zn;
  bits<5> Zm;
  let Inst{31-24} = 0b00100100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = opc{2};
  let Inst{14}    = 0b0;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

// NOTE: Convers wide instructions within sve_int_cmp_0 and sve_int_cmp_1.
class sve_int_cmp_wide<bit cmp_1, bits<2> sz8_64, bits<3> opc, string asm,
                       string suffix>
: I<(outs PPROp:$Pd), (ins PPRROp:$Pg, ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Pd"#suffix#", $Pg/z, $Zn"#suffix#", $Zm.d",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00100100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = opc{2};
  let Inst{14}    = cmp_1;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_cmp_0<bits<3> opc, string asm, SDPatternOperator op,
                         CondCode cc> {
  def _B : sve_int_cmp<0b00, opc, asm, ".b">;
  def _H : sve_int_cmp<0b01, opc, asm, ".h">;
  def _S : sve_int_cmp<0b10, opc, asm, ".s">;
  def _D : sve_int_cmp<0b11, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i1,  op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_Cmp_Pat0<nxv16i1, nxv16i8, cc, !cast<Instruction>(NAME # _B), PTRUE_B>;
  def : SVE_Cmp_Pat0<nxv8i1,  nxv8i16, cc, !cast<Instruction>(NAME # _H), PTRUE_H>;
  def : SVE_Cmp_Pat0<nxv4i1,  nxv4i32, cc, !cast<Instruction>(NAME # _S), PTRUE_S>;
  def : SVE_Cmp_Pat0<nxv2i1,  nxv2i64, cc, !cast<Instruction>(NAME # _D), PTRUE_D>;

  def : SVE_Cmp_Pat1<nxv16i1, nxv16i8, cc, !cast<Instruction>(NAME # _B)>;
  def : SVE_Cmp_Pat1<nxv8i1,  nxv8i16, cc, !cast<Instruction>(NAME # _H)>;
  def : SVE_Cmp_Pat1<nxv4i1,  nxv4i32, cc, !cast<Instruction>(NAME # _S)>;
  def : SVE_Cmp_Pat1<nxv2i1,  nxv2i64, cc, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_cmp_0_wide<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_cmp_wide<0b0, 0b00, opc, asm, ".b">;
  def _H : sve_int_cmp_wide<0b0, 0b01, opc, asm, ".h">;
  def _S : sve_int_cmp_wide<0b0, 0b10, opc, asm, ".s">;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i8, nxv2i64, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i16, nxv2i64, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i32, nxv2i64, !cast<Instruction>(NAME # _S)>;
}

multiclass sve_int_cmp_1_wide<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_cmp_wide<0b1, 0b00, opc, asm, ".b">;
  def _H : sve_int_cmp_wide<0b1, 0b01, opc, asm, ".h">;
  def _S : sve_int_cmp_wide<0b1, 0b10, opc, asm, ".s">;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i8, nxv2i64, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i16, nxv2i64, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i32, nxv2i64, !cast<Instruction>(NAME # _S)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Arithmetic - Binary Predicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_pred_arit_log<bits<2> sz8_64, bits<2> fmt, bits<3> opc,
                                string asm, string suffix, SDPatternOperator op,
                                ValueType pt, ValueType zt>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, ZPROp:$Zm),
  asm, "\t$Zdn"#suffix#", $Pg/m, $_Zdn"#suffix#", $Zm"#suffix, "", []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-19} = fmt;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b000;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_bin_pred_arit_0<bits<3> opc, string asm,
                                   SDPatternOperator op> {
  def _B : sve_int_bin_pred_arit_log<0b00, 0b00, opc, asm, ".b", op, nxv16i1, nxv16i8>;
  def _H : sve_int_bin_pred_arit_log<0b01, 0b00, opc, asm, ".h", op, nxv8i1, nxv8i16>;
  def _S : sve_int_bin_pred_arit_log<0b10, 0b00, opc, asm, ".s", op, nxv4i1, nxv4i32>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b00, opc, asm, ".d", op, nxv2i1, nxv2i64>;

  def Z_B : PredTwoOpPseudo;
  def Z_H : PredTwoOpPseudo;
  def Z_S : PredTwoOpPseudo;
  def Z_D : PredTwoOpPseudo;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Pseudo>(NAME # Z_B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Pseudo>(NAME # Z_H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Pseudo>(NAME # Z_S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Pseudo>(NAME # Z_D)>;
}

multiclass sve_int_bin_pred_arit_1<bits<3> opc, string asm,
                                   SDPatternOperator op> {
  def _B : sve_int_bin_pred_arit_log<0b00, 0b01, opc, asm, ".b", op, nxv16i1, nxv16i8>;
  def _H : sve_int_bin_pred_arit_log<0b01, 0b01, opc, asm, ".h", op, nxv8i1, nxv8i16>;
  def _S : sve_int_bin_pred_arit_log<0b10, 0b01, opc, asm, ".s", op, nxv4i1, nxv4i32>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b01, opc, asm, ".d", op, nxv2i1, nxv2i64>;

  def Z_B : PredTwoOpPseudo;
  def Z_H : PredTwoOpPseudo;
  def Z_S : PredTwoOpPseudo;
  def Z_D : PredTwoOpPseudo;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Pseudo>(NAME # Z_B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Pseudo>(NAME # Z_H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Pseudo>(NAME # Z_S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Pseudo>(NAME # Z_D)>;
}

multiclass sve_int_bin_pred_arit_2<bits<3> opc, string asm,
                                   SDPatternOperator op> {
  def _B : sve_int_bin_pred_arit_log<0b00, 0b10, opc, asm, ".b", op, nxv16i1, nxv16i8>;
  def _H : sve_int_bin_pred_arit_log<0b01, 0b10, opc, asm, ".h", op, nxv8i1, nxv8i16>;
  def _S : sve_int_bin_pred_arit_log<0b10, 0b10, opc, asm, ".s", op, nxv4i1, nxv4i32>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b10, opc, asm, ".d", op, nxv2i1, nxv2i64>;

  def Z_B : PredTwoOpPseudo;
  def Z_H : PredTwoOpPseudo;
  def Z_S : PredTwoOpPseudo;
  def Z_D : PredTwoOpPseudo;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Pseudo>(NAME # Z_B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Pseudo>(NAME # Z_H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Pseudo>(NAME # Z_S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Pseudo>(NAME # Z_D)>;
}

// Special case for divides which are not defined for 8b/16b elements.
multiclass sve_int_bin_pred_arit_2_div<bits<3> opc, string asm,
                                       SDPatternOperator op> {
  def _S : sve_int_bin_pred_arit_log<0b10, 0b10, opc, asm, ".s", op, nxv4i1, nxv4i32>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b10, opc, asm, ".d", op, nxv2i1, nxv2i64>;

  def Z_S : PredTwoOpPseudo;
  def Z_D : PredTwoOpPseudo;

  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Pseudo>(NAME # Z_S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Pseudo>(NAME # Z_D)>;
}

multiclass sve_int_bin_pred_log<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_bin_pred_arit_log<0b00, 0b11, opc, asm, ".b", op, nxv16i1, nxv16i8>;
  def _H : sve_int_bin_pred_arit_log<0b01, 0b11, opc, asm, ".h", op, nxv8i1, nxv8i16>;
  def _S : sve_int_bin_pred_arit_log<0b10, 0b11, opc, asm, ".s", op, nxv4i1, nxv4i32>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b11, opc, asm, ".d", op, nxv2i1, nxv2i64>;

  def Z_B : PredTwoOpPseudo;
  def Z_H : PredTwoOpPseudo;
  def Z_S : PredTwoOpPseudo;
  def Z_D : PredTwoOpPseudo;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Pseudo>(NAME # Z_B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Pseudo>(NAME # Z_H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Pseudo>(NAME # Z_S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Pseudo>(NAME # Z_D)>;
}

//===----------------------------------------------------------------------===//
//SVE Index Generation Group
//===----------------------------------------------------------------------===//

class sve_int_index_ii<bits<2> sz8_64, string asm, string suffix,
                       Operand imm_ty, ValueType vt, SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins imm_ty:$imm5, imm_ty:$imm5b),
  asm, "\t$Zd"#suffix#", $imm5, $imm5b",
  "",
  [(set (vt ZPROp:$Zd), (op imm_ty:$imm5, imm_ty:$imm5b))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> imm5;
  bits<5> imm5b;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = imm5b;
  let Inst{15-10} = 0b010000;
  let Inst{9-5}   = imm5;
  let Inst{4-0}   = Zd;

  let isReMaterializable = 1;
}

multiclass sve_int_index_ii<string asm, SDPatternOperator op> {
  def _B : sve_int_index_ii<0b00, asm, ".b", simm5_32b, nxv16i8, op>;
  def _H : sve_int_index_ii<0b01, asm, ".h", simm5_32b, nxv8i16, op>;
  def _S : sve_int_index_ii<0b10, asm, ".s", simm5_32b, nxv4i32, op>;
  def _D : sve_int_index_ii<0b11, asm, ".d", simm5_64b, nxv2i64, op>;
}

class sve_int_index_ir<bits<2> sz8_64, string asm, string suffix,
                       RegisterClass srcRegType, Operand imm_ty, ValueType vt,
                       SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins imm_ty:$imm5, srcRegType:$Rm),
  asm, "\t$Zd"#suffix#", $imm5, $Rm",
  "",
  [(set (vt ZPROp:$Zd), (op imm_ty:$imm5, srcRegType:$Rm))]>, Sched<[]> {
  bits<5> Rm;
  bits<5> Zd;
  bits<5> imm5;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-10} = 0b010010;
  let Inst{9-5}   = imm5;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_index_ir<string asm, SDPatternOperator op> {
  def _B : sve_int_index_ir<0b00, asm, ".b", GPR32, simm5_32b, nxv16i8, op>;
  def _H : sve_int_index_ir<0b01, asm, ".h", GPR32, simm5_32b, nxv8i16, op>;
  def _S : sve_int_index_ir<0b10, asm, ".s", GPR32, simm5_32b, nxv4i32, op>;
  def _D : sve_int_index_ir<0b11, asm, ".d", GPR64, simm5_64b, nxv2i64, op>;
}

class sve_int_index_ri<bits<2> sz8_64, string asm, string suffix,
                       RegisterClass srcRegType, Operand imm_ty, ValueType vt,
                       SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins srcRegType:$Rn, imm_ty:$imm5),
  asm, "\t$Zd"#suffix#", $Rn, $imm5",
  "",
  [(set (vt ZPROp:$Zd), (op srcRegType:$Rn, imm_ty:$imm5))]>, Sched<[]> {
  bits<5> Rn;
  bits<5> Zd;
  bits<5> imm5;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = imm5;
  let Inst{15-10} = 0b010001;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_index_ri<string asm, SDPatternOperator op> {
  def _B : sve_int_index_ri<0b00, asm, ".b", GPR32, simm5_32b, nxv16i8, op>;
  def _H : sve_int_index_ri<0b01, asm, ".h", GPR32, simm5_32b, nxv8i16, op>;
  def _S : sve_int_index_ri<0b10, asm, ".s", GPR32, simm5_32b, nxv4i32, op>;
  def _D : sve_int_index_ri<0b11, asm, ".d", GPR64, simm5_64b, nxv2i64, op>;
}

class sve_int_index_rr<bits<2> sz8_64, string asm, string suffix,
                       RegisterClass srcRegType, ValueType vt,
                       SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins srcRegType:$Rn, srcRegType:$Rm),
  asm, "\t$Zd"#suffix#", $Rn, $Rm",
  "",
  [(set (vt ZPROp:$Zd), (op srcRegType:$Rn, srcRegType:$Rm))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-10} = 0b010011;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_index_rr<string asm, SDPatternOperator op> {
  def _B : sve_int_index_rr<0b00, asm, ".b", GPR32, nxv16i8, op>;
  def _H : sve_int_index_rr<0b01, asm, ".h", GPR32, nxv8i16, op>;
  def _S : sve_int_index_rr<0b10, asm, ".s", GPR32, nxv4i32, op>;
  def _D : sve_int_index_rr<0b11, asm, ".d", GPR64, nxv2i64, op>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Wide Immediate - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_arith_imm0<bits<2> sz8_64, bits<3> opc, string asm, string suffix,
                         Operand immtype>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, immtype:$imm),
  asm, "\t$Zdn"#suffix#", $_Zdn"#suffix#", $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<9> imm;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b100;
  let Inst{18-16} = opc;
  let Inst{15-14} = 0b11;
  let Inst{13}    = imm{8};   // sh
  let Inst{12-5}  = imm{7-0}; // imm8
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_arith_imm0<bits<3> opc, string asm> {
  def _B : sve_int_arith_imm0<0b00, opc, asm, ".b", uimm8_opt_lsl_i8>;
  def _H : sve_int_arith_imm0<0b01, opc, asm, ".h", uimm8_opt_lsl_i16>;
  def _S : sve_int_arith_imm0<0b10, opc, asm, ".s", uimm8_opt_lsl_i32>;
  def _D : sve_int_arith_imm0<0b11, opc, asm, ".d", uimm8_opt_lsl_i64>;
}

class sve_int_arith_imm1<bits<2> sz8_64, bits<3> opc, string asm, string suffix,
                         Operand immtype>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, immtype:$imm),
  asm, "\t$Zdn"#suffix#", $_Zdn"#suffix#", $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<8> imm;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b101;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b110;
  let Inst{12-5} = imm;
  let Inst{4-0} = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_arith_imm1<bits<3> opc, string asm, Operand immtype> {
  def _B : sve_int_arith_imm1<0b00, opc, asm, ".b", immtype>;
  def _H : sve_int_arith_imm1<0b01, opc, asm, ".h", immtype>;
  def _S : sve_int_arith_imm1<0b10, opc, asm, ".s", immtype>;
  def _D : sve_int_arith_imm1<0b11, opc, asm, ".d", immtype>;
}

class sve_int_arith_imm2<bits<2> sz8_64, bits<3> opc, string asm, string suffix>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, simm8:$imm),
  asm, "\t$Zdn"#suffix#", $_Zdn"#suffix#", $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<8> imm;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b110;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b110;
  let Inst{12-5} = imm;
  let Inst{4-0} = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_arith_imm2<bits<3> opc, string asm> {
  def _B : sve_int_arith_imm2<0b00, opc, asm, ".b">;
  def _H : sve_int_arith_imm2<0b01, opc, asm, ".h">;
  def _S : sve_int_arith_imm2<0b10, opc, asm, ".s">;
  def _D : sve_int_arith_imm2<0b11, opc, asm, ".d">;
}

class sve_int_dup_fpimm<bits<2> sz8_64, bits<3> opc, Operand fpimmtype,
                        string asm, string suffix>
: I<(outs ZPROp:$Zd), (ins fpimmtype:$imm8),
  asm, "\t$Zd"#suffix#", $imm8",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<8> imm8;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b111;
  let Inst{18-17} = opc{2-1};
  let Inst{16-14} = 0b111;
  let Inst{13}    = opc{0};
  let Inst{12-5}  = imm8;
  let Inst{4-0}   = Zd;

  let isReMaterializable = 1;
}

multiclass sve_int_dup_fpimm<bits<3> opc, string asm> {
  def _S : sve_int_dup_fpimm<0b10, opc, sve_fpimm32, asm, ".s">;
  def _D : sve_int_dup_fpimm<0b11, opc, sve_fpimm64, asm, ".d">;

  def : InstAlias<"fmov $Zd.s, $imm8",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, sve_fpimm32:$imm8), 1>;
  def : InstAlias<"fmov $Zd.d, $imm8",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, sve_fpimm64:$imm8), 1>;
}

class sve_int_dup_imm<bits<2> sz8_64, bits<2> opc, string asm, string suffix,
                      Operand immtype>
: I<(outs ZPROp:$Zd), (ins immtype:$imm),
  asm, "\t$Zd"#suffix#", $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<9> imm;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b111;
  let Inst{18-17} = opc;
  let Inst{16-14} = 0b011;
  let Inst{13}    = imm{8};   // sh
  let Inst{12-5}  = imm{7-0}; // imm8
  let Inst{4-0}   = Zd;

  let isReMaterializable = 1;
}

multiclass sve_int_dup_imm<bits<2> opc, string asm> {
  def _B : sve_int_dup_imm<0b00, opc, asm, ".b", simm8_opt_lsl_i8>;
  def _H : sve_int_dup_imm<0b01, opc, asm, ".h", simm8_opt_lsl_i16>;
  def _S : sve_int_dup_imm<0b10, opc, asm, ".s", simm8_opt_lsl_i32>;
  def _D : sve_int_dup_imm<0b11, opc, asm, ".d", simm8_opt_lsl_i64>;

  def : InstAlias<"mov $Zd.b, $imm",
                  (!cast<Instruction>(NAME # _B) ZPROp:$Zd, simm8_opt_lsl_i8:$imm), 1>;
  def : InstAlias<"mov $Zd.h, $imm",
                  (!cast<Instruction>(NAME # _H) ZPROp:$Zd, simm8_opt_lsl_i16:$imm), 1>;
  def : InstAlias<"mov $Zd.s, $imm",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, simm8_opt_lsl_i32:$imm), 1>;
  def : InstAlias<"mov $Zd.d, $imm",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, simm8_opt_lsl_i64:$imm), 1>;

  def : InstAlias<"fmov $Zd.s, $imm",
                  (!cast<Instruction>(NAME # _S) ZPROp:$Zd, sve_fpzero:$imm), 0>;
  def : InstAlias<"fmov $Zd.d, $imm",
                  (!cast<Instruction>(NAME # _D) ZPROp:$Zd, sve_fpzero_f64:$imm), 0>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Arithmetic - Unary Predicated Group
//===----------------------------------------------------------------------===//

class sve_int_un_pred_arit_0<bits<2> sz8_64, bits<3> opc, string asm,
                             string suffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$_Zd, PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Zd"#suffix#", $Pg/m, $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
}

multiclass sve_int_un_pred_arit_0<bits<3> opc, string asm,
                                  SDPatternOperator op> {
  def _B : sve_int_un_pred_arit_0<0b00, opc, asm, ".b">;
  def _H : sve_int_un_pred_arit_0<0b01, opc, asm, ".h">;
  def _S : sve_int_un_pred_arit_0<0b10, opc, asm, ".s">;
  def _D : sve_int_un_pred_arit_0<0b11, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i8, nxv16i1, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_un_pred_arit_0_h<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _H : sve_int_un_pred_arit_0<0b01, opc, asm, ".h">;
  def _S : sve_int_un_pred_arit_0<0b10, opc, asm, ".s">;
  def _D : sve_int_un_pred_arit_0<0b11, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_un_pred_arit_0_w<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _S : sve_int_un_pred_arit_0<0b10, opc, asm, ".s">;
  def _D : sve_int_un_pred_arit_0<0b11, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_un_pred_arit_0_d<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _D : sve_int_un_pred_arit_0<0b11, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_un_pred_arit_1<bits<2> sz8_64, bits<3> opc, string asm,
                             string suffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$_Zd, PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Zd"#suffix#", $Pg/m, $Zn"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
}

multiclass sve_int_un_pred_arit_1<bits<3> opc, string asm,
                                  SDPatternOperator op> {
  def _B : sve_int_un_pred_arit_1<0b00, opc, asm, ".b">;
  def _H : sve_int_un_pred_arit_1<0b01, opc, asm, ".h">;
  def _S : sve_int_un_pred_arit_1<0b10, opc, asm, ".s">;
  def _D : sve_int_un_pred_arit_1<0b11, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i8, nxv16i1, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_un_pred_arit_1_fp<bits<3> opc, string asm,
                                     SDPatternOperator op> {
  def _S : sve_int_un_pred_arit_1<0b10, opc, asm, ".s">;
  def _D : sve_int_un_pred_arit_1<0b11, opc, asm, ".d">;

  def : SVE_3_Op_Pat<nxv4f32, op, nxv4f32, nxv4i1, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2f64, nxv2i1, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Shift by Immediate - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_shift_a<bits<2> sz8_64, bits<2> opc, string asm,
                               string suffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Zd"#suffix#", $Zn"#suffix#", $Zm.d",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-12} = 0b1000;
  let Inst{11-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_bin_cons_shift_a<bits<2> opc, string asm> {
  def _B : sve_int_bin_cons_shift_a<0b00, opc, asm, ".b">;
  def _H : sve_int_bin_cons_shift_a<0b01, opc, asm, ".h">;
  def _S : sve_int_bin_cons_shift_a<0b10, opc, asm, ".s">;
}

class sve_int_bin_cons_shift_b<bits<4> tsz8_64, bits<2> opc, string asm,
                               string suffix, Operand immtype, ValueType vt,
                               SDPatternOperator op>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn, immtype:$imm),
  asm, "\t$Zd"#suffix#", $Zn"#suffix#", $imm",
  "",
  [(set (vt ZPROp:$Zd), (op (vt ZPROp:$Zn), immtype:$imm))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  bits<6> imm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = tsz8_64{3-2};
  let Inst{21}    = 0b1;
  let Inst{20-19} = tsz8_64{1-0};
  let Inst{18-16} = imm{2-0}; // imm3
  let Inst{15-12} = 0b1001;
  let Inst{11-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_bin_cons_shift_b_left<bits<2> opc, string asm,
                                         SDPatternOperator op> {
  def _B : sve_int_bin_cons_shift_b<{0,0,0,1}, opc, asm, ".b", vecshiftL8, nxv16i8, op>;
  def _H : sve_int_bin_cons_shift_b<{0,0,1,?}, opc, asm, ".h", vecshiftL16, nxv8i16, op> {
    let Inst{19} = imm{3};
  }
  def _S : sve_int_bin_cons_shift_b<{0,1,?,?}, opc, asm, ".s", vecshiftL32, nxv4i32, op> {
    let Inst{20-19} = imm{4-3};
  }
  def _D : sve_int_bin_cons_shift_b<{1,?,?,?}, opc, asm, ".d", vecshiftL64, nxv2i64, op> {
    let Inst{22}    = imm{5};
    let Inst{20-19} = imm{4-3};
  }
}

multiclass sve_int_bin_cons_shift_b_right<bits<2> opc, string asm,
                                          SDPatternOperator op> {
  def _B : sve_int_bin_cons_shift_b<{0,0,0,1}, opc, asm, ".b", vecshiftR8, nxv16i8, op>;
  def _H : sve_int_bin_cons_shift_b<{0,0,1,?}, opc, asm, ".h", vecshiftR16, nxv8i16, op> {
    let Inst{19} = imm{3};
  }
  def _S : sve_int_bin_cons_shift_b<{0,1,?,?}, opc, asm, ".s", vecshiftR32, nxv4i32, op> {
    let Inst{20-19} = imm{4-3};
  }
  def _D : sve_int_bin_cons_shift_b<{1,?,?,?}, opc, asm, ".d", vecshiftR64, nxv2i64, op> {
    let Inst{22}    = imm{5};
    let Inst{20-19} = imm{4-3};
  }
}

//===----------------------------------------------------------------------===//
// SVE Integer Compare - Scalars Group
//===----------------------------------------------------------------------===//

class sve_int_cterm<bit sz, bit opc, string asm, RegisterClass rt>
: I<(outs), (ins rt:$Rn, rt:$Rm),
  asm, "\t$Rn, $Rm",
  "",
  []>, Sched<[]> {
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-23} = 0b001001011;
  let Inst{22}    = sz;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-10} = 0b001000;
  let Inst{9-5}   = Rn;
  let Inst{4}     = opc;
  let Inst{3-0}   = 0b0000;

  let Defs = [NZCV];
}

class sve_int_while4_rr<bits<2> sz8_64, bits<3> opc, string asm, string suffix,
                        ValueType vt, SDPatternOperator op>
: I<(outs PPROp:$Pd), (ins GPR32:$Rn, GPR32:$Rm),
  asm, "\t$Pd"#suffix#", $Rn, $Rm",
  "",
  [(set (vt PPROp:$Pd), (op GPR32:$Rn, GPR32:$Rm))]>, Sched<[]> {
  bits<4> Pd;
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-12} = 0b0000;
  let Inst{11-10} = opc{2-1};
  let Inst{9-5}   = Rn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_while4_rr<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_while4_rr<0b00, opc, asm, ".b", nxv16i1, op>;
  def _H : sve_int_while4_rr<0b01, opc, asm, ".h", nxv8i1, op>;
  def _S : sve_int_while4_rr<0b10, opc, asm, ".s", nxv4i1, op>;
  def _D : sve_int_while4_rr<0b11, opc, asm, ".d", nxv2i1, op>;
}

class sve_int_while8_rr<bits<2> sz8_64, bits<3> opc, string asm, string suffix,
                        ValueType vt, SDPatternOperator op>
: I<(outs PPROp:$Pd), (ins GPR64:$Rn, GPR64:$Rm),
  asm, "\t$Pd"#suffix#", $Rn, $Rm",
  "",
  [(set (vt PPROp:$Pd), (op GPR64:$Rn, GPR64:$Rm))]>, Sched<[]> {
  bits<4> Pd;
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-12} = 0b0001;
  let Inst{11-10} = opc{2-1};
  let Inst{9-5}   = Rn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_while8_rr<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_while8_rr<0b00, opc, asm, ".b", nxv16i1, op>;
  def _H : sve_int_while8_rr<0b01, opc, asm, ".h", nxv8i1, op>;
  def _S : sve_int_while8_rr<0b10, opc, asm, ".s", nxv4i1, op>;
  def _D : sve_int_while8_rr<0b11, opc, asm, ".d", nxv2i1, op>;
}

//===----------------------------------------------------------------------===//
// SVE Memory - Store Group
//===----------------------------------------------------------------------===//

class sve_mem_cst_si<bits<2> msz, bits<2> esz, string asm,
                     RegisterOperand VecList>
: I<(outs), (ins VecList:$Zt, PPRROp:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4),
  asm, "\t$Zt, $Pg, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<4> imm4;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = msz;
  let Inst{22-21} = esz;
  let Inst{20}    = 0;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_cst_si<bits<2> msz, bits<2> esz, string asm, string suffix>
{
  def NAME : sve_mem_cst_si<msz, esz, asm, !cast<RegisterOperand>("Z_" # suffix)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $imm4, mul vl]",
                 (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), 0>;
  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) !cast<RegisterOperand>("Z_" # suffix):$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_est_si<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                     string asm, Operand immtype>
: I<(outs), (ins VecList:$Zt, PPRROp:$Pg, GPR64sp:$Rn, immtype:$imm4),
  asm, "\t$Zt, $Pg, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<4> imm4;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = sz;
  let Inst{22-21} = nregs;
  let Inst{20}    = 1;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_est_si<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                          string asm, Operand immtype> {
  def NAME : sve_mem_est_si<sz, nregs, VecList, asm, immtype>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) VecList:$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_cst_ss_base<bits<4> dtype, bit l, string asm, string suffix,
                          string mod, dag iops>
: I<(outs), iops,
  asm, "\t$Zt, $Pg, [$Rn, $Rm"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-21} = dtype;
  let Inst{20-16} = Rm;
  let Inst{15}    = 0b0;
  let Inst{14}    = l;
  let Inst{13}    = 0b0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_cst_ss<bits<4> dtype, bit l, string asm, string suffix,
                     string mod> {
  def NAME : sve_mem_cst_ss_base<dtype, l, asm, suffix, mod,
                      (ins !cast<RegisterOperand>("Z_" # suffix):$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $Rm"#mod#"]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm), 0>;
}

multiclass sve_mem_cst_ss_b<bits<4> dtype, bit l, string asm, string suffix> {
  def NAME: sve_mem_cst_ss_base<dtype, l, asm, suffix, "",
                      (ins !cast<RegisterOperand>("Z_" # suffix):$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $Rm]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm), 0>;
}

class sve_mem_est_ss_base<bits<2> sz, bits<2> nregs, dag iops, string asm,
                          string mod>
: I<(outs), iops,
  asm, "\t$Zt, $Pg, [$Rn, $Rm"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = sz;
  let Inst{22-21} = nregs;
  let Inst{20-16} = Rm;
  let Inst{15-13} = 0b011;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

class sve_mem_est_ss<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                     string asm, string mod>:
  sve_mem_est_ss_base<sz, nregs,
                      (ins VecList:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm),
                      asm, mod> {
}

class sve_mem_est_ss_b<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                       string asm>:
  sve_mem_est_ss_base<sz, nregs,
                      (ins VecList:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm),
                      asm, ""> {
}

class sve_mem_cstnt_si<bits<2> msz, string asm, RegisterOperand VecList>
: I<(outs), (ins VecList:$Zt, PPRROp:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4),
  asm, "\t$Zt, $Pg, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<4> imm4;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = msz;
  let Inst{22-20} = 0b001;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_cstnt_si<bits<2> msz, string asm, string suffix> {
  def NAME : sve_mem_cstnt_si<msz, asm, !cast<RegisterOperand>("Z_" # suffix)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $imm4, mul vl]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) !cast<RegisterOperand>("Z_" # suffix):$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_cstnt_ss_base<bits<3> opc, string asm, string mod,
                            dag iops>
: I<(outs), iops,
  asm, "\t$Zt, $Pg, [$Rn, $Rm"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = opc{2-1}; // msz
  let Inst{22-21} = 0b00;
  let Inst{20-16} = Rm;
  let Inst{15}    = 0b0;
  let Inst{14}    = opc{0};   // l
  let Inst{13}    = 0b1;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_cstnt_ss<bits<3> opc, string asm, string suffix,
                            string mod> {
  def NAME : sve_mem_cstnt_ss_base<opc, asm, mod,
                        (ins !cast<RegisterOperand>("Z_" # suffix):$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $Rm"#mod#"]",
                 (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm), 0>;
}

multiclass sve_mem_cstnt_ss_b<bits<3> opc, string asm, string suffix> {
  def NAME : sve_mem_cstnt_ss_base<opc, asm, "",
                        (ins !cast<RegisterOperand>("Z_" # suffix):$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $Rm]",
                 (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm), 0>;
}

class sve_mem_pspill<string asm>
: I<(outs), (ins PPROp:$Pt, GPR64sp:$Rn, simm9MulVl:$imm9),
  asm, "\t$Pt, [$Rn, $imm9, mul vl]",
  "",
  []>, Sched<[]> {
  bits<4> Pt;
  bits<5> Rn;
  bits<9> imm9;
  let Inst{31-22} = 0b1110010110;
  let Inst{21-16} = imm9{8-3};
  let Inst{15-13} = 0b000;
  let Inst{12-10} = imm9{2-0};
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pt;

  let mayStore = 1;
}

multiclass sve_mem_pspill<string asm> {
  def NAME : sve_mem_pspill<asm>;

  def : InstAlias<asm # "\t$Pt, [$Rn]",
                  (!cast<Instruction>(NAME) PPROp:$Pt, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_spill<string asm>
: I<(outs), (ins ZPROp:$Zt, GPR64sp:$Rn, simm9MulVl:$imm9),
  asm, "\t$Zt, [$Rn, $imm9, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Rn;
  bits<5> Zt;
  bits<9> imm9;
  let Inst{31-22} = 0b1110010110;
  let Inst{21-16} = imm9{8-3};
  let Inst{15-13} = 0b010;
  let Inst{12-10} = imm9{2-0};
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_spill<string asm> {
  def NAME : sve_mem_spill<asm>;

  def : InstAlias<asm # "\t$Zt, [$Rn]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_sst_sv<bits<3> opc, bit xs, string asm, string suffix,
                     RegisterOperand VecList, string mod>
: I<(outs), (ins VecList:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$Zt, $Pg, [$Rn, $Zm."#suffix#", "#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-22} = opc;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14}    = xs;
  let Inst{13}    = 0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_sv_32_scaled<bits<3> opc, string asm, string suffix,
                                      string scale> {
  def _UXTW_SCALED : sve_mem_sst_sv<opc, 0, asm, suffix, !cast<RegisterOperand>("Z_" # suffix), "uxtw #"#scale>;
  def _SXTW_SCALED : sve_mem_sst_sv<opc, 1, asm, suffix, !cast<RegisterOperand>("Z_" # suffix), "sxtw #"#scale>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $Zm."#suffix#", uxtw #"#scale#"]",
                 (!cast<Instruction>(NAME # _UXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $Zm."#suffix#", sxtw #"#scale#"]",
                 (!cast<Instruction>(NAME # _SXTW_SCALED) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

class sve_mem_sst_sv2<bits<2> msz, string asm, string mod>
: I<(outs), (ins Z_d:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$Zt, $Pg, [$Rn, $Zm.d, "#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = msz;
  let Inst{22-21} = 0b01;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_sv2_64_scaled<bits<2> msz, string asm, string scale> {
  def "" : sve_mem_sst_sv2<msz, asm, "lsl #"#scale>;

  def : InstAlias<asm # "\t$Zt.d, $Pg, [$Rn, $Zm.d, lsl #"#scale#"]",
                 (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;

}

class sve_mem_sst_vi<bits<3> opc, string asm, string suffix, RegisterOperand VecList, Operand imm_ty>
: I<(outs), (ins VecList:$Zt, PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5),
  asm, "\t$Zt, $Pg, [$Zn."#suffix#", $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> imm5;
  bits<5> Zn;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = opc{2-1};
  let Inst{22}    = 0b1;
  let Inst{21}    = opc{0};
  let Inst{20-16} = imm5;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_vi_ptrs<bits<3> opc, string asm, string suffix,
                               Operand imm_ty> {
  def _IMM : sve_mem_sst_vi<opc, asm, suffix, !cast<RegisterOperand>("Z_" # suffix), imm_ty>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Zn."#suffix#"]",
                  (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 0>;
  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Zn."#suffix#", $imm5]",
                  (!cast<Instruction>(NAME # _IMM) ZPROp:$Zt, PPRROp:$Pg, ZPROp:$Zn, imm_ty:$imm5), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Zn."#suffix#"]",
                  (!cast<Instruction>(NAME # _IMM) !cast<RegisterOperand>("Z_" # suffix):$Zt, PPRROp:$Pg, ZPROp:$Zn, 0), 1>;
}

class sve_mem_sst_vs<bits<3> opc, bit xs, string asm, string suffix,
                     RegisterOperand VecList, string mod>
: I<(outs), (ins VecList:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm),
  asm, "\t$Zt, $Pg, [$Rn, $Zm."#suffix#", "#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-22} = opc;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14}    = xs;
  let Inst{13}    = 0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_vs_32_unscaled<bits<3> opc, string asm, string suffix> {
  def _UXTW : sve_mem_sst_vs<opc, 0, asm, suffix, !cast<RegisterOperand>("Z_" # suffix), "uxtw">;
  def _SXTW : sve_mem_sst_vs<opc, 1, asm, suffix, !cast<RegisterOperand>("Z_" # suffix), "sxtw">;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $Zm."#suffix#", uxtw]",
                 (!cast<Instruction>(NAME # _UXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg, [$Rn, $Zm."#suffix#", sxtw]",
                 (!cast<Instruction>(NAME # _SXTW) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPRoff:$Zm), 0>;
}

class sve_mem_sst_vs2<bits<2> msz, string asm>
: I<(outs), (ins Z_d:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPROp:$Zm),
  asm, "\t$Zt, $Pg, [$Rn, $Zm.d]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = msz;
  let Inst{22-21} = 0b00;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_vs2_64_unscaled<bits<2> msz, string asm> {
  def "" : sve_mem_sst_vs2<msz, asm>;

  def : InstAlias<asm # "\t$Zt.d, $Pg, [$Rn, $Zm.d]",
                 (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, ZPROp:$Zm), 0>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Compare - Unsigned Immediate Group
//===----------------------------------------------------------------------===//

class sve_int_ucmp_vi<bits<2> sz8_64, bits<2> opc, string asm, string suffix,
                      Operand immtype>
: I<(outs PPROp:$Pd), (ins PPRROp:$Pg, ZPROp:$Zn, immtype:$imm7),
  asm, "\t$Pd"#suffix#", $Pg/z, $Zn"#suffix#", $imm7",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zn;
  bits<7> imm7;
  let Inst{31-24} = 0b00100100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 1;
  let Inst{20-14} = imm7;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_ucmp_vi<bits<2> opc, string asm, CondCode cc,
                           SDPatternOperator op = null_frag,
                           SDPatternOperator inv_op = null_frag> {
  def _B : sve_int_ucmp_vi<0b00, opc, asm, ".b", imm0_127>;
  def _H : sve_int_ucmp_vi<0b01, opc, asm, ".h", imm0_127>;
  def _S : sve_int_ucmp_vi<0b10, opc, asm, ".s", imm0_127>;
  def _D : sve_int_ucmp_vi<0b11, opc, asm, ".d", uimm7_64b>;

  // IR version
  def : Pat<(nxv16i1 (setcc (nxv16i8 ZPR:$Zs1),
                            (nxv16i8 (AArch64dup (imm0_127:$imm))),
                            cc)),
            (!cast<Instruction>(NAME # "_B") (PTRUE_B 31), ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv8i1 (setcc (nxv8i16 ZPR:$Zs1),
                           (nxv8i16 (AArch64dup (imm0_127:$imm))),
                           cc)),
            (!cast<Instruction>(NAME # "_H") (PTRUE_H 31), ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv4i1 (setcc (nxv4i32 ZPR:$Zs1),
                           (nxv4i32 (AArch64dup (imm0_127:$imm))),
                           cc)),
            (!cast<Instruction>(NAME # "_S") (PTRUE_S 31), ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv2i1 (setcc (nxv2i64 ZPR:$Zs1),
                           (nxv2i64 (AArch64dup (uimm7_64b:$imm))),
                           cc)),
            (!cast<Instruction>(NAME # "_D") (PTRUE_D 31), ZPR:$Zs1, uimm7_64b:$imm)>;

  // Intrinsic version
  def : Pat<(nxv16i1 (op (nxv16i1 PPRR:$Pg),
                         (nxv16i8 ZPR:$Zs1),
                         (nxv16i8 (AArch64dup (imm0_127:$imm))))),
            (!cast<Instruction>(NAME # "_B") PPRR:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv8i1 (op (nxv8i1 PPRR:$Pg),
                        (nxv8i16 ZPR:$Zs1),
                        (nxv8i16 (AArch64dup (imm0_127:$imm))))),
            (!cast<Instruction>(NAME # "_H") PPRR:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv4i1 (op (nxv4i1 PPRR:$Pg),
                        (nxv4i32 ZPR:$Zs1),
                        (nxv4i32 (AArch64dup (imm0_127:$imm))))),
            (!cast<Instruction>(NAME # "_S") PPRR:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv2i1 (op (nxv2i1 PPRR:$Pg),
                        (nxv2i64 ZPR:$Zs1),
                        (nxv2i64 (AArch64dup (uimm7_64b:$imm))))),
            (!cast<Instruction>(NAME # "_D") PPRR:$Pg, ZPR:$Zs1, uimm7_64b:$imm)>;

  // Inverted intrinsic version
  def : Pat<(nxv16i1 (inv_op (nxv16i1 PPRR:$Pg),
                             (nxv16i8 (AArch64dup (imm0_127:$imm))),
                             (nxv16i8 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_B") PPRR:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv8i1 (inv_op (nxv8i1 PPRR:$Pg),
                            (nxv8i16 (AArch64dup (imm0_127:$imm))),
                            (nxv8i16 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_H") PPRR:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv4i1 (inv_op (nxv4i1 PPRR:$Pg),
                            (nxv4i32 (AArch64dup (imm0_127:$imm))),
                            (nxv4i32 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_S") PPRR:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv2i1 (inv_op (nxv2i1 PPRR:$Pg),
                            (nxv2i64 (AArch64dup (uimm7_64b:$imm))),
                            (nxv2i64 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_D") PPRR:$Pg, ZPR:$Zs1, uimm7_64b:$imm)>;
}

//===----------------------------------------------------------------------===//
// SVE Permute - Predicates Group
//===----------------------------------------------------------------------===//

class sve_int_perm_bin_perm_pp<bits<3> opc, bits<2> sz8_64, string asm,
                               string suffix, ValueType vt,
                               SDPatternOperator op>
: I<(outs PPROp:$Pd), (ins PPROp:$Pn, PPROp:$Pm),
  asm, "\t$Pd"#suffix#", $Pn"#suffix#", $Pm"#suffix,
  "",
  [(set (vt PPROp:$Pd), (op (vt PPROp:$Pn), (vt PPROp:$Pm)))]>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pm;
  bits<4> Pn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-20} = 0b10;
  let Inst{19-16} = Pm;
  let Inst{15-13} = 0b010;
  let Inst{12-10} = opc;
  let Inst{9}     = 0b0;
  let Inst{8-5}   = Pn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pd;
}

multiclass sve_int_perm_bin_perm_pp<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _B : sve_int_perm_bin_perm_pp<opc, 0b00, asm, ".b", nxv16i1, op>;
  def _H : sve_int_perm_bin_perm_pp<opc, 0b01, asm, ".h", nxv8i1, op>;
  def _S : sve_int_perm_bin_perm_pp<opc, 0b10, asm, ".s", nxv4i1, op>;
  def _D : sve_int_perm_bin_perm_pp<opc, 0b11, asm, ".d", nxv2i1, op>;
}

class sve_int_perm_punpk<bit opc, string asm>
: I<(outs PPROp:$Pd), (ins PPROp:$Pn),
  asm, "\t$Pd.h, $Pn.b",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pn;
  let Inst{31-17} = 0b000001010011000;
  let Inst{16}    = opc;
  let Inst{15-9}  = 0b0100000;
  let Inst{8-5}   = Pn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pd;
}

multiclass sve_int_perm_punpk<bit opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_perm_punpk<opc, asm>;

  def : SVE_1_Op_Pat<nxv8i1, op, nxv16i1, !cast<Instruction>(NAME)>;
  def : SVE_1_Op_Pat<nxv4i1, op, nxv8i1,  !cast<Instruction>(NAME)>;
  def : SVE_1_Op_Pat<nxv2i1, op, nxv4i1,  !cast<Instruction>(NAME)>;
}

class sve_int_perm_reverse_p<bits<2> sz8_64, string asm, string suffix,
                             ValueType vt, SDPatternOperator op>
: I<(outs PPROp:$Pd), (ins PPROp:$Pn),
  asm, "\t$Pd"#suffix#", $Pn"#suffix,
  "",
  [(set PPROp:$Pd, (vt (op (vt PPROp:$Pn))))]>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-9}  = 0b1101000100000;
  let Inst{8-5}   = Pn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pd;
}

multiclass sve_int_perm_reverse_p<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_reverse_p<0b00, asm, ".b", nxv16i1, op>;
  def _H : sve_int_perm_reverse_p<0b01, asm, ".h", nxv8i1, op>;
  def _S : sve_int_perm_reverse_p<0b10, asm, ".s", nxv4i1, op>;
  def _D : sve_int_perm_reverse_p<0b11, asm, ".d", nxv2i1, op>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Fused Multiply-Add Group
//===----------------------------------------------------------------------===//

class sve_fp_3op_p_zds_a<bit sz, bits<2> opc, string asm, string suffix>
: I<(outs ZPROp:$Zda), (ins PPRROp:$Pg, ZPROp:$_Zda, ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Zda"#suffix#", $Pg/m, $Zn"#suffix#", $Zm"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zda;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = opc;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zda;

  let Constraints = "$Zda = $_Zda";
}

multiclass sve_fp_3op_p_zds_a<bits<2> opc, string asm, SDPatternOperator op> {
  def _S : sve_fp_3op_p_zds_a<0b0, opc, asm, ".s">;
  def _D : sve_fp_3op_p_zds_a<0b1, opc, asm, ".d">;

  def : SVE_4_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_4_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_fp_3op_p_zds_b<bit sz, bits<2> opc, string asm, string suffix>
: I<(outs ZPROp:$Zdn), (ins PPRROp:$Pg, ZPROp:$_Zdn, ZPROp:$Zm, ZPROp:$Za),
  asm, "\t$Zdn"#suffix#", $Pg/m, $Zm"#suffix#", $Za"#suffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Za;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Za;
  let Inst{15}    = 0b1;
  let Inst{14-13} = opc;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_fp_3op_p_zds_b<bits<2> opc, string asm, SDPatternOperator op> {
  def _S : sve_fp_3op_p_zds_b<0b0, opc, asm, ".s">;
  def _D : sve_fp_3op_p_zds_b<0b1, opc, asm, ".d">;

  def : SVE_4_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_4_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Predicate Count Group
//===----------------------------------------------------------------------===//

class sve_int_count_r<bits<2> sz8_64, bits<5> opc, string asm, string suffix,
                      RegisterOperand dstRegType, RegisterOperand srcRegType>
: I<(outs dstRegType:$Rdn), (ins PPROp:$Pg, srcRegType:$_Rdn),
  asm, "\t$Rdn, $Pg"#suffix,
  "",
  []>, Sched<[]> {
  bits<5> Rdn;
  bits<4> Pg;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b101;
  let Inst{18-16} = opc{4-2};
  let Inst{15-11} = 0b10001;
  let Inst{10-9}  = opc{1-0};
  let Inst{8-5}   = Pg;
  let Inst{4-0}   = Rdn;

  // Signed 32bit forms require their GPR operand printed.
  let AsmString = !if(!eq(opc{4,2-0}, 0b0000),
                      !strconcat(asm, "\t$Rdn, $Pg"#suffix#", $_Rdn"),
                      !strconcat(asm, "\t$Rdn, $Pg"#suffix));

  let AsmMatchConverter = !if(!eq(opc{4,2-0}, 0b00), "cvtXPredW", "");
  let Constraints = "$Rdn = $_Rdn";
}

multiclass sve_int_count_r_s32<bits<5> opc, string asm,
                               SDPatternOperator op> {
  def _B : sve_int_count_r<0b00, opc, asm, ".b", GPR64Op, GPR64as32>;
  def _H : sve_int_count_r<0b01, opc, asm, ".h", GPR64Op, GPR64as32>;
  def _S : sve_int_count_r<0b10, opc, asm, ".s", GPR64Op, GPR64as32>;
  def _D : sve_int_count_r<0b11, opc, asm, ".d", GPR64Op, GPR64as32>;

  // NOTE: Register allocation doesn't like tied operands of differing register
  //       class, hence the extra INSERT_SUBREG complication.

  def : Pat<(i32 (op GPR32:$Rn, (nxv16i1 PPROp:$Pg))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME # _B) PPROp:$Pg, (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32)), sub_32)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv8i1 PPROp:$Pg))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME # _H) PPROp:$Pg, (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32)), sub_32)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv4i1 PPROp:$Pg))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME # _S) PPROp:$Pg, (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32)), sub_32)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv2i1 PPROp:$Pg))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME # _D) PPROp:$Pg, (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32)), sub_32)>;
}

multiclass sve_int_count_r_u32<bits<5> opc, string asm,
                               SDPatternOperator op> {
  def _B : sve_int_count_r<0b00, opc, asm, ".b", GPR32Op, GPR32Op>;
  def _H : sve_int_count_r<0b01, opc, asm, ".h", GPR32Op, GPR32Op>;
  def _S : sve_int_count_r<0b10, opc, asm, ".s", GPR32Op, GPR32Op>;
  def _D : sve_int_count_r<0b11, opc, asm, ".d", GPR32Op, GPR32Op>;

  def : Pat<(i32 (op GPR32:$Rn, (nxv16i1 PPROp:$Pg))),
            (!cast<Instruction>(NAME # _B) PPROp:$Pg, $Rn)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv8i1 PPROp:$Pg))),
            (!cast<Instruction>(NAME # _H) PPROp:$Pg, $Rn)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv4i1 PPROp:$Pg))),
            (!cast<Instruction>(NAME # _S) PPROp:$Pg, $Rn)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv2i1 PPROp:$Pg))),
            (!cast<Instruction>(NAME # _D) PPROp:$Pg, $Rn)>;
}

multiclass sve_int_count_r_x64<bits<5> opc, string asm,
                               SDPatternOperator op = null_frag> {
  def _B : sve_int_count_r<0b00, opc, asm, ".b", GPR64Op, GPR64Op>;
  def _H : sve_int_count_r<0b01, opc, asm, ".h", GPR64Op, GPR64Op>;
  def _S : sve_int_count_r<0b10, opc, asm, ".s", GPR64Op, GPR64Op>;
  def _D : sve_int_count_r<0b11, opc, asm, ".d", GPR64Op, GPR64Op>;

  def : Pat<(i64 (op GPR64:$Rn, (nxv16i1 PPROp:$Pg))),
            (!cast<Instruction>(NAME # _B) PPROp:$Pg, $Rn)>;
  def : Pat<(i64 (op GPR64:$Rn, (nxv8i1 PPROp:$Pg))),
            (!cast<Instruction>(NAME # _H) PPROp:$Pg, $Rn)>;
  def : Pat<(i64 (op GPR64:$Rn, (nxv4i1 PPROp:$Pg))),
            (!cast<Instruction>(NAME # _S) PPROp:$Pg, $Rn)>;
  def : Pat<(i64 (op GPR64:$Rn, (nxv2i1 PPROp:$Pg))),
            (!cast<Instruction>(NAME # _D) PPROp:$Pg, $Rn)>;
}

class sve_int_count_v<bits<2> sz8_64, bits<5> opc, string asm, string suffix>
: I<(outs ZPROp:$Zdn), (ins ZPROp:$_Zdn, PPROp:$Pg),
  asm, "\t$Zdn"#suffix#", $Pg",
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<5> Zdn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b101;
  let Inst{18-16} = opc{4-2};
  let Inst{15-11} = 0b10000;
  let Inst{10-9}  = opc{1-0};
  let Inst{8-5}   = Pg;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
}

multiclass sve_int_count_v<bits<5> opc, string asm,
                           SDPatternOperator op = null_frag> {
  def _H : sve_int_count_v<0b01, opc, asm, ".h">;
  def _S : sve_int_count_v<0b10, opc, asm, ".s">;
  def _D : sve_int_count_v<0b11, opc, asm, ".d">;

  def : SVE_2_Op_Pat<nxv8i16, op, nxv8i16,  nxv8i1, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i32,  nxv4i1, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i64,  nxv2i1, !cast<Instruction>(NAME # _D)>;
}

class sve_int_pcount_pred<bits<2> sz8_64, bits<4> opc, string asm,
                          string suffix>
: I<(outs GPR64:$Rd), (ins PPROp:$Pg, PPROp:$Pn),
  asm, "\t$Rd, $Pg, $Pn"#suffix,
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<4> Pn;
  bits<5> Rd;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b100;
  let Inst{18-16} = opc{3-1};
  let Inst{15-14} = 0b10;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{0};
  let Inst{8-5}   = Pn;
  let Inst{4-0}   = Rd;
}

multiclass sve_int_pcount_pred<bits<4> opc, string asm,
                               SDPatternOperator int_op,
                               SDPatternOperator ir_op> {
  def _B : sve_int_pcount_pred<0b00, opc, asm, ".b">;
  def _H : sve_int_pcount_pred<0b01, opc, asm, ".h">;
  def _S : sve_int_pcount_pred<0b10, opc, asm, ".s">;
  def _D : sve_int_pcount_pred<0b11, opc, asm, ".d">;

  def : SVE_2_Op_Pat<i64, int_op, nxv16i1, nxv16i1, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<i64, int_op, nxv8i1,  nxv8i1,  !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<i64, int_op, nxv4i1,  nxv4i1,  !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<i64, int_op, nxv2i1,  nxv2i1,  !cast<Instruction>(NAME # _D)>;

  def : Pat<(i64 (ir_op (nxv16i1 PPR:$Pn))), (!cast<Instruction>(NAME # _B) (PTRUE_B 31), PPR:$Pn)>;
  def : Pat<(i64 (ir_op (nxv8i1  PPR:$Pn))), (!cast<Instruction>(NAME # _H) (PTRUE_H 31), PPR:$Pn)>;
  def : Pat<(i64 (ir_op (nxv4i1  PPR:$Pn))), (!cast<Instruction>(NAME # _S) (PTRUE_S 31), PPR:$Pn)>;
  def : Pat<(i64 (ir_op (nxv2i1  PPR:$Pn))), (!cast<Instruction>(NAME # _D) (PTRUE_D 31), PPR:$Pn)>;
}

class sve_int_setffr<string asm, SDPatternOperator op>
: I<(outs), (ins),
  asm, "",
  "",
  [(op)]>, Sched<[]> {
  let Inst{31-0} = 0b00100101001011001001000000000000;

  let hasSideEffects = 1;
  let Defs = [FFR];
}

class sve_int_wrffr<string asm, SDPatternOperator op>
: I<(outs), (ins PPROp:$Pn),
  asm, "\t$Pn.b",
  "",
  [(op (nxv16i1 PPROp:$Pn))]>, Sched<[]> {
  bits<4> Pn;
  let Inst{31-9} = 0b00100101001010001001000;
  let Inst{8-5}  = Pn;
  let Inst{4-0}  = 0b00000;

  let hasSideEffects = 1;
  let Defs = [FFR];
}

//===----------------------------------------------------------------------===//
// SVE Predicate Generation Group
//===----------------------------------------------------------------------===//

class sve_int_break<bits<6> opc, string asm, string suffix, dag iops>
: I<(outs PPROp:$Pd), iops,
  asm, "\t$Pd.b, $Pg"#suffix#", $Pn.b",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pg;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{5-4};
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc{3-1};
  let Inst{15-14} = 0b01;
  let Inst{13-10} = Pg;
  let Inst{9}     = 0;
  let Inst{8-5}   = Pn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Constraints = !if(!eq (opc{0}, 1), "$Pd = $_Pd", "");
  let Defs = !if(!eq (opc{5}, 1), [NZCV], []);

}

multiclass sve_int_break_m<bits<6> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_break<opc, asm, "/m", (ins PPROp:$_Pd, PPROp:$Pg, PPROp:$Pn)>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
}

multiclass sve_int_break_z<bits<6> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_break<opc, asm, "/z", (ins PPROp:$Pg, PPROp:$Pn)>;

  def : SVE_2_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
}


class sve_int_brkn<bits<7> opc, string asm>
: I<(outs PPROp:$Pdm), (ins PPROp:$Pg, PPROp:$Pn, PPROp:$_Pdm),
  asm, "\t$Pdm.b, $Pg/z, $Pn.b, $_Pdm.b",
  "",
  []>, Sched<[]> {
  bits<4> Pdm;
  bits<4> Pg;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{6-5};
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc{4-2};
  let Inst{15-14} = 0b01;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{1};
  let Inst{8-5}   = Pn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pdm;

  let Constraints = "$Pdm = $_Pdm";
  let Defs = !if(!eq (opc{5}, 1), [NZCV], []);
}

multiclass sve_int_brkn<bits<7> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_brkn<opc, asm>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i1,  nxv8i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i1,  nxv4i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv2i1,  op, nxv2i1,  nxv2i1,  nxv2i1,  !cast<Instruction>(NAME)>;
}

class sve_int_brkp<bits<4> opc, string asm>
: I<(outs PPROp:$Pd), (ins PPROp:$Pg, PPROp:$Pn, PPROp:$Pm),
  asm, "\t$Pd.b, $Pg/z, $Pn.b, $Pm.b",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pg;
  bits<4> Pm;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{3-2};
  let Inst{21-20} = 0b00;
  let Inst{19-16} = Pm;
  let Inst{15-14} = 0b11;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{1};
  let Inst{8-5}   = Pn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  // SEL has no predication qualifier.
  let AsmString = !if(!eq(opc, 0b0011),
                      !strconcat(asm, "\t$Pd.b, $Pg, $Pn.b, $Pm.b"),
                      !strconcat(asm, "\t$Pd.b, $Pg/z, $Pn.b, $Pm.b"));

  let Defs = !if(!eq (opc{2}, 1), [NZCV], []);
}

multiclass sve_int_brkp<bits<4> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_brkp<opc, asm>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i1,  nxv8i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i1,  nxv4i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv2i1,  op, nxv2i1,  nxv2i1,  nxv2i1,  !cast<Instruction>(NAME)>;
}

class sve_int_pfalse<bits<6> opc, string asm>
: I<(outs PPROp:$Pd), (ins),
  asm, "\t$Pd.b",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{5-4};
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc{3-1};
  let Inst{15-10} = 0b111001;
  let Inst{9}     = opc{0};
  let Inst{8-4}   = 0b00000;
  let Inst{3-0}   = Pd;
}

class sve_int_pfirst_next<bits<2> sz8_64, bits<5> opc, string asm,
                          string suffix, ValueType vt, SDPatternOperator op>
: I<(outs PPROp:$Pdn), (ins PPROp:$Pg, PPROp:$_Pdn),
  asm, "\t$Pdn"#suffix#", $Pg, $_Pdn"#suffix,
  "",
  [(set (vt PPROp:$Pdn), (op (vt PPROp:$Pg), (vt PPROp:$_Pdn)))]>, Sched<[]> {
  bits<4> Pdn;
  bits<4> Pg;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc{4-2};
  let Inst{15-11} = 0b11000;
  let Inst{10-9}  = opc{1-0};
  let Inst{8-5}   = Pg;
  let Inst{4}     = 0;
  let Inst{3-0}   = Pdn;

  let Constraints = "$Pdn = $_Pdn";
  let Defs = [NZCV];
}

multiclass sve_int_pfirst_next<bits<5> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_pfirst_next<0b00, opc, asm, ".b", nxv16i1, op>;
  def _H : sve_int_pfirst_next<0b01, opc, asm, ".h", nxv8i1, op>;
  def _S : sve_int_pfirst_next<0b10, opc, asm, ".s", nxv4i1, op>;
  def _D : sve_int_pfirst_next<0b11, opc, asm, ".d", nxv2i1, op>;
}

class sve_int_pred_log<bits<4> opc, string asm>
: I<(outs PPROp:$Pd), (ins PPROp:$Pg, PPROp:$Pn, PPROp:$Pm),
  asm, "\t$Pd.b, $Pg/z, $Pn.b, $Pm.b",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pg;
  bits<4> Pm;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{3-2};
  let Inst{21-20} = 0b00;
  let Inst{19-16} = Pm;
  let Inst{15-14} = 0b01;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{1};
  let Inst{8-5}   = Pn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  // SEL has no predication qualifier.
  let AsmString = !if(!eq(opc, 0b0011),
                      !strconcat(asm, "\t$Pd.b, $Pg, $Pn.b, $Pm.b"),
                      !strconcat(asm, "\t$Pd.b, $Pg/z, $Pn.b, $Pm.b"));

  let Defs = !if(!eq (opc{2}, 1), [NZCV], []);
}

multiclass sve_int_pred_log<bits<4> opc, string asm, SDPatternOperator op = null_frag> {
  def NAME : sve_int_pred_log<opc, asm>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i1,  nxv8i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i1,  nxv4i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv2i1,  op, nxv2i1,  nxv2i1,  nxv2i1,  !cast<Instruction>(NAME)>;
}

class sve_int_ptest<bits<6> opc, string asm>
: I<(outs), (ins PPROp:$Pg, PPROp:$Pn),
  asm, "\t$Pg, $Pn.b",
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{5-4};
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc{3-1};
  let Inst{15-14} = 0b11;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{0};
  let Inst{8-5}   = Pn;
  let Inst{4-0}   = 0b00000;

  let Defs = [NZCV];
  let isCompare = 1;
}

class sve_int_rdffr<bits<7> opc, string asm>
: I<(outs PPROp:$Pd), (ins PPROp:$Pg),
  asm, "\t$Pd.b, $Pg/z",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pg;
  let Inst{31-24} = 0b00100101;
  let Inst{23}    = opc{6};
  let Inst{22}    = opc{5};   // s
  let Inst{21-19} = 0b011;
  let Inst{18-17} = opc{4-3};
  let Inst{16-11} = 0b011110;
  let Inst{10-9}  = opc{2-1};
  let Inst{8-5}   = Pg;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = !if(!eq (opc{5}, 1), [NZCV], []);
  let Uses = [FFR];
}

class sve_int_rdffr_2<bits<6> opc, string asm> : I<
  (outs PPROp:$Pd), (ins),
  asm, "\t$Pd.b",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{5-4};
  let Inst{21-19} = 0b011;
  let Inst{18-17} = opc{3-2};
  let Inst{16-11} = 0b111110;
  let Inst{10-9}  = opc{1-0};
  let Inst{8-4}   = 0b00000;
  let Inst{3-0}   = Pd;

  let Uses = [FFR];
}

multiclass sve_int_rdffr_2<bits<6> opc, string asm, SDPatternOperator op> {
  def _REAL : sve_int_rdffr_2<opc, asm>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def "" : Pseudo<(outs PPROp:$Pd), (ins), [(set (nxv16i1 PPROp:$Pd), (op))]>;
  }
}


//===----------------------------------------------------------------------===//
// SVE Floating Point Accumulating Reduction Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_p_vd<bit sz, bits<3> opc, string asm, string suffix,
                      RegisterClass dstRegClass>
: I<(outs dstRegClass:$Vdn), (ins PPRROp:$Pg, dstRegClass:$_Vdn, ZPROp:$Zm),
  asm, "\t$Vdn, $Pg, $_Vdn, $Zm"#suffix,
  "",
  []>,
  Sched<[]> {
  bits<3> Pg;
  bits<5> Vdn;
  bits<5> Zm;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = sz;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Vdn;

  let Constraints = "$Vdn = $_Vdn";
}

multiclass sve_fp_2op_p_vd<bits<3> opc, string asm, SDPatternOperator op> {
  def _S : sve_fp_2op_p_vd<0b0, opc, asm, ".s", FPR32>;
  def _D : sve_fp_2op_p_vd<0b1, opc, asm, ".d", FPR64>;

  def : SVE_3_Op_Pat<f32, op, nxv4i1, f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<f32, op, nxv2i1, f32, nxv2f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<f64, op, nxv2i1, f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Memory - Contiguous Load Group
//===----------------------------------------------------------------------===//

class sve_mem_cld_si_base<bits<4> dtype, bit nf, string asm,
                          RegisterOperand VecList>
: I<(outs VecList:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4),
  asm, "\t$Zt, $Pg/z, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<4> imm4;
  let Inst{31-25} = 0b1010010;
  let Inst{24-21} = dtype;
  let Inst{20}    = nf;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_cld_si<bits<4> dtype, string asm, string suffix> {
  def NAME : sve_mem_cld_si_base<dtype, 0b0, asm, !cast<RegisterOperand>("Z_"#suffix)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $imm4, mul vl]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) !cast<RegisterOperand>("Z_"#suffix):$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 1>;
}

multiclass sve_mem_cld_si_nf<bits<4> dtype, string asm, string suffix> {
  def NAME : sve_mem_cld_si_base<dtype, 0b1, asm, !cast<RegisterOperand>("Z_"#suffix)> {
    let Defs = [FFR];
    let Uses = [FFR];
  }

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $imm4, mul vl]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) !cast<RegisterOperand>("Z_"#suffix):$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_eld_si<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                     string asm, Operand immtype>
: I<(outs VecList:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, immtype:$imm4),
  asm, "\t$Zt, $Pg/z, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Zt;
  bits<3> Pg;
  bits<5> Rn;
  bits<4> imm4;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = sz;
  let Inst{22-21} = nregs;
  let Inst{20}    = 0;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_eld_si<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                          string asm, Operand immtype> {
  def NAME : sve_mem_eld_si<sz, nregs, VecList, asm, immtype>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) VecList:$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_cld_ss_base<bits<4> dtype, bit ff, dag iops, string asm,
                          RegisterOperand VecList, string mod>
: I<(outs VecList:$Zt), iops,
  asm, "\t$Zt, $Pg/z, [$Rn, $Rm"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<5> Zt;
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-25} = 0b1010010;
  let Inst{24-21} = dtype;
  let Inst{20-16} = Rm;
  let Inst{15}    = 0b0;
  let Inst{14}    = 0b1; // L
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_cld_ss<bits<4> dtype, string asm, string suffix,
                          string mod> {
  def NAME : sve_mem_cld_ss_base<dtype, 0b0, (ins PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm),
                                 asm, !cast<RegisterOperand>("Z_" # suffix), mod>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $Rm"#mod#"]",
                 (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm), 0>;
}

multiclass sve_mem_cld_ss_b<bits<4> dtype, string asm, string suffix> {
  def NAME : sve_mem_cld_ss_base<dtype, 0b0, (ins PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm), asm,
                                 !cast<RegisterOperand>("Z_" # suffix), "">;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $Rm]",
                 (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm), 0>;
}

multiclass sve_mem_cld_ss_ff<bits<4> dtype, string asm, string suffix,
                             string mod> {
  let Defs = [FFR], Uses = [FFR] in {
    def NAME : sve_mem_cld_ss_base<dtype, 0b1, (ins PPRROp:$Pg, GPR64sp:$Rn, GPR64off:$Rm),
                                   asm, !cast<RegisterOperand>("Z_"#suffix), mod> ;
  }

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $Rm"#mod#"]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64off:$Rm), 0>;
}

multiclass sve_mem_cld_ss_ff_b<bits<4> dtype, string asm, string suffix> {
  let Defs = [FFR], Uses = [FFR] in {
    def NAME : sve_mem_cld_ss_base<dtype, 0b1, (ins PPRROp:$Pg, GPR64sp:$Rn, GPR64:$Rm), asm,
                                   !cast<RegisterOperand>("Z_"#suffix), "">;
  }

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $Rm]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64:$Rm), 0>;
}

class sve_mem_eld_ss_base<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                          dag iops, string asm, string mod>
: I<(outs VecList:$Zt), iops,
  asm, "\t$Zt, $Pg/z, [$Rn, $Rm"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = sz;
  let Inst{22-21} = nregs;
  let Inst{20-16} = Rm;
  let Inst{15-13} = 0b110;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

class sve_mem_eld_ss<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                     string asm, string mod>:
  sve_mem_eld_ss_base<sz, nregs, VecList,
                      (ins PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm), asm, mod> {
}

class sve_mem_eld_ss_b<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                       string asm>:
  sve_mem_eld_ss_base<sz, nregs, VecList,
                      (ins PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm), asm, ""> {
}

class sve_mem_cldnt_si_base<bits<2> msz, string asm, RegisterOperand VecList>
: I<(outs VecList:$Zt), (ins PPRROp:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4),
  asm, "\t$Zt, $Pg/z, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Zt;
  bits<3> Pg;
  bits<5> Rn;
  bits<4> imm4;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = msz;
  let Inst{22-20} = 0b000;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_cldnt_si<bits<2> msz, string asm, string suffix> {
  def NAME : sve_mem_cldnt_si_base<msz, asm, !cast<RegisterOperand>("Z_" # suffix)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $imm4, mul vl]",
                  (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) !cast<RegisterOperand>("Z_" # suffix):$Zt, PPRROp:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_cldnt_ss_base<bits<3> opc, string asm, RegisterOperand VecList,
                            string mod, dag iops>
: I<(outs VecList:$Zt), iops,
  asm, "\t$Zt, $Pg/z, [$Rn, $Rm"#mod#"]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = opc{2-1}; // msz
  let Inst{22-21} = 0b00;
  let Inst{20-16} = Rm;
  let Inst{15}    = 0b1;
  let Inst{14}    = opc{0};   // l
  let Inst{13}    = 0b0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_cldnt_ss<bits<3> opc, string asm, string suffix,
                            string mod> {
  def NAME : sve_mem_cldnt_ss_base<opc, asm, !cast<RegisterOperand>("Z_" # suffix), mod,
                                  (ins PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $Rm"#mod#"]",
                 (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64NoXZRoff:$Rm), 0>;
}

multiclass sve_mem_cldnt_ss_b<bits<3> opc, string asm, string suffix> {
  def NAME : sve_mem_cldnt_ss_base<opc, asm, !cast<RegisterOperand>("Z_" # suffix), "",
                        (ins PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm)>;

  def : InstAlias<asm # "\t$Zt."#suffix#", $Pg/z, [$Rn, $Rm]",
                 (!cast<Instruction>(NAME) ZPROp:$Zt, PPRROp:$Pg, GPR64sp:$Rn, GPR64common:$Rm), 0>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Unary Operations Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_p_zd<bits<6> opc, string asm, string iSuffix, string oSuffix>
: I<(outs ZPROp:$Zd), (ins ZPROp:$_Zd, PPRROp:$Pg, ZPROp:$Zn),
  asm, "\t$Zd"#oSuffix#", $Pg/m, $Zn"#iSuffix,
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-23} = 0b011001011;
  let Inst{22}    = opc{5};
  let Inst{21}    = 0b0;
  let Inst{20-16} = opc{4-0};
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
}

multiclass sve_fp_2op_p_zd<bits<6> opc, string asm, string iSuffix,
                           string oSuffix, SDPatternOperator op, ValueType vt1,
                           ValueType vt2, ValueType vt3> {
  def NAME : sve_fp_2op_p_zd<opc, asm, iSuffix, oSuffix>;

  def : SVE_3_Op_Pat<vt1, op, vt1, vt2, vt3, !cast<Instruction>(NAME)>;
}

multiclass sve_fp_2op_p_zd_SD<bits<5> opc, string asm, SDPatternOperator op> {
  def _S : sve_fp_2op_p_zd<{ 0, opc }, asm, ".s", ".s">;
  def _D : sve_fp_2op_p_zd<{ 1, opc }, asm, ".d", ".d">;

  def : SVE_3_Op_Pat<nxv4f32, op, nxv4f32, nxv4i1, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2f64, nxv2i1, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Logical - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_log<bits<5> opc, string asm>
: I<(outs ZPROp:$Zd), (ins ZPROp:$Zn, ZPROp:$Zm),
  asm, "\t$Zd.d, $Zn.d, $Zm.d",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{4-3};
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = opc{2-0};
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

//===----------------------------------------------------------------------===//
// SVE Integer Compare - Signed Immediate Group
//===----------------------------------------------------------------------===//

class sve_int_scmp_vi<bits<2> sz8_64, bits<3> opc, string asm, string suffix,
                      Operand immtype>
: I<(outs PPROp:$Pd), (ins PPRROp:$Pg, ZPROp:$Zn, immtype:$imm5),
  asm, "\t$Pd"#suffix#", $Pg/z, $Zn"#suffix#", $imm5",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zn;
  bits<5> imm5;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = imm5;
  let Inst{15}    = opc{2};
  let Inst{14}    = 0b0;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_scmp_vi<bits<3> opc, string asm, CondCode cc,
                           SDPatternOperator op = null_frag,
                           SDPatternOperator inv_op = null_frag> {
  def _B : sve_int_scmp_vi<0b00, opc, asm, ".b", simm5_32b>;
  def _H : sve_int_scmp_vi<0b01, opc, asm, ".h", simm5_32b>;
  def _S : sve_int_scmp_vi<0b10, opc, asm, ".s", simm5_32b>;
  def _D : sve_int_scmp_vi<0b11, opc, asm, ".d", simm5_64b>;

  // IR version
  def : Pat<(nxv16i1 (setcc (nxv16i8 ZPR:$Zs1),
                             (nxv16i8 (AArch64dup (simm5_32b:$imm))),
                             cc)),
             (!cast<Instruction>(NAME # "_B") (PTRUE_B 31), ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv8i1 (setcc (nxv8i16 ZPR:$Zs1),
                            (nxv8i16 (AArch64dup (simm5_32b:$imm))),
                            cc)),
             (!cast<Instruction>(NAME # "_H") (PTRUE_H 31), ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv4i1 (setcc (nxv4i32 ZPR:$Zs1),
                            (nxv4i32 (AArch64dup (simm5_32b:$imm))),
                            cc)),
             (!cast<Instruction>(NAME # "_S") (PTRUE_S 31), ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv2i1 (setcc (nxv2i64 ZPR:$Zs1),
                           (nxv2i64 (AArch64dup (simm5_64b:$imm))),
                           cc)),
            (!cast<Instruction>(NAME # "_D") (PTRUE_D 31), ZPR:$Zs1, simm5_64b:$imm)>;

  // Intrinsic version
  def : Pat<(nxv16i1 (op (nxv16i1 PPRR:$Pg),
                         (nxv16i8 ZPR:$Zs1),
                         (nxv16i8 (AArch64dup (simm5_32b:$imm))))),
            (!cast<Instruction>(NAME # "_B") PPRR:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv8i1 (op (nxv8i1 PPRR:$Pg),
                        (nxv8i16 ZPR:$Zs1),
                        (nxv8i16 (AArch64dup (simm5_32b:$imm))))),
            (!cast<Instruction>(NAME # "_H") PPRR:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv4i1 (op (nxv4i1 PPRR:$Pg),
                        (nxv4i32 ZPR:$Zs1),
                        (nxv4i32 (AArch64dup (simm5_32b:$imm))))),
            (!cast<Instruction>(NAME # "_S") PPRR:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv2i1 (op (nxv2i1 PPRR:$Pg),
                        (nxv2i64 ZPR:$Zs1),
                        (nxv2i64 (AArch64dup (simm5_64b:$imm))))),
            (!cast<Instruction>(NAME # "_D") PPRR:$Pg, ZPR:$Zs1, simm5_64b:$imm)>;

  // Inverted intrinsic version
  def : Pat<(nxv16i1 (inv_op (nxv16i1 PPRR:$Pg),
                             (nxv16i8 (AArch64dup (simm5_32b:$imm))),
                             (nxv16i8 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_B") PPRR:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv8i1 (inv_op (nxv8i1 PPRR:$Pg),
                            (nxv8i16 (AArch64dup (simm5_32b:$imm))),
                            (nxv8i16 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_H") PPRR:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv4i1 (inv_op (nxv4i1 PPRR:$Pg),
                            (nxv4i32 (AArch64dup (simm5_32b:$imm))),
                            (nxv4i32 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_S") PPRR:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv2i1 (inv_op (nxv2i1 PPRR:$Pg),
                            (nxv2i64 (AArch64dup (simm5_64b:$imm))),
                            (nxv2i64 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_D") PPRR:$Pg, ZPR:$Zs1, simm5_64b:$imm)>;
}
