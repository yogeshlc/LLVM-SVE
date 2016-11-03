// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FNMAVVVM
// Restricted predicate has range [0, 7].
fnmla z22.s, p8/m, z13.s, z26.s
// CHECK: error: invalid operand
