// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MinVVM
// Source and Destination Registers must match
smin z9.b, p0/m, z10.b, z25.b
// CHECK: error: operand must match destination register
