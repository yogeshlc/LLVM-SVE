// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CLoad1SIZ
// Restricted predicate has range [0, 7].
ld1sb z7.h, p8/z, [x14, #11, MUL VL]
// CHECK: error: invalid operand
