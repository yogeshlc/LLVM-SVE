// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32SubVIM
// Source and Destination Registers must match
fsub z14.s, p4/m, z15.s, #0.5
// CHECK: error: operand must match destination register
