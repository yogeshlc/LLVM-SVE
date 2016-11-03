// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MaxNumVIM
// Restricted predicate has range [0, 7].
fmaxnm z24.d, p8/m, z24.d, #0.0
// CHECK: error: invalid operand
