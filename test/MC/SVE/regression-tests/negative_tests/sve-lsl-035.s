// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShlVVM
// Source and Destination Registers must match
lsl z28.b, p1/m, z29.b, z30.b
// CHECK: error: operand must match destination register
