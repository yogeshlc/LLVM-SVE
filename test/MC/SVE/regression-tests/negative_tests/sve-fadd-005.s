// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32AddVIM
// Source and Destination Registers must match
fadd z10.s, p0/m, z11.s, #0.5
// CHECK: error: operand must match destination register
