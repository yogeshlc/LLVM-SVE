// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoad2SIZ
// Immediate out of upper bound [-8, 7].
ld1sh z18.s, p1/z, [x27, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
