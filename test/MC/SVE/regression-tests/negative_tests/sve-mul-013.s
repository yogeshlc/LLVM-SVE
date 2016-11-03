// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MulVVM
// Restricted predicate has range [0, 7].
mul z19.d, p8/m, z19.d, z10.d
// CHECK: error: invalid operand
