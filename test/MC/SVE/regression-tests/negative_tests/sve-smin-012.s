// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MinVIX
// Source and Destination Registers must match
smin z22.d, z23.d, #-128
// CHECK: error: operand must match destination register
