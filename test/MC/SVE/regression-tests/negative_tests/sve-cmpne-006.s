// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgNEVIZ
// Immediate out of upper bound [-16, 15].
cmpne p13.s, p2/z, z28.s, #16
// CHECK: error: index must be an integer in range [-16, 15].
