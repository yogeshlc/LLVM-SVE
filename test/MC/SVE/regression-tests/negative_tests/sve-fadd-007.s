// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32AddVVM
// Source and Destination Registers must match
fadd z17.s, p0/m, z18.s, z13.s
// CHECK: error: operand must match destination register
