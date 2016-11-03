// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E2Store1SIZ
// Immediate out of upper bound [-16, 14].
st2b {z1.b, z2.b}, p4, [x18, #15, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
