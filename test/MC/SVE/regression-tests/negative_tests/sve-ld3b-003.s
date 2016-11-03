// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E3Load1SIZ
// Immediate out of lower bound [-24, 21].
ld3b {z10.b, z11.b, z12.b}, p1/z, [x18, #-25, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
