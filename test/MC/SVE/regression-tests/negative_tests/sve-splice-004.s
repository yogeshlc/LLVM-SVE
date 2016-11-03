// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64SpliceVV
// Restricted predicate has range [0, 7].
splice z11.d, p8, z11.d, z19.d
// CHECK: error: invalid operand
