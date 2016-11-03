// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MulHVVM
// Restricted predicate has range [0, 7].
smulh z4.s, p8/m, z4.s, z9.s
// CHECK: error: invalid operand
