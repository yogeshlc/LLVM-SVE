// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MaxVIX
// Source and Destination Registers must match
umax z29.b, z30.b, #0
// CHECK: error: operand must match destination register
