// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MLAVVVM
// Restricted predicate has range [0, 7].
mla z18.s, p8/m, z15.s, z25.s
// CHECK: error: invalid operand
