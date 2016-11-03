// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E4Load1SIZ
// Immediate out of lower bound [-32, 28].
ld4b {z3.b, z4.b, z5.b, z6.b}, p5/z, [x13, #-33, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
