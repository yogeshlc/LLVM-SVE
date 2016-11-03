// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64BicVVM
// Source and Destination Registers must match
bic z3.d, p6/m, z4.d, z6.d
// CHECK: error: operand must match destination register
