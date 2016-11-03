// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgEQVWZ
// Restricted predicate has range [0, 7].
cmpeq p10.s, p8/z, z28.s, z4.d
// CHECK: error: invalid operand
