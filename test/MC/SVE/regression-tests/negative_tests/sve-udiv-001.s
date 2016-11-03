// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32DivVVM
// Source and Destination Registers must match
udiv z17.s, p4/m, z18.s, z18.s
// CHECK: error: operand must match destination register
