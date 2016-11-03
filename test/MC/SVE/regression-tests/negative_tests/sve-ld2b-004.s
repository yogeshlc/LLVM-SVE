// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E2Load1SIZ
// Immediate out of upper bound [-16, 14].
ld2b {z16.b, z17.b}, p4/z, [x26, #15, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
