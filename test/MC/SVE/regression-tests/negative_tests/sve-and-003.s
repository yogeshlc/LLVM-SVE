// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32AndVVM
// Source and Destination Registers must match
and z2.s, p2/m, z3.s, z11.s
// CHECK: error: operand must match destination register
