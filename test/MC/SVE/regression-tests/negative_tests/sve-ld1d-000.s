// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoad8LSSZ
// Restricted predicate has range [0, 7].
ld1d z17.d, p8/z, [x30, x5, lsl #3]
// CHECK: error: invalid operand
