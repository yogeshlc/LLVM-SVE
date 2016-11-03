// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MLSVVVM
// Restricted predicate has range [0, 7].
mls z2.d, p8/m, z0.d, z26.d
// CHECK: error: invalid operand
