// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoadNF2SIZ
// Restricted predicate has range [0, 7].
ldnf1sh z11.d, p8/z, [x17, #12, MUL VL]
// CHECK: error: invalid operand
