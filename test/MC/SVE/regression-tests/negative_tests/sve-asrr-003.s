// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrRVVM
// Source and Destination Registers must match
asrr z14.s, p4/m, z15.s, z15.s
// CHECK: error: operand must match destination register
