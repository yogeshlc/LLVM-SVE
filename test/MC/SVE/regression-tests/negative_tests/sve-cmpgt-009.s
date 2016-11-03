// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgGTVWZ
// Restricted predicate has range [0, 7].
cmpgt p9.s, p8/z, z6.s, z12.d
// CHECK: error: invalid operand
