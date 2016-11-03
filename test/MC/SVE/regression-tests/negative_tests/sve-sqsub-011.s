// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32QSubVIX
// Source and Destination Registers must match
sqsub z11.s, z12.s, #0
// CHECK: error: operand must match destination register
