// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoadNF1SIZ
// Restricted predicate has range [0, 7].
ldnf1b z21.s, p8/z, [x7, #12, MUL VL]
// CHECK: error: invalid operand
