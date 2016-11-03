// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MinVVM
// Source and Destination Registers must match
umin z28.s, p1/m, z29.s, z1.s
// CHECK: error: operand must match destination register
