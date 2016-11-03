// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgNEVIZ
// Immediate out of lower bound [-16, 15].
cmpne p8.s, p2/z, z11.s, #-17
// CHECK: error: index must be an integer in range [-16, 15].
