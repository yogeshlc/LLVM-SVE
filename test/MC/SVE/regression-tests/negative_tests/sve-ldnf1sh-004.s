// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoadNF2SIZ
// Immediate out of lower bound [-8, 7].
ldnf1sh z26.d, p4/z, [x24, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
