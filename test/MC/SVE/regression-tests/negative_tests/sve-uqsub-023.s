// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8QSubVIX
// Source and Destination Registers must match
uqsub z4.b, z5.b, #0
// CHECK: error: operand must match destination register
