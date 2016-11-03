// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16AddVVM
// Source and Destination Registers must match
add z9.h, p6/m, z10.h, z29.h
// CHECK: error: operand must match destination register
