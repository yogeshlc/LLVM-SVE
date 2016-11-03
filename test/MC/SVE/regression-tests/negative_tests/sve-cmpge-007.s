// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgGEVIZ
// Restricted predicate has range [0, 7].
cmpge p1.s, p8/z, z25.s, #-16
// CHECK: error: invalid operand
