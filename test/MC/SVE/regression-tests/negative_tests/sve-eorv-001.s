// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32XorReduceV
// Restricted predicate has range [0, 7].
eorv s21, p8, z7.s
// CHECK: error: invalid operand
