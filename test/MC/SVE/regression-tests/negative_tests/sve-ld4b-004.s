// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E4Load1SIZ
// Immediate out of upper bound [-32, 28].
ld4b {z6.b, z7.b, z8.b, z9.b}, p6/z, [x20, #29, MUL VL]
// CHECK: error: index must be a multiple of 4 in range [-32, 28].
