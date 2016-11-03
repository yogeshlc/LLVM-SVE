// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgGTVIZ
// Immediate out of lower bound [-16, 15].
cmpgt p14.s, p5/z, z8.s, #-17
// CHECK: error: index must be an integer in range [-16, 15].
