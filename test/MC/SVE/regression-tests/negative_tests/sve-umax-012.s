// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MaxVIX
// Source and Destination Registers must match
umax z18.d, z19.d, #0
// CHECK: error: operand must match destination register
