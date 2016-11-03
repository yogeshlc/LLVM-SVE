// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32AbdVVM
// Source and Destination Registers must match
sabd z1.s, p1/m, z2.s, z26.s
// CHECK: error: operand must match destination register
