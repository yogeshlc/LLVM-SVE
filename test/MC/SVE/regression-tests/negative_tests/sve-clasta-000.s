// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecB8CondXASV
// Restricted predicate has range [0, 7].
clasta b21, p8, b21, z4.b
// CHECK: error: invalid operand
