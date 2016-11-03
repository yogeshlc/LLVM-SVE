// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MulVVM
// Restricted predicate has range [0, 7].
mul z16.b, p8/m, z16.b, z8.b
// CHECK: error: invalid operand
