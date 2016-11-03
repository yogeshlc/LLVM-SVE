// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoad2SIZ
// Immediate out of upper bound [-8, 7].
ld1h z28.d, p1/z, [x2, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
