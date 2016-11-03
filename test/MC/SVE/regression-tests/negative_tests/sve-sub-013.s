// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32SubVIX
// Source and Destination Registers must match
sub z0.s, z1.s, #0
// CHECK: error: operand must match destination register
