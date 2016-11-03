// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MaxVVM
// Source and Destination Registers must match
fmax z6.s, p3/m, z7.s, z16.s
// CHECK: error: operand must match destination register
