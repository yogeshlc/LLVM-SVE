// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MulXVVM
// Source and Destination Registers must match
fmulx z27.s, p2/m, z28.s, z13.s
// CHECK: error: operand must match destination register
