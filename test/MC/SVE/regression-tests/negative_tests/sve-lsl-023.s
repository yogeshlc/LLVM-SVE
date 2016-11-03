// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShlVIM
// Source and Destination Registers must match
lsl z4.d, p6/m, z5.d, #0
// CHECK: error: operand must match destination register
