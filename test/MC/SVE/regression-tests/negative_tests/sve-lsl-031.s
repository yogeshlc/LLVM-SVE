// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShlVIM
// Source and Destination Registers must match
lsl z20.b, p4/m, z21.b, #0
// CHECK: error: operand must match destination register
