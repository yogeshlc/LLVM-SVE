// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load2YSVZ
// Restricted predicate has range [0, 7].
ld1sh z23.d, p8/z, [x14, z19.d, uxtw #1]
// CHECK: error: invalid operand
