// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShlRVVM
// Restricted predicate has range [0, 7].
lslr z5.d, p8/m, z5.d, z16.d
// CHECK: error: invalid operand
