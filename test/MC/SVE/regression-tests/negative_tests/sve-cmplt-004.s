// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgLTVIZ
// Immediate out of lower bound [-16, 15].
cmplt p5.s, p1/z, z16.s, #-17
// CHECK: error: index must be an integer in range [-16, 15].
