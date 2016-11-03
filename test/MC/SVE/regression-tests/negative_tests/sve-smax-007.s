// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MaxVIX
// Source and Destination Registers must match
smax z19.s, z20.s, #-128
// CHECK: error: operand must match destination register
