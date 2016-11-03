// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E2Store4SIZ
// Immediate out of lower bound [-16, 14].
st2w {z21.s, z22.s}, p1, [x17, #-17, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
