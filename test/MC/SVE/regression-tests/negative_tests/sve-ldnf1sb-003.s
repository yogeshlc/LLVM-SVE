// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoadNF1SIZ
// Restricted predicate has range [0, 7].
ldnf1sb z1.s, p8/z, [x9, #8, MUL VL]
// CHECK: error: invalid operand
