// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8AddReduceV
// Restricted predicate has range [0, 7].
saddv d16, p8, z9.b
// CHECK: error: invalid operand
