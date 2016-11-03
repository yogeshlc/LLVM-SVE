// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShrVIM
// Source and Destination Registers must match
lsr z22.h, p3/m, z23.h, #1
// CHECK: error: operand must match destination register
