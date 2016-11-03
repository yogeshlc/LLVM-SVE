// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgNEVVZ
// Restricted predicate has range [0, 7].
cmpne p4.s, p8/z, z14.s, z22.s
// CHECK: error: invalid operand
