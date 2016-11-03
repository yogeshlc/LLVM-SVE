// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStore1SIZ
// Restricted predicate has range [0, 7].
st1b z18.s, p8, [x1, #11, MUL VL]
// CHECK: error: invalid operand
