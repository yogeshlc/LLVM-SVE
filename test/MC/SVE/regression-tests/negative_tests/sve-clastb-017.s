// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CondXBSV
// Source and Destination Registers must match
clastb x7, p1, x8, z30.d
// CHECK: error: operand must match destination register
