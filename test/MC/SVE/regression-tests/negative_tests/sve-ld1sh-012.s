// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoad2LSSZ
// Restricted predicate has range [0, 7].
ld1sh z28.d, p8/z, [x10, x8, lsl #1]
// CHECK: error: invalid operand
