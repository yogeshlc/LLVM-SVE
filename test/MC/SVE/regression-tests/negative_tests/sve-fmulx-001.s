// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MulXVVM
// Source and Destination Registers must match
fmulx z4.d, p1/m, z5.d, z26.d
// CHECK: error: operand must match destination register
