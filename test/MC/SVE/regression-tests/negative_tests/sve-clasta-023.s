// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8VCondXAVV
// Source and Destination Registers must match
clasta z22.b, p6, z23.b, z5.b
// CHECK: error: operand must match destination register
