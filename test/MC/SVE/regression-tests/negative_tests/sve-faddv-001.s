// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32AddReduceFV
// Restricted predicate has range [0, 7].
faddv s23, p8, z20.s
// CHECK: error: invalid operand
