// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E3Load4SIZ
// Immediate out of lower bound [-24, 21].
ld3w {z20.s, z21.s, z22.s}, p5/z, [x17, #-25, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
