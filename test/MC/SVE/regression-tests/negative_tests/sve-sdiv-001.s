// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32DivVVM
// Source and Destination Registers must match
sdiv z24.s, p6/m, z25.s, z19.s
// CHECK: error: operand must match destination register
