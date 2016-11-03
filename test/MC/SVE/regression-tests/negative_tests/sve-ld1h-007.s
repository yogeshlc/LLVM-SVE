// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoad2SIZ
// Restricted predicate has range [0, 7].
ld1h z16.s, p8/z, [x22, #8, MUL VL]
// CHECK: error: invalid operand
