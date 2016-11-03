// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32SubRVIM
// Source and Destination Registers must match
fsubr z28.s, p0/m, z29.s, #0.5
// CHECK: error: operand must match destination register
