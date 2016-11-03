// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgNEVWZ
// Restricted predicate has range [0, 7].
cmpne p0.b, p8/z, z30.b, z4.d
// CHECK: error: invalid operand
