// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrRVVM
// Restricted predicate has range [0, 7].
asrr z5.s, p8/m, z5.s, z8.s
// CHECK: error: invalid operand
