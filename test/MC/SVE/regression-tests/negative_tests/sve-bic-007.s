// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8BicVVM
// Source and Destination Registers must match
bic z18.b, p2/m, z19.b, z0.b
// CHECK: error: operand must match destination register
