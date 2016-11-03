// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32AbdVVM
// Source and Destination Registers must match
fabd z29.s, p4/m, z30.s, z14.s
// CHECK: error: operand must match destination register
