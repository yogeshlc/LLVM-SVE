// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AddVVM
// Source and Destination Registers must match
fadd z29.d, p2/m, z30.d, z8.d
// CHECK: error: operand must match destination register
