// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32Load2VIZ
// Restricted predicate has range [0, 7].
ld1sh z11.s, p8/z, [z4.s, #1]
// CHECK: error: invalid operand
