// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoad1SIZ
// Restricted predicate has range [0, 7].
ld1sb z15.d, p8/z, [x10, #7, MUL VL]
// CHECK: error: invalid operand
