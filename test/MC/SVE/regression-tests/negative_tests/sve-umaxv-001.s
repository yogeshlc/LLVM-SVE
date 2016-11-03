// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MaxReduceV
// Restricted predicate has range [0, 7].
umaxv s18, p8, z23.s
// CHECK: error: invalid operand
