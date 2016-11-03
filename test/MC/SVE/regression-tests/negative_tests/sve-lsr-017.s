// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrVVM
// Source and Destination Registers must match
lsr z21.s, p3/m, z22.s, z16.s
// CHECK: error: operand must match destination register
