// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load4XVSZ
// Restricted predicate has range [0, 7].
ld1w z4.s, p8/z, [x26, z4.s, sxtw]
// CHECK: error: invalid operand
