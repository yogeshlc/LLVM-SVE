// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E2Load8SIZ
// Immediate out of upper bound [-16, 14].
ld2d {z20.d, z21.d}, p2/z, [x3, #15, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
