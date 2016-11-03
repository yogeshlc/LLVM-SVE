// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32Load1XVSZ
// Restricted predicate has range [0, 7].
ld1sb z17.s, p8/z, [x28, z13.s, sxtw]
// CHECK: error: invalid operand
