// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load4XVSZ
// Restricted predicate has range [0, 7].
ld1sw z24.d, p8/z, [x2, z15.d, sxtw]
// CHECK: error: invalid operand
