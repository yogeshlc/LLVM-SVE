// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32AddVIX
// Source and Destination Registers must match
add z4.s, z5.s, #0
// CHECK: error: operand must match destination register
