// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32DivRVVM
// Source and Destination Registers must match
fdivr z21.s, p5/m, z22.s, z30.s
// CHECK: error: operand must match destination register
