// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoad2SIZ
// Immediate out of lower bound [-8, 7].
ld1h z6.h, p6/z, [x18, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
