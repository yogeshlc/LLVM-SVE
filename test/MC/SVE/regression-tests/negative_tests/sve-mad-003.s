// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MADDVVVM
// Restricted predicate has range [0, 7].
mad z15.b, p8/m, z28.b, z2.b
// CHECK: error: invalid operand
