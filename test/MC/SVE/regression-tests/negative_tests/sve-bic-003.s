// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32BicVVM
// Source and Destination Registers must match
bic z18.s, p2/m, z19.s, z24.s
// CHECK: error: operand must match destination register
