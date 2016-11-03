// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShlVWM
// Source and Destination Registers must match
lsl z21.h, p2/m, z22.h, z30.d
// CHECK: error: operand must match destination register
