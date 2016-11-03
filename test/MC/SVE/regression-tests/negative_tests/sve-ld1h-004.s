// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoad2SIZ
// Immediate out of upper bound [-8, 7].
ld1h z14.h, p3/z, [x8, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
