// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load2XSVZ
// Restricted predicate has range [0, 7].
ld1sh z2.d, p8/z, [x15, z13.d, sxtw #1]
// CHECK: error: invalid operand
