// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgGTVVZ
// Restricted predicate has range [0, 7].
cmpgt p0.d, p8/z, z25.d, z7.d
// CHECK: error: invalid operand
