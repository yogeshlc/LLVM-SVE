// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load2YVSZ
// Restricted predicate has range [0, 7].
ld1sh z9.d, p8/z, [x3, z4.d, uxtw]
// CHECK: error: invalid operand
