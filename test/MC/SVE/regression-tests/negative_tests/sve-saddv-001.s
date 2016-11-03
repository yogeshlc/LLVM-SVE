// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32AddReduceV
// Restricted predicate has range [0, 7].
saddv d28, p8, z14.s
// CHECK: error: invalid operand
