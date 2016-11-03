// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadNF2SIZ
// Restricted predicate has range [0, 7].
ldnf1h z9.d, p8/z, [x12, #11, MUL VL]
// CHECK: error: invalid operand
