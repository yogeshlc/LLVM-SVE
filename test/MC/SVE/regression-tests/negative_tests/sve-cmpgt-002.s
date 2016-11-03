// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgGTVIZ
// Restricted predicate has range [0, 7].
cmpgt p14.h, p8/z, z29.h, #-16
// CHECK: error: invalid operand
