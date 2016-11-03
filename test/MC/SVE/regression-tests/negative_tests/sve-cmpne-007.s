// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgNEVIZ
// Restricted predicate has range [0, 7].
cmpne p0.s, p8/z, z15.s, #-16
// CHECK: error: invalid operand
