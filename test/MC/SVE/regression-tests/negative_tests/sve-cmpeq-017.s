// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgEQVVZ
// Restricted predicate has range [0, 7].
cmpeq p11.b, p8/z, z20.b, z0.b
// CHECK: error: invalid operand
