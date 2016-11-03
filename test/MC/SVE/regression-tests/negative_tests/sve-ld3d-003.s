// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E3Load8SIZ
// Immediate out of lower bound [-24, 21].
ld3d {z16.d, z17.d, z18.d}, p2/z, [x8, #-25, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
