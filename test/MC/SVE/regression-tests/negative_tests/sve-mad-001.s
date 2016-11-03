// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MADDVVVM
// Restricted predicate has range [0, 7].
mad z24.s, p8/m, z5.s, z6.s
// CHECK: error: invalid operand
