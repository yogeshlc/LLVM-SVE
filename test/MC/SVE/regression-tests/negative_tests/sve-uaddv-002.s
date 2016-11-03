// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AddReduceV
// Restricted predicate has range [0, 7].
uaddv d5, p8, z7.d
// CHECK: error: invalid operand
