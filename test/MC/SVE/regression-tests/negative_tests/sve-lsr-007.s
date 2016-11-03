// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShrVVM
// Source and Destination Registers must match
lsr z15.h, p1/m, z16.h, z28.h
// CHECK: error: operand must match destination register
