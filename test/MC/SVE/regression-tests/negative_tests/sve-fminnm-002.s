// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MinNumVVM
// Restricted predicate has range [0, 7].
fminnm z0.d, p8/m, z0.d, z3.d
// CHECK: error: invalid operand
