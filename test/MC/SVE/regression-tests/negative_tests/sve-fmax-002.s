// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MaxVVM
// Restricted predicate has range [0, 7].
fmax z3.d, p8/m, z3.d, z17.d
// CHECK: error: invalid operand
