// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgEQVVZ
// Restricted predicate has range [0, 7].
cmpeq p12.s, p8/z, z7.s, z10.s
// CHECK: error: invalid operand
