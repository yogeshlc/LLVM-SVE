// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E2Load4SIZ
// Immediate out of lower bound [-16, 14].
ld2w {z14.s, z15.s}, p3/z, [x1, #-17, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
