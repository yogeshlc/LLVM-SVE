// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64XorVVM
// Source and Destination Registers must match
eor z0.d, p1/m, z1.d, z6.d
// CHECK: error: operand must match destination register
