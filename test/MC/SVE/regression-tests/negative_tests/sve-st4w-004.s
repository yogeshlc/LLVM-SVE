// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E4Store4SIZ
// Immediate out of upper bound [-32, 28].
st4w {z4.s, z5.s, z6.s, z7.s}, p5, [x20, #29, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
