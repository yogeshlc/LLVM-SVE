// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E2Store4SIZ
// Immediate out of upper bound [-16, 14].
st2w {z6.s, z7.s}, p0, [x22, #15, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
