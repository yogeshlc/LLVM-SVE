// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CLoadNF1SIZ
// Restricted predicate has range [0, 7].
ldnf1b z4.b, p8/z, [x13, #14, MUL VL]
// CHECK: error: invalid operand
