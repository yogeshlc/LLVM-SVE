// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CLoadNF1SIZ
// Immediate out of upper bound [-8, 7].
ldnf1sb z26.h, p5/z, [x14, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
