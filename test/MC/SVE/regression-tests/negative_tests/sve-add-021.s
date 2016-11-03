// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AddVIX
// Source and Destination Registers must match
add z5.d, z6.d, #0
// CHECK: error: operand must match destination register
