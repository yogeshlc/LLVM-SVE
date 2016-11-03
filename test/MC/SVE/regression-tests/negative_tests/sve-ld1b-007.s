// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoad1SIZ
// Restricted predicate has range [0, 7].
ld1b z5.s, p8/z, [x17, #1, MUL VL]
// CHECK: error: invalid operand
