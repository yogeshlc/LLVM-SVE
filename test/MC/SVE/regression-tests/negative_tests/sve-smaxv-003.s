// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MaxReduceV
// Restricted predicate has range [0, 7].
smaxv b17, p8, z7.b
// CHECK: error: invalid operand
