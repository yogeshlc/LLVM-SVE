// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64SubVVM
// Restricted predicate has range [0, 7].
fsub z2.d, p8/m, z2.d, z17.d
// CHECK: error: invalid operand
