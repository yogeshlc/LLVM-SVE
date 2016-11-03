// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MaxVVM
// Restricted predicate has range [0, 7].
smax z19.b, p8/m, z19.b, z10.b
// CHECK: error: invalid operand
