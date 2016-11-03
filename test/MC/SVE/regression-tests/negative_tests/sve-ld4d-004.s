// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E4Load8SIZ
// Immediate out of upper bound [-32, 28].
ld4d {z13.d, z14.d, z15.d, z16.d}, p0/z, [x20, #29, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
