// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32AndReduceV
// Restricted predicate has range [0, 7].
andv s22, p8, z13.s
// CHECK: error: invalid operand
