// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoadNF2SIZ
// Restricted predicate has range [0, 7].
ldnf1h z20.s, p8/z, [x1, #10, MUL VL]
// CHECK: error: invalid operand
