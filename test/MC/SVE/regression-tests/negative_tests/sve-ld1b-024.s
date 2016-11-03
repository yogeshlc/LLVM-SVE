// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load1XVSZ
// Restricted predicate has range [0, 7].
ld1b z5.d, p8/z, [x1, z27.d, sxtw]
// CHECK: error: invalid operand
