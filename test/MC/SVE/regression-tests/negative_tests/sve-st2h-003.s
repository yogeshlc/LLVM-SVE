// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E2Store2SIZ
// Immediate out of lower bound [-16, 14].
st2h {z30.h, z31.h}, p0, [x11, #-17, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
