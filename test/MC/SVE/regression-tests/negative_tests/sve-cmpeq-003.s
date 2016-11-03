// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgEQVVZ
// Restricted predicate has range [0, 7].
cmpeq p9.h, p8/z, z16.h, z1.h
// CHECK: error: invalid operand
