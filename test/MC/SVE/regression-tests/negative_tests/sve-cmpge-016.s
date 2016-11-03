// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgGEVIZ
// Restricted predicate has range [0, 7].
cmpge p6.b, p8/z, z16.b, #-16
// CHECK: error: invalid operand
