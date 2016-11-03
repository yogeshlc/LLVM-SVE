// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8QSubVIX
// Source and Destination Registers must match
sqsub z7.b, z8.b, #0
// CHECK: error: operand must match destination register
