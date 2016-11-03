// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64QAddVIX
// Source and Destination Registers must match
uqadd z9.d, z10.d, #0
// CHECK: error: operand must match destination register
