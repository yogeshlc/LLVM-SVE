// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoad1SIZ
// Immediate out of upper bound [-8, 7].
ld1sb z8.s, p2/z, [x6, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
