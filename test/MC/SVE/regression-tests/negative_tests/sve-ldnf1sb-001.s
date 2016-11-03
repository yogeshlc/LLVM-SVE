// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CLoadNF1SIZ
// Immediate out of lower bound [-8, 7].
ldnf1sb z23.h, p6/z, [x9, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
