// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load1XVSZ
// Restricted predicate has range [0, 7].
ld1b z8.s, p8/z, [x5, z17.s, sxtw]
// CHECK: error: invalid operand
