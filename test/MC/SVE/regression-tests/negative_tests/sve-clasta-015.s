// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32VCondXAVV
// Source and Destination Registers must match
clasta z17.s, p1, z18.s, z13.s
// CHECK: error: operand must match destination register
