// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E3Load1SIZ
// Immediate out of upper bound [-24, 21].
ld3b {z13.b, z14.b, z15.b}, p2/z, [x11, #22, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
