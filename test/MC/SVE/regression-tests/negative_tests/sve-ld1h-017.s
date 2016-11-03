// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoad2LSSZ
// Restricted predicate has range [0, 7].
ld1h z24.d, p8/z, [x8, x10, lsl #1]
// CHECK: error: invalid operand
