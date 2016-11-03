// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32DivVVM
// Source and Destination Registers must match
fdiv z4.s, p5/m, z5.s, z1.s
// CHECK: error: operand must match destination register
