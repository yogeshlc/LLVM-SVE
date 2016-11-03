// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32Load1VIZ
// Restricted predicate has range [0, 7].
ld1sb z27.s, p8/z, [z30.s, #20]
// CHECK: error: invalid operand
