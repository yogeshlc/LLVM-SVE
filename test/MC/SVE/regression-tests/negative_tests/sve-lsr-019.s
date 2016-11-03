// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrVWM
// Source and Destination Registers must match
lsr z7.s, p6/m, z8.s, z26.d
// CHECK: error: operand must match destination register
