// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32OrReduceV
// Restricted predicate has range [0, 7].
orv s13, p8, z29.s
// CHECK: error: invalid operand
