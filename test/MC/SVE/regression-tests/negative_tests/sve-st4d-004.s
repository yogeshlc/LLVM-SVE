// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E4Store8SIZ
// Immediate out of upper bound [-32, 28].
st4d {z11.d, z12.d, z13.d, z14.d}, p2, [x16, #29, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
