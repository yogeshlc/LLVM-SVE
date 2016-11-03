// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MinReduceV
// Restricted predicate has range [0, 7].
sminv b29, p8, z1.b
// CHECK: error: invalid operand
