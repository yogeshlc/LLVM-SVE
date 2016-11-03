// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MulHVVM
// Restricted predicate has range [0, 7].
smulh z29.b, p8/m, z29.b, z13.b
// CHECK: error: invalid operand
