// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64OrReduceV
// Restricted predicate has range [0, 7].
orv d18, p8, z18.d
// CHECK: error: invalid operand
