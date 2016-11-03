// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E3Store1SIZ
// Immediate out of lower bound [-24, 21].
st3b {z6.b, z7.b, z8.b}, p5, [x22, #-25, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
