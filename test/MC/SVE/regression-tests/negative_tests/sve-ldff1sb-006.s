// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF1XVSZ
// Restricted predicate has range [0, 7].
ldff1sb z24.s, p8/z, [x29, z20.s, sxtw]
// CHECK: error: invalid operand
