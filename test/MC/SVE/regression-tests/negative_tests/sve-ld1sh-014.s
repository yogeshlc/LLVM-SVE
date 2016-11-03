// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoad2SIZ
// Restricted predicate has range [0, 7].
ld1sh z18.d, p8/z, [x28, #2, MUL VL]
// CHECK: error: invalid operand
