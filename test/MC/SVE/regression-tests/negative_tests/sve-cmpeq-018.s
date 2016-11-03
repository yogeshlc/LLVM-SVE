// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgEQVWZ
// Restricted predicate has range [0, 7].
cmpeq p6.b, p8/z, z13.b, z22.d
// CHECK: error: invalid operand
