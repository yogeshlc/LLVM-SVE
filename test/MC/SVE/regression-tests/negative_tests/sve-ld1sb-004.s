// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CLoad1SIZ
// Immediate out of upper bound [-8, 7].
ld1sb z1.h, p2/z, [x15, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
