// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgNEVIZ
// Restricted predicate has range [0, 7].
cmpne p0.d, p8/z, z16.d, #-16
// CHECK: error: invalid operand
