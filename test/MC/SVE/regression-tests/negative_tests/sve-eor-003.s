// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32XorVVM
// Source and Destination Registers must match
eor z20.s, p0/m, z21.s, z29.s
// CHECK: error: operand must match destination register
