// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShlRVVM
// Source and Destination Registers must match
lslr z22.d, p4/m, z23.d, z3.d
// CHECK: error: operand must match destination register
