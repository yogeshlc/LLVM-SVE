// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load2XVSZ
// Restricted predicate has range [0, 7].
ld1h z11.d, p8/z, [x24, z27.d, sxtw]
// CHECK: error: invalid operand
