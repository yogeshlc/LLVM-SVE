// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8SpliceVV
// Source and Destination Registers must match
splice z22.b, p1, z23.b, z7.b
// CHECK: error: operand must match destination register
