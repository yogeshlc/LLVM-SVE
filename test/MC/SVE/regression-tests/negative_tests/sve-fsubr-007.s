// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32SubRVVM
// Source and Destination Registers must match
fsubr z28.s, p1/m, z29.s, z25.s
// CHECK: error: operand must match destination register
