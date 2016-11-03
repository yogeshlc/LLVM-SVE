// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CStore2SIZ
// Restricted predicate has range [0, 7].
st1h z26.h, p8, [x19, #5, MUL VL]
// CHECK: error: invalid operand
