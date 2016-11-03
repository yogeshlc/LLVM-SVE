// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8XorReduceV
// Restricted predicate has range [0, 7].
eorv b2, p8, z7.b
// CHECK: error: invalid operand
