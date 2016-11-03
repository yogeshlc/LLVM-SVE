// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AddReduceAV
// Restricted predicate has range [0, 7].
fadda d16, p8, d16, z19.d
// CHECK: error: invalid operand
