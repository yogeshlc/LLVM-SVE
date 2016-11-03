// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MinNumVIM
// Source and Destination Registers must match
fminnm z12.s, p1/m, z13.s, #0.0
// CHECK: error: operand must match destination register
