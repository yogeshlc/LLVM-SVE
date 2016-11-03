// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64XorReduceV
// Restricted predicate has range [0, 7].
eorv d2, p8, z22.d
// CHECK: error: invalid operand
