// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrRVVM
// Source and Destination Registers must match
lsrr z26.b, p5/m, z27.b, z2.b
// CHECK: error: operand must match destination register
