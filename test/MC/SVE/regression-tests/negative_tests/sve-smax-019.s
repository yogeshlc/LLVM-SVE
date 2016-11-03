// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MaxVVM
// Source and Destination Registers must match
smax z12.b, p6/m, z13.b, z25.b
// CHECK: error: operand must match destination register
