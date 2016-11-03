// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16AddReduceV
// Restricted predicate has range [0, 7].
uaddv d29, p8, z17.h
// CHECK: error: invalid operand
