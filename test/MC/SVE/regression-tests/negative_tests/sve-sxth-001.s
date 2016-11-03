// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Extnd28VM
// Restricted predicate has range [0, 7].
sxth z20.d, p8/m, z3.d
// CHECK: error: invalid operand
