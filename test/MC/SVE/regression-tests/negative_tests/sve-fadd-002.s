// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AddVVM
// Restricted predicate has range [0, 7].
fadd z12.d, p8/m, z12.d, z22.d
// CHECK: error: invalid operand
