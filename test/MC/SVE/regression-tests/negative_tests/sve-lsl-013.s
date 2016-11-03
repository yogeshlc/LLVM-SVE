// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlVIM
// Source and Destination Registers must match
lsl z10.s, p3/m, z11.s, #0
// CHECK: error: operand must match destination register
