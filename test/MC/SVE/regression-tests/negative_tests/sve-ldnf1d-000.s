// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadNF8SIZ
// Restricted predicate has range [0, 7].
ldnf1d z6.d, p8/z, [x2, #9, MUL VL]
// CHECK: error: invalid operand
