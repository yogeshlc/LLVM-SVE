// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoad4LSSZ
// Restricted predicate has range [0, 7].
ld1sw z10.d, p8/z, [x26, x4, lsl #2]
// CHECK: error: invalid operand
