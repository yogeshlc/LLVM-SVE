// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CondXASV
// Restricted predicate has range [0, 7].
clasta x6, p8, x6, z6.d
// CHECK: error: invalid operand
