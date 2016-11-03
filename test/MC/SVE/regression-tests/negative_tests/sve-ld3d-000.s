// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E3Load8LSSZ
// Restricted predicate has range [0, 7].
ld3d {z13.d, z14.d, z15.d}, p8/z, [x4, x4, lsl #3]
// CHECK: error: invalid operand
