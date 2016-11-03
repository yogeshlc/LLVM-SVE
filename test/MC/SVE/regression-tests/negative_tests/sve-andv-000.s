// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16AndReduceV
// Restricted predicate has range [0, 7].
andv h6, p8, z18.h
// CHECK: error: invalid operand
