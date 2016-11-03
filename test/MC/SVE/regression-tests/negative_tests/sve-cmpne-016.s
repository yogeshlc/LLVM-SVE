// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgNEVIZ
// Restricted predicate has range [0, 7].
cmpne p9.b, p8/z, z0.b, #-16
// CHECK: error: invalid operand
