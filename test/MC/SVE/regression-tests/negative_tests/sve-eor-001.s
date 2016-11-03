// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16XorVVM
// Source and Destination Registers must match
eor z11.h, p1/m, z12.h, z14.h
// CHECK: error: operand must match destination register
