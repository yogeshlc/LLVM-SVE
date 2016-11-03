// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FRIntMVM
// Restricted predicate has range [0, 7].
frintm z2.s, p8/m, z27.s
// CHECK: error: invalid operand
