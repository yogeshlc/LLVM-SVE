// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64DivRVVM
// Restricted predicate has range [0, 7].
fdivr z5.d, p8/m, z5.d, z27.d
// CHECK: error: invalid operand
