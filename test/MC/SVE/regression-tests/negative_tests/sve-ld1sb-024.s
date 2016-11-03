// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load1XVSZ
// Restricted predicate has range [0, 7].
ld1sb z26.d, p8/z, [x17, z3.d, sxtw]
// CHECK: error: invalid operand
