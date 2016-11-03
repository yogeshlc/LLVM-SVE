// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16OrReduceV
// Restricted predicate has range [0, 7].
orv h21, p8, z13.h
// CHECK: error: invalid operand
