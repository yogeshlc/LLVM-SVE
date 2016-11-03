// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load2XVSZ
// Restricted predicate has range [0, 7].
ld1sh z19.d, p8/z, [x13, z22.d, sxtw]
// CHECK: error: invalid operand
