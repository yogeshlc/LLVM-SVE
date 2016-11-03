// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoad2SIZ
// Restricted predicate has range [0, 7].
ld1h z14.h, p8/z, [x28, #1, MUL VL]
// CHECK: error: invalid operand
