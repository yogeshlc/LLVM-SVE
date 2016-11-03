// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoadNF2SIZ
// Restricted predicate has range [0, 7].
ldnf1sh z28.s, p8/z, [x19, #12, MUL VL]
// CHECK: error: invalid operand
