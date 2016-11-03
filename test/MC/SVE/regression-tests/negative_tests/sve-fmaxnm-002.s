// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MaxNumVVM
// Restricted predicate has range [0, 7].
fmaxnm z13.d, p8/m, z13.d, z10.d
// CHECK: error: invalid operand
