// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlVVM
// Source and Destination Registers must match
lsl z3.s, p5/m, z4.s, z4.s
// CHECK: error: operand must match destination register
