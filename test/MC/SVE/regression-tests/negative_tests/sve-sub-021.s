// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64SubVIX
// Source and Destination Registers must match
sub z12.d, z13.d, #0
// CHECK: error: operand must match destination register
