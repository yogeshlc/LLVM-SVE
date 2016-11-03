// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CStore1SIZ
// Restricted predicate has range [0, 7].
st1b z4.h, p8, [x23, #13, MUL VL]
// CHECK: error: invalid operand
