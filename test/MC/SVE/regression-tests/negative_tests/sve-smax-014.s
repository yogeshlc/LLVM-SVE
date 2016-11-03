// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MaxVVM
// Source and Destination Registers must match
smax z0.d, p0/m, z1.d, z25.d
// CHECK: error: operand must match destination register
