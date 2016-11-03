// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E4Store2SIZ
// Immediate out of lower bound [-32, 28].
st4h {z22.h, z23.h, z24.h, z25.h}, p0, [x4, #-33, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
