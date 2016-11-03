// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrRVVM
// Restricted predicate has range [0, 7].
lsrr z29.s, p8/m, z29.s, z28.s
// CHECK: error: invalid operand
