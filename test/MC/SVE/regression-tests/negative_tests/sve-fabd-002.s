// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32AbdVVM
// Restricted predicate has range [0, 7].
fabd z7.s, p8/m, z7.s, z23.s
// CHECK: error: invalid operand
