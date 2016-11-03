// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MulVIM
// Source and Destination Registers must match
fmul z17.s, p2/m, z18.s, #0.5
// CHECK: error: operand must match destination register
