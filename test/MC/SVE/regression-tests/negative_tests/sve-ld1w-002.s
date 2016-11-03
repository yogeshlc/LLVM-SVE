// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoad4SIZ
// Restricted predicate has range [0, 7].
ld1w z25.s, p8/z, [x29, #13, MUL VL]
// CHECK: error: invalid operand
