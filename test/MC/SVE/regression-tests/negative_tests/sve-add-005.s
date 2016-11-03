// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16AddVIX
// Source and Destination Registers must match
add z13.h, z14.h, #0
// CHECK: error: operand must match destination register
