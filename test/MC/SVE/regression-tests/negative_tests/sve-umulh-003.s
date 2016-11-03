// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MulHVVM
// Source and Destination Registers must match
umulh z7.s, p2/m, z8.s, z25.s
// CHECK: error: operand must match destination register
