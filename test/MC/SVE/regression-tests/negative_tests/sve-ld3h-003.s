// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E3Load2SIZ
// Immediate out of lower bound [-24, 21].
ld3h {z21.h, z22.h, z23.h}, p4/z, [x29, #-25, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
