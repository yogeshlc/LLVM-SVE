// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E4Store4SIZ
// Immediate out of lower bound [-32, 28].
st4w {z17.s, z18.s, z19.s, z20.s}, p5, [x22, #-33, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
