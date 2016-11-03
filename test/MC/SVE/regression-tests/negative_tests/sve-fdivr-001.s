// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64DivRVVM
// Source and Destination Registers must match
fdivr z19.d, p5/m, z20.d, z2.d
// CHECK: error: operand must match destination register
