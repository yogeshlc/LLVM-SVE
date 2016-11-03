// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CondXASV
// Restricted predicate has range [0, 7].
clasta s15, p8, s15, z7.s
// CHECK: error: invalid operand
