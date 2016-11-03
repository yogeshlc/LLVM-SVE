// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32SubVVM
// Source and Destination Registers must match
fsub z11.s, p2/m, z12.s, z26.s
// CHECK: error: operand must match destination register
