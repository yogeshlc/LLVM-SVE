// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoad8SIZ
// Immediate out of lower bound [-8, 7].
ld1d z12.d, p3/z, [x30, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
