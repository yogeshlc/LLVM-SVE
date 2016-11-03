// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32AbdVVM
// Restricted predicate has range [0, 7].
sabd z24.s, p8/m, z24.s, z29.s
// CHECK: error: invalid operand
