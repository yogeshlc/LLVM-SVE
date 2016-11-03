// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MaxReduceV
// Restricted predicate has range [0, 7].
smaxv s7, p8, z11.s
// CHECK: error: invalid operand
