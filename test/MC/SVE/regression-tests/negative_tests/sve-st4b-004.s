// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E4Store1SIZ
// Immediate out of upper bound [-32, 28].
st4b {z10.b, z11.b, z12.b, z13.b}, p1, [x27, #29, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
