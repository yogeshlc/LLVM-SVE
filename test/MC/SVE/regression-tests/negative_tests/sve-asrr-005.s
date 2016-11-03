// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrRVVM
// Source and Destination Registers must match
asrr z18.d, p1/m, z19.d, z23.d
// CHECK: error: operand must match destination register
