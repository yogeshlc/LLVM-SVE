// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgGTVIZ
// Immediate out of lower bound [-16, 15].
cmpgt p14.h, p3/z, z14.h, #-17
// CHECK: error: index must be an integer in range [-16, 15].
