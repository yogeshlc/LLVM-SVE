// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF1VSZ
// Restricted predicate has range [0, 7].
ldff1sb z1.s, p8/z, [x4, z9.s, uxtw]
// CHECK: error: invalid operand
