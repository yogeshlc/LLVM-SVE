// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgGTVWZ
// Restricted predicate has range [0, 7].
cmpgt p4.h, p8/z, z12.h, z24.d
// CHECK: error: invalid operand
