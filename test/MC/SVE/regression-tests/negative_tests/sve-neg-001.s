// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32NegVM
// Restricted predicate has range [0, 7].
neg z14.s, p8/m, z8.s
// CHECK: error: invalid operand
