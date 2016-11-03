// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32VCondXBVV
// Source and Destination Registers must match
clastb z10.s, p0, z11.s, z0.s
// CHECK: error: operand must match destination register
