// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AddVIM
// Source and Destination Registers must match
fadd z12.d, p1/m, z13.d, #0.5
// CHECK: error: operand must match destination register
