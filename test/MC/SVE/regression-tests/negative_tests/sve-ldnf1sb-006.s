// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoadNF1SIZ
// Restricted predicate has range [0, 7].
ldnf1sb z6.d, p8/z, [x16, #1, MUL VL]
// CHECK: error: invalid operand
