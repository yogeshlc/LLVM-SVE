// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MaxVIX
// Source and Destination Registers must match
smax z28.h, z29.h, #-128
// CHECK: error: operand must match destination register
