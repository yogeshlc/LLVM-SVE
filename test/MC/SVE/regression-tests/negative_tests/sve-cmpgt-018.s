// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgGTVWZ
// Restricted predicate has range [0, 7].
cmpgt p6.b, p8/z, z15.b, z13.d
// CHECK: error: invalid operand
