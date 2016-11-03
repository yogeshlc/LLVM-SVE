// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlRVVM
// Source and Destination Registers must match
lslr z4.s, p5/m, z5.s, z25.s
// CHECK: error: operand must match destination register
