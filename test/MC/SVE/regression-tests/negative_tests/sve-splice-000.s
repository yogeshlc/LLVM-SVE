// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16SpliceVV
// Restricted predicate has range [0, 7].
splice z2.h, p8, z2.h, z10.h
// CHECK: error: invalid operand
