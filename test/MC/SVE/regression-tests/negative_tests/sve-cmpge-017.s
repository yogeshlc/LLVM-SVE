// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgGEVVZ
// Restricted predicate has range [0, 7].
cmpge p0.b, p8/z, z15.b, z10.b
// CHECK: error: invalid operand
