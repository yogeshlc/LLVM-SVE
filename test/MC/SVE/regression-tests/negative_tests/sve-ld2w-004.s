// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E2Load4SIZ
// Immediate out of upper bound [-16, 14].
ld2w {z17.s, z18.s}, p2/z, [x26, #15, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
