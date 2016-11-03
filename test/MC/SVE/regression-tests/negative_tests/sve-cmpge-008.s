// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgGEVVZ
// Restricted predicate has range [0, 7].
cmpge p8.s, p8/z, z26.s, z28.s
// CHECK: error: invalid operand
