// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8QAddVIX
// Source and Destination Registers must match
uqadd z0.b, z1.b, #0
// CHECK: error: operand must match destination register
