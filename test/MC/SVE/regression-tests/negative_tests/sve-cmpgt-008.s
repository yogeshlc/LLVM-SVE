// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgGTVVZ
// Restricted predicate has range [0, 7].
cmpgt p7.s, p8/z, z0.s, z6.s
// CHECK: error: invalid operand
