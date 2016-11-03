// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16QAddVIX
// Source and Destination Registers must match
sqadd z4.h, z5.h, #0
// CHECK: error: operand must match destination register
