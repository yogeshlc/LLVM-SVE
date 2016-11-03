// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32AddReduceAV
// Restricted predicate has range [0, 7].
fadda s1, p8, s1, z6.s
// CHECK: error: invalid operand
