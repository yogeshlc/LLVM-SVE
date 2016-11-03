// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MinNumVVM
// Source and Destination Registers must match
fminnm z24.s, p2/m, z25.s, z26.s
// CHECK: error: operand must match destination register
