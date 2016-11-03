// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CStore1SIZ
// Restricted predicate has range [0, 7].
st1b z11.b, p8, [x2, #13, MUL VL]
// CHECK: error: invalid operand
