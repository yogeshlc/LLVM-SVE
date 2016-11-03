// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgEQVIZ
// Immediate out of lower bound [-16, 15].
cmpeq p4.s, p2/z, z15.s, #-17
// CHECK: error: index must be an integer in range [-16, 15].
