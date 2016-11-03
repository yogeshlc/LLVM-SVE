// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MulHVVM
// Source and Destination Registers must match
smulh z1.b, p2/m, z2.b, z29.b
// CHECK: error: operand must match destination register
