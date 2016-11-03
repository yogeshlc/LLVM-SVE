// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32SpliceVV
// Source and Destination Registers must match
splice z25.s, p0, z26.s, z7.s
// CHECK: error: operand must match destination register
