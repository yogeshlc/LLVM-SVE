// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MaxVVM
// Source and Destination Registers must match
umax z5.b, p3/m, z6.b, z28.b
// CHECK: error: operand must match destination register
