// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MulHVVM
// Source and Destination Registers must match
smulh z8.s, p3/m, z9.s, z1.s
// CHECK: error: operand must match destination register
