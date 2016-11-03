// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64DivVVM
// Source and Destination Registers must match
fdiv z5.d, p6/m, z6.d, z23.d
// CHECK: error: operand must match destination register
