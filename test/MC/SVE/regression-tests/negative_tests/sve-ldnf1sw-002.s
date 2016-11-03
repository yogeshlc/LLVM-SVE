// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoadNF4SIZ
// Immediate out of upper bound [-8, 7].
ldnf1sw z0.d, p5/z, [x6, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
