// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32Load2SVZ
// Restricted predicate has range [0, 7].
ld1sh z14.s, p8/z, [x16, z2.s, uxtw #1]
// CHECK: error: invalid operand
