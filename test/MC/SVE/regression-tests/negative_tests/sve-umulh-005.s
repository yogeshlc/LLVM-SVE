// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MulHVVM
// Source and Destination Registers must match
umulh z16.d, p0/m, z17.d, z26.d
// CHECK: error: operand must match destination register
