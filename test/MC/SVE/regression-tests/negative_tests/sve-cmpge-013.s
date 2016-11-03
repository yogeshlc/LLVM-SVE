// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgGEVVZ
// Restricted predicate has range [0, 7].
cmpge p6.d, p8/z, z7.d, z9.d
// CHECK: error: invalid operand
