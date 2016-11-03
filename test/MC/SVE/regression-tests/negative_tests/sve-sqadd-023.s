// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8QAddVIX
// Source and Destination Registers must match
sqadd z11.b, z12.b, #0
// CHECK: error: operand must match destination register
