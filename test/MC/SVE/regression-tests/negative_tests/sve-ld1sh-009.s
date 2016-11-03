// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32Load2VSZ
// Restricted predicate has range [0, 7].
ld1sh z13.s, p8/z, [x19, z4.s, uxtw]
// CHECK: error: invalid operand
