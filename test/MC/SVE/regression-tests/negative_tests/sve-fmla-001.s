// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FMAVVVM
// Restricted predicate has range [0, 7].
fmla z1.s, p8/m, z13.s, z7.s
// CHECK: error: invalid operand
