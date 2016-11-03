// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load4XVSZ
// Restricted predicate has range [0, 7].
ld1w z28.d, p8/z, [x23, z18.d, sxtw]
// CHECK: error: invalid operand
