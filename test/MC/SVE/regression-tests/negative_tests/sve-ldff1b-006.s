// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadFF1XVSZ
// Restricted predicate has range [0, 7].
ldff1b z16.s, p8/z, [x11, z0.s, sxtw]
// CHECK: error: invalid operand
