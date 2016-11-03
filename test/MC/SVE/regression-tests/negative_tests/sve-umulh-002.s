// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MulHVVM
// Restricted predicate has range [0, 7].
umulh z3.s, p8/m, z3.s, z16.s
// CHECK: error: invalid operand
