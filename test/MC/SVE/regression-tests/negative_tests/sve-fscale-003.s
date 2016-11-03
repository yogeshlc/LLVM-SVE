// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32ScaleVVM
// Source and Destination Registers must match
fscale z20.s, p0/m, z21.s, z8.s
// CHECK: error: operand must match destination register
