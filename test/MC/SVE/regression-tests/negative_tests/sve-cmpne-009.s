// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgNEVWZ
// Restricted predicate has range [0, 7].
cmpne p7.s, p8/z, z14.s, z5.d
// CHECK: error: invalid operand
