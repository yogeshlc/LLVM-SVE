// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShrVVM
// Source and Destination Registers must match
lsr z3.d, p4/m, z4.d, z10.d
// CHECK: error: operand must match destination register
