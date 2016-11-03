// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoad2SIZ
// Immediate out of lower bound [-8, 7].
ld1sh z6.s, p5/z, [x20, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
