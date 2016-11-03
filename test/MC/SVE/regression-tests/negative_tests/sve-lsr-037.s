// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrVWM
// Source and Destination Registers must match
lsr z21.b, p4/m, z22.b, z13.d
// CHECK: error: operand must match destination register
