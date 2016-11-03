// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MaxVVM
// Restricted predicate has range [0, 7].
umax z2.d, p8/m, z2.d, z14.d
// CHECK: error: invalid operand
