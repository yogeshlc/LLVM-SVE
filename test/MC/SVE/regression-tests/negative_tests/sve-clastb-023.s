// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8VCondXBVV
// Source and Destination Registers must match
clastb z13.b, p2, z14.b, z9.b
// CHECK: error: operand must match destination register
