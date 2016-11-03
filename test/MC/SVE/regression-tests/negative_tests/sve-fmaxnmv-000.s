// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MaxNumReduceFV
// Restricted predicate has range [0, 7].
fmaxnmv d30, p8, z19.d
// CHECK: error: invalid operand
