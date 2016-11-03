// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgGEVWZ
// Restricted predicate has range [0, 7].
cmpge p2.s, p8/z, z6.s, z21.d
// CHECK: error: invalid operand
