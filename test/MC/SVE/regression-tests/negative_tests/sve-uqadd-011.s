// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32QAddVIX
// Source and Destination Registers must match
uqadd z16.s, z17.s, #0
// CHECK: error: operand must match destination register
