// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8AddVVM
// Source and Destination Registers must match
add z20.b, p3/m, z21.b, z9.b
// CHECK: error: operand must match destination register
