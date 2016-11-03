// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrRVVM
// Restricted predicate has range [0, 7].
lsrr z10.b, p8/m, z10.b, z19.b
// CHECK: error: invalid operand
