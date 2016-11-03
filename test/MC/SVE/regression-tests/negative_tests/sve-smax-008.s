// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MaxVVM
// Restricted predicate has range [0, 7].
smax z0.s, p8/m, z0.s, z3.s
// CHECK: error: invalid operand
