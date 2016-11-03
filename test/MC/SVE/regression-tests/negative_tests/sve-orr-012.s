// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8OrVVM
// Restricted predicate has range [0, 7].
orr z10.b, p8/m, z10.b, z10.b
// CHECK: error: invalid operand
