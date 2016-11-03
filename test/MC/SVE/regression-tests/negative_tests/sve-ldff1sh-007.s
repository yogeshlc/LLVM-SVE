// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF2XVSZ
// Restricted predicate has range [0, 7].
ldff1sh z3.s, p8/z, [x2, z21.s, sxtw]
// CHECK: error: invalid operand
