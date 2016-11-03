// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoadNF1SIZ
// Immediate out of lower bound [-8, 7].
ldnf1sb z24.d, p6/z, [x17, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
