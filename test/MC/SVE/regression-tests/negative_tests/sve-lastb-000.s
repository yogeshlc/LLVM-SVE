// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecB8LastBV
// Restricted predicate has range [0, 7].
lastb b27, p8, z13.b
// CHECK: error: invalid operand
