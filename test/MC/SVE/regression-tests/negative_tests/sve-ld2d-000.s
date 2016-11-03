// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E2Load8LSSZ
// Restricted predicate has range [0, 7].
ld2d {z16.d, z17.d}, p8/z, [x23, x18, lsl #3]
// CHECK: error: invalid operand
