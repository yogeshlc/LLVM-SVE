// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8AddReduceV
// Restricted predicate has range [0, 7].
uaddv d14, p8, z29.b
// CHECK: error: invalid operand
