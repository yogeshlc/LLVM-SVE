// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16XorReduceV
// Restricted predicate has range [0, 7].
eorv h15, p8, z1.h
// CHECK: error: invalid operand
