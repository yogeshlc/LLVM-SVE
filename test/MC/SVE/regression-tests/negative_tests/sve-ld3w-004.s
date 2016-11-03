// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E3Load4SIZ
// Immediate out of upper bound [-24, 21].
ld3w {z4.s, z5.s, z6.s}, p4/z, [x23, #22, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
