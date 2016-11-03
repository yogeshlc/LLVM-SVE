// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShlVVM
// Source and Destination Registers must match
lsl z9.d, p2/m, z10.d, z0.d
// CHECK: error: operand must match destination register
