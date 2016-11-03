// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShrVIM
// Source and Destination Registers must match
lsr z15.d, p5/m, z16.d, #1
// CHECK: error: operand must match destination register
