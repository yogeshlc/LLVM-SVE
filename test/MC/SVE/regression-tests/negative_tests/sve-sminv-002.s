// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MinReduceV
// Restricted predicate has range [0, 7].
sminv d18, p8, z13.d
// CHECK: error: invalid operand
