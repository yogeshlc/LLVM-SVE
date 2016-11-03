// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoadNF1SIZ
// Restricted predicate has range [0, 7].
ldnf1b z29.h, p8/z, [x14, #3, MUL VL]
// CHECK: error: invalid operand
