// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgLTVIZ
// Immediate out of lower bound [-16, 15].
cmplt p0.d, p2/z, z2.d, #-17
// CHECK: error: index must be an integer in range [-16, 15].
