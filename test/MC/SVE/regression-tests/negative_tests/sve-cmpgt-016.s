// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgGTVIZ
// Restricted predicate has range [0, 7].
cmpgt p11.b, p8/z, z26.b, #-16
// CHECK: error: invalid operand
