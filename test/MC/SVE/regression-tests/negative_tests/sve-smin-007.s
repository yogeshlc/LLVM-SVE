// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MinVIX
// Source and Destination Registers must match
smin z2.s, z3.s, #-128
// CHECK: error: operand must match destination register
