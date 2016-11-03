// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E2Load1SIZ
// Immediate out of lower bound [-16, 14].
ld2b {z27.b, z28.b}, p1/z, [x11, #-17, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
