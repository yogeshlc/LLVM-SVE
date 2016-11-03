// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E3Store4SIZ
// Immediate out of lower bound [-24, 21].
st3w {z4.s, z5.s, z6.s}, p1, [x6, #-25, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
