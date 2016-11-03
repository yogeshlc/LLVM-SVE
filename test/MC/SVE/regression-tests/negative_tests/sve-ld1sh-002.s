// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoad2SIZ
// Restricted predicate has range [0, 7].
ld1sh z3.s, p8/z, [x19, #14, MUL VL]
// CHECK: error: invalid operand
