// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MinVVM
// Source and Destination Registers must match
fmin z9.s, p5/m, z10.s, z19.s
// CHECK: error: operand must match destination register
