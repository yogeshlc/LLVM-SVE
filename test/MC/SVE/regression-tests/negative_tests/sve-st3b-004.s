// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E3Store1SIZ
// Immediate out of upper bound [-24, 21].
st3b {z23.b, z24.b, z25.b}, p0, [x5, #22, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
