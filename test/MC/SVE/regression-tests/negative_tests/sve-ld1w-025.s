// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load4YVSZ
// Restricted predicate has range [0, 7].
ld1w z1.d, p8/z, [x6, z13.d, uxtw]
// CHECK: error: invalid operand
