// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoad1LSSZ
// Restricted predicate has range [0, 7].
ld1sb z9.s, p8/z, [x12, x30]
// CHECK: error: invalid operand
