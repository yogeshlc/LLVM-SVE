// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MaxVVM
// Restricted predicate has range [0, 7].
smax z15.d, p8/m, z15.d, z19.d
// CHECK: error: invalid operand
