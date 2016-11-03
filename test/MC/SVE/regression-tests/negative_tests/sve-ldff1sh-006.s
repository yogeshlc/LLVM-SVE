// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF2XSVZ
// Restricted predicate has range [0, 7].
ldff1sh z17.s, p8/z, [x25, z24.s, sxtw #1]
// CHECK: error: invalid operand
