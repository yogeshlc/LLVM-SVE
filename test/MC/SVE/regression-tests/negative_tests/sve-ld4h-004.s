// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E4Load2SIZ
// Immediate out of upper bound [-32, 28].
ld4h {z30.h, z31.h, z0.h, z1.h}, p5/z, [x9, #29, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
