// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF1XVSZ
// Restricted predicate has range [0, 7].
ldff1sb z27.d, p8/z, [x14, z29.d, sxtw]
// CHECK: error: invalid operand
