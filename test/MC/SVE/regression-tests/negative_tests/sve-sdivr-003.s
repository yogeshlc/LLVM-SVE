// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64DivRVVM
// Source and Destination Registers must match
sdivr z20.d, p1/m, z21.d, z25.d
// CHECK: error: operand must match destination register
