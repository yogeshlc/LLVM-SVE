// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64QSubVIX
// Source and Destination Registers must match
uqsub z15.d, z16.d, #0
// CHECK: error: operand must match destination register
