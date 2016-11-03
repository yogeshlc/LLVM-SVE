// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E2Store1SIZ
// Immediate out of lower bound [-16, 14].
st2b {z1.b, z2.b}, p1, [x27, #-17, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
