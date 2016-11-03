// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16AddReduceV
// Restricted predicate has range [0, 7].
saddv d2, p8, z29.h
// CHECK: error: invalid operand
