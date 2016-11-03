// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MaxVIM
// Source and Destination Registers must match
fmax z23.d, p0/m, z24.d, #0.0
// CHECK: error: operand must match destination register
