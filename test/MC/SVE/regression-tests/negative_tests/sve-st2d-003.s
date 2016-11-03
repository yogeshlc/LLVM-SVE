// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E2Store8SIZ
// Immediate out of lower bound [-16, 14].
st2d {z2.d, z3.d}, p0, [x19, #-17, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
