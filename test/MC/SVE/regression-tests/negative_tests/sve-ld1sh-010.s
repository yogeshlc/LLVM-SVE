// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32Load2XSVZ
// Restricted predicate has range [0, 7].
ld1sh z15.s, p8/z, [x7, z28.s, sxtw #1]
// CHECK: error: invalid operand
