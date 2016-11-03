// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MaxReduceV
// Restricted predicate has range [0, 7].
smaxv h16, p8, z9.h
// CHECK: error: invalid operand
