// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrVIM
// Source and Destination Registers must match
lsr z10.s, p0/m, z11.s, #1
// CHECK: error: operand must match destination register
