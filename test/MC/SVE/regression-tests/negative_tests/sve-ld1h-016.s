// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load2XVSZ
// Restricted predicate has range [0, 7].
ld1h z25.s, p8/z, [x8, z29.s, sxtw]
// CHECK: error: invalid operand
