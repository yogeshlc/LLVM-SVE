// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MulVVM
// Source and Destination Registers must match
mul z14.b, p0/m, z15.b, z26.b
// CHECK: error: operand must match destination register
