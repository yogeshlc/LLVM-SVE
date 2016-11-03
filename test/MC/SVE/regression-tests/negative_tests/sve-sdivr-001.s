// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32DivRVVM
// Source and Destination Registers must match
sdivr z28.s, p6/m, z29.s, z22.s
// CHECK: error: operand must match destination register
