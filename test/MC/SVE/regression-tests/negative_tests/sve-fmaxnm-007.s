// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MaxNumVVM
// Source and Destination Registers must match
fmaxnm z22.s, p2/m, z23.s, z6.s
// CHECK: error: operand must match destination register
