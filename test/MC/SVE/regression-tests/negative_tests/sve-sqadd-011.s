// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32QAddVIX
// Source and Destination Registers must match
sqadd z16.s, z17.s, #0
// CHECK: error: operand must match destination register
