// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32Extnd24VM
// Restricted predicate has range [0, 7].
sxth z3.s, p8/m, z26.s
// CHECK: error: invalid operand
