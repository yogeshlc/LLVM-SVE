// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgLEVIZ
// Immediate out of lower bound [-16, 15].
cmple p10.s, p3/z, z20.s, #-17
// CHECK: error: index must be an integer in range [-16, 15].
