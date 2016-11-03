// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF2SVZ
// Restricted predicate has range [0, 7].
ldff1sh z3.d, p8/z, [x19, z14.d, lsl #1]
// CHECK: error: invalid operand
