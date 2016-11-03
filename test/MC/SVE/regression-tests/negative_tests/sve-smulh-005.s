// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MulHVVM
// Source and Destination Registers must match
smulh z19.d, p2/m, z20.d, z14.d
// CHECK: error: operand must match destination register
