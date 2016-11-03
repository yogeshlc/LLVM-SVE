// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32DivRVVM
// Source and Destination Registers must match
udivr z0.s, p3/m, z1.s, z6.s
// CHECK: error: operand must match destination register
