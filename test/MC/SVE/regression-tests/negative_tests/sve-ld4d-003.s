// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E4Load8SIZ
// Immediate out of lower bound [-32, 28].
ld4d {z0.d, z1.d, z2.d, z3.d}, p3/z, [x15, #-33, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
