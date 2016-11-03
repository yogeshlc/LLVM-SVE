// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MLAVVVM
// Restricted predicate has range [0, 7].
mla z0.b, p8/m, z6.b, z14.b
// CHECK: error: invalid operand
