// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MinReduceFV
// Restricted predicate has range [0, 7].
fminv s9, p8, z27.s
// CHECK: error: invalid operand
