// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FRIntIVM
// Restricted predicate has range [0, 7].
frinti z13.s, p8/m, z16.s
// CHECK: error: invalid operand
