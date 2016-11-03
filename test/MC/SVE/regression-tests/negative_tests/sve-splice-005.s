// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64SpliceVV
// Source and Destination Registers must match
splice z19.d, p0, z20.d, z2.d
// CHECK: error: operand must match destination register
