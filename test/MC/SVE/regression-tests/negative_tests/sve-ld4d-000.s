// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E4Load8LSSZ
// Restricted predicate has range [0, 7].
ld4d {z1.d, z2.d, z3.d, z4.d}, p8/z, [x26, x2, lsl #3]
// CHECK: error: invalid operand
