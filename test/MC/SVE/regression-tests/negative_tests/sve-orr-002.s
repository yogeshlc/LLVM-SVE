// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32OrVVM
// Restricted predicate has range [0, 7].
orr z9.s, p8/m, z9.s, z29.s
// CHECK: error: invalid operand
