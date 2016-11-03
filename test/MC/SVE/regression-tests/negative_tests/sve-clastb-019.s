// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64VCondXBVV
// Source and Destination Registers must match
clastb z8.d, p6, z9.d, z14.d
// CHECK: error: operand must match destination register
