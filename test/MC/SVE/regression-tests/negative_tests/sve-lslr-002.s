// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlRVVM
// Restricted predicate has range [0, 7].
lslr z26.s, p8/m, z26.s, z13.s
// CHECK: error: invalid operand
