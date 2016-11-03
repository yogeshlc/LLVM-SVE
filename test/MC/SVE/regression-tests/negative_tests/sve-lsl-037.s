// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShlVWM
// Source and Destination Registers must match
lsl z24.b, p1/m, z25.b, z5.d
// CHECK: error: operand must match destination register
