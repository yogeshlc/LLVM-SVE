// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgNEVVZ
// Restricted predicate has range [0, 7].
cmpne p7.d, p8/z, z5.d, z30.d
// CHECK: error: invalid operand
