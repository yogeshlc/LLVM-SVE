// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoadNF2SIZ
// Immediate out of lower bound [-8, 7].
ldnf1sh z22.s, p5/z, [x10, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
