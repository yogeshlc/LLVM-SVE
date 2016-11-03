// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64ScaleVVM
// Source and Destination Registers must match
fscale z2.d, p1/m, z3.d, z12.d
// CHECK: error: operand must match destination register
