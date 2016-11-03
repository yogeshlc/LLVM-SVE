// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8AbdVVM
// Source and Destination Registers must match
sabd z16.b, p1/m, z17.b, z4.b
// CHECK: error: operand must match destination register
