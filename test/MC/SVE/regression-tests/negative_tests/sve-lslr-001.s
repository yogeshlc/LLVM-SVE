// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShlRVVM
// Source and Destination Registers must match
lslr z0.h, p3/m, z1.h, z13.h
// CHECK: error: operand must match destination register
