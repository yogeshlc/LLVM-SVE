// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MaxVIX
// Source and Destination Registers must match
umax z0.s, z1.s, #0
// CHECK: error: operand must match destination register
