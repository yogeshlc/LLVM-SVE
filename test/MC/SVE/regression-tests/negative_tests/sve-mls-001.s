// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MLSVVVM
// Restricted predicate has range [0, 7].
mls z7.s, p8/m, z2.s, z3.s
// CHECK: error: invalid operand
