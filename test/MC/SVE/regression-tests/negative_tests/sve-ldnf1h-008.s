// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadNF2SIZ
// Immediate out of upper bound [-8, 7].
ldnf1h z8.d, p5/z, [x30, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
