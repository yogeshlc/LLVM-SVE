// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MulHVVM
// Source and Destination Registers must match
umulh z4.b, p1/m, z5.b, z17.b
// CHECK: error: operand must match destination register
