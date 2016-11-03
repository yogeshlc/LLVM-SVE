// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E3Load2SIZ
// Immediate out of upper bound [-24, 21].
ld3h {z28.h, z29.h, z30.h}, p6/z, [x25, #22, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
