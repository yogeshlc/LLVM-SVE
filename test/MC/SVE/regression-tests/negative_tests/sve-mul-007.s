// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MulVIX
// Source and Destination Registers must match
mul z26.s, z27.s, #-128
// CHECK: error: operand must match destination register
