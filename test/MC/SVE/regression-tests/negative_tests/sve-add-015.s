// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32AddVVM
// Source and Destination Registers must match
add z12.s, p6/m, z13.s, z13.s
// CHECK: error: operand must match destination register
