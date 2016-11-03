// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16BicVVM
// Source and Destination Registers must match
bic z12.h, p3/m, z13.h, z29.h
// CHECK: error: operand must match destination register
