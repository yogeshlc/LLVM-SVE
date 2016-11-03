// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MLAVVVM
// Restricted predicate has range [0, 7].
mla z25.d, p8/m, z24.d, z0.d
// CHECK: error: invalid operand
