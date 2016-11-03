// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrRVVM
// Source and Destination Registers must match
lsrr z15.s, p4/m, z16.s, z18.s
// CHECK: error: operand must match destination register
