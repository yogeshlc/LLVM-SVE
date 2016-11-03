// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgGTVVZ
// Restricted predicate has range [0, 7].
cmpgt p13.b, p8/z, z24.b, z5.b
// CHECK: error: invalid operand
