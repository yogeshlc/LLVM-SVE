// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MinReduceV
// Restricted predicate has range [0, 7].
sminv s22, p8, z28.s
// CHECK: error: invalid operand
