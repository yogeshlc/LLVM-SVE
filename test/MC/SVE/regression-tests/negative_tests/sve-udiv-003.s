// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64DivVVM
// Source and Destination Registers must match
udiv z14.d, p3/m, z15.d, z7.d
// CHECK: error: operand must match destination register
