// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShlRVVM
// Source and Destination Registers must match
lslr z18.b, p3/m, z19.b, z19.b
// CHECK: error: operand must match destination register
