// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MaxReduceV
// Restricted predicate has range [0, 7].
umaxv b21, p8, z24.b
// CHECK: error: invalid operand
