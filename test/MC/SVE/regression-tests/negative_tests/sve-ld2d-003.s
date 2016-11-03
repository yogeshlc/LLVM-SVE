// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E2Load8SIZ
// Immediate out of lower bound [-16, 14].
ld2d {z13.d, z14.d}, p2/z, [x24, #-17, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
