// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MaxReduceFV
// Restricted predicate has range [0, 7].
fmaxv s8, p8, z10.s
// CHECK: error: invalid operand
