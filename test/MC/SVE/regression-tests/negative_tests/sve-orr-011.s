// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64OrVVM
// Source and Destination Registers must match
orr z2.d, p0/m, z3.d, z1.d
// CHECK: error: operand must match destination register
