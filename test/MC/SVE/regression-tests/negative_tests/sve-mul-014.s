// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MulVVM
// Source and Destination Registers must match
mul z28.d, p6/m, z29.d, z21.d
// CHECK: error: operand must match destination register
