// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShrRVVM
// Source and Destination Registers must match
lsrr z20.h, p0/m, z21.h, z21.h
// CHECK: error: operand must match destination register
