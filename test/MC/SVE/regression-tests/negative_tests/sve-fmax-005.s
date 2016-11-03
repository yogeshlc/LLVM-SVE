// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MaxVIM
// Source and Destination Registers must match
fmax z28.s, p6/m, z29.s, #0.0
// CHECK: error: operand must match destination register
