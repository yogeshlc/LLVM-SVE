// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MinVVM
// Source and Destination Registers must match
umin z7.b, p6/m, z8.b, z10.b
// CHECK: error: operand must match destination register
