// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64BicVVM
// Restricted predicate has range [0, 7].
bic z8.d, p8/m, z8.d, z13.d
// CHECK: error: invalid operand
