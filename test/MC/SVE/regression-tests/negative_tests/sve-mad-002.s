// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MADDVVVM
// Restricted predicate has range [0, 7].
mad z0.d, p8/m, z12.d, z0.d
// CHECK: error: invalid operand
