// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MulHVVM
// Restricted predicate has range [0, 7].
umulh z24.d, p8/m, z24.d, z1.d
// CHECK: error: invalid operand
