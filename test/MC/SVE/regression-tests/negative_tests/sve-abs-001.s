// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32AbsVM
// Restricted predicate has range [0, 7].
abs z12.s, p8/m, z3.s
// CHECK: error: invalid operand
