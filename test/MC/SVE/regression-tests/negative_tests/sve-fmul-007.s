// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MulVVM
// Source and Destination Registers must match
fmul z24.s, p3/m, z25.s, z30.s
// CHECK: error: operand must match destination register
