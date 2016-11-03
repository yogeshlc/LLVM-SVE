// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CondXASV
// Restricted predicate has range [0, 7].
clasta w12, p8, w12, z7.b
// CHECK: error: invalid operand
