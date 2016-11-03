// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShlVIM
// Source and Destination Registers must match
lsl z27.h, p2/m, z28.h, #0
// CHECK: error: operand must match destination register
