// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CondXBSV
// Source and Destination Registers must match
clastb w2, p1, w3, z5.b
// CHECK: error: operand must match destination register
