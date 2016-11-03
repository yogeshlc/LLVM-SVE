// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64DivVVM
// Source and Destination Registers must match
sdiv z28.d, p0/m, z29.d, z11.d
// CHECK: error: operand must match destination register
