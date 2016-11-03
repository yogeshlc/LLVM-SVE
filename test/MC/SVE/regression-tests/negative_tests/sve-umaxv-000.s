// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MaxReduceV
// Restricted predicate has range [0, 7].
umaxv h10, p8, z4.h
// CHECK: error: invalid operand
