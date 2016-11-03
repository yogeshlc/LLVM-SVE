// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgGEVWZ
// Restricted predicate has range [0, 7].
cmpge p1.b, p8/z, z1.b, z18.d
// CHECK: error: invalid operand
