// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MaxNumVVM
// Restricted predicate has range [0, 7].
fmaxnm z28.s, p8/m, z28.s, z3.s
// CHECK: error: invalid operand
