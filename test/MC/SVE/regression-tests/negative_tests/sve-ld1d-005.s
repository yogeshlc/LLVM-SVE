// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load8SVZ
// Restricted predicate has range [0, 7].
ld1d z29.d, p8/z, [x26, z29.d, lsl #3]
// CHECK: error: invalid operand
