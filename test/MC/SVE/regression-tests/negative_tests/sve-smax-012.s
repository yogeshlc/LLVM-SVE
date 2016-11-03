// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MaxVIX
// Source and Destination Registers must match
smax z9.d, z10.d, #-128
// CHECK: error: operand must match destination register
