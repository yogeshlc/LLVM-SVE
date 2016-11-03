// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64XorVIX
// Source and Destination Registers must match
eor z8.d, z9.d, #254
// CHECK: error: operand must match destination register
