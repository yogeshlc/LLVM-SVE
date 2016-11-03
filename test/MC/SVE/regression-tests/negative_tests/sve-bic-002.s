// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32BicVVM
// Restricted predicate has range [0, 7].
bic z2.s, p8/m, z2.s, z4.s
// CHECK: error: invalid operand
