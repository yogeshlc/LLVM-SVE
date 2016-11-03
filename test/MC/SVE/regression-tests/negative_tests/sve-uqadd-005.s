// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16QAddVIX
// Source and Destination Registers must match
uqadd z19.h, z20.h, #0
// CHECK: error: operand must match destination register
