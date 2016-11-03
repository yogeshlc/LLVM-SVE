// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64AbdVVM
// Source and Destination Registers must match
sabd z12.d, p3/m, z13.d, z10.d
// CHECK: error: operand must match destination register
