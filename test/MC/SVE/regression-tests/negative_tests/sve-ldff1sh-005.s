// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF2VSZ
// Restricted predicate has range [0, 7].
ldff1sh z13.s, p8/z, [x6, z7.s, uxtw]
// CHECK: error: invalid operand
