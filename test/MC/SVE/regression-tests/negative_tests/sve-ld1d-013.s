// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load8YVSZ
// Restricted predicate has range [0, 7].
ld1d z2.d, p8/z, [x5, z17.d, uxtw]
// CHECK: error: invalid operand
