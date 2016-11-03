// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrVIM
// Source and Destination Registers must match
lsr z21.b, p1/m, z22.b, #1
// CHECK: error: operand must match destination register
