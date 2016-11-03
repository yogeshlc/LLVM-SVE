// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlVWM
// Source and Destination Registers must match
lsl z17.s, p6/m, z18.s, z24.d
// CHECK: error: operand must match destination register
