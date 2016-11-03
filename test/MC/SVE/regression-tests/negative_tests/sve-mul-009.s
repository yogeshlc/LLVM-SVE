// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MulVVM
// Source and Destination Registers must match
mul z26.s, p0/m, z27.s, z18.s
// CHECK: error: operand must match destination register
