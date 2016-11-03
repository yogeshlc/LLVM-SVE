// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32OrVVM
// Source and Destination Registers must match
orr z14.s, p5/m, z15.s, z5.s
// CHECK: error: operand must match destination register
