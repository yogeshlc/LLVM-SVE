// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E3Store2SIZ
// Immediate out of upper bound [-24, 21].
st3h {z27.h, z28.h, z29.h}, p5, [x17, #22, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
