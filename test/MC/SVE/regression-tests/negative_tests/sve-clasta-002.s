// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CondXASV
// Restricted predicate has range [0, 7].
clasta d15, p8, d15, z19.d
// CHECK: error: invalid operand
