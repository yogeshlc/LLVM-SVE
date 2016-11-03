// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E3Store2SIZ
// Immediate out of lower bound [-24, 21].
st3h {z5.h, z6.h, z7.h}, p5, [x11, #-25, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
