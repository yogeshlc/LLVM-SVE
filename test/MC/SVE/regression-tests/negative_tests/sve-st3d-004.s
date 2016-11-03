// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E3Store8SIZ
// Immediate out of upper bound [-24, 21].
st3d {z11.d, z12.d, z13.d}, p3, [x5, #22, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
