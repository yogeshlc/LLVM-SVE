// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64QAddVIX
// Source and Destination Registers must match
sqadd z28.d, z29.d, #0
// CHECK: error: operand must match destination register
