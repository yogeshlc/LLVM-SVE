// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShrVWM
// Source and Destination Registers must match
lsr z10.h, p0/m, z11.h, z0.d
// CHECK: error: operand must match destination register
