// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MinVIX
// Source and Destination Registers must match
smin z2.b, z3.b, #-128
// CHECK: error: operand must match destination register
