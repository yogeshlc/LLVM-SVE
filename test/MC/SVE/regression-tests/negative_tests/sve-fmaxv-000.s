// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MaxReduceFV
// Restricted predicate has range [0, 7].
fmaxv d19, p8, z17.d
// CHECK: error: invalid operand
