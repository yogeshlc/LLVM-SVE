// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AndReduceV
// Restricted predicate has range [0, 7].
andv d1, p8, z8.d
// CHECK: error: invalid operand
