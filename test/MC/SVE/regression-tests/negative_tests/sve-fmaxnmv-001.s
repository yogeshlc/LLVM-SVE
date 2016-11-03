// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MaxNumReduceFV
// Restricted predicate has range [0, 7].
fmaxnmv s12, p8, z22.s
// CHECK: error: invalid operand
