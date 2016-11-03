// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoad2SIZ
// Immediate out of lower bound [-8, 7].
ld1sh z12.d, p5/z, [x1, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
