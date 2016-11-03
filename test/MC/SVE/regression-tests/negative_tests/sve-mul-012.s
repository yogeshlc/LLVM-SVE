// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MulVIX
// Source and Destination Registers must match
mul z19.d, z20.d, #-128
// CHECK: error: operand must match destination register
