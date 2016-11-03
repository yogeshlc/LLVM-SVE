// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8BicVVM
// Restricted predicate has range [0, 7].
bic z17.b, p8/m, z17.b, z8.b
// CHECK: error: invalid operand
