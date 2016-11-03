// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadNF1SIZ
// Restricted predicate has range [0, 7].
ldnf1b z18.d, p8/z, [x8, #11, MUL VL]
// CHECK: error: invalid operand
