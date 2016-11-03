// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64DivRVVM
// Restricted predicate has range [0, 7].
udivr z1.d, p8/m, z1.d, z8.d
// CHECK: error: invalid operand
