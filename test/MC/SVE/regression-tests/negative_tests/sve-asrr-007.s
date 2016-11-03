// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrRVVM
// Source and Destination Registers must match
asrr z3.b, p3/m, z4.b, z28.b
// CHECK: error: operand must match destination register
