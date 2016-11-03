// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E2Store2SIZ
// Immediate out of upper bound [-16, 14].
st2h {z16.h, z17.h}, p6, [x15, #15, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
