// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MinNumReduceFV
// Restricted predicate has range [0, 7].
fminnmv d23, p8, z5.d
// CHECK: error: invalid operand
