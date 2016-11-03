// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrDVIM
// Source and Destination Registers must match
asrd z2.s, p1/m, z3.s, #1
// CHECK: error: operand must match destination register
