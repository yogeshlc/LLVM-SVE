// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Rev1V
// Restricted predicate has range [0, 7].
revb z3.s, p8/m, z1.s
// CHECK: error: invalid operand
