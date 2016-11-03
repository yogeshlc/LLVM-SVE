// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MinNumReduceFV
// Restricted predicate has range [0, 7].
fminnmv s23, p8, z1.s
// CHECK: error: invalid operand
