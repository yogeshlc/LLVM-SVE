// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoad2LSSZ
// Restricted predicate has range [0, 7].
ld1sh z13.s, p8/z, [x2, x19, lsl #1]
// CHECK: error: invalid operand
