// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32SpliceVV
// Restricted predicate has range [0, 7].
splice z17.s, p8, z17.s, z9.s
// CHECK: error: invalid operand
