// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E4Store2SIZ
// Immediate out of upper bound [-32, 28].
st4h {z17.h, z18.h, z19.h, z20.h}, p6, [x2, #29, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
