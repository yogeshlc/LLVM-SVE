// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgLEVIZ
// Immediate out of lower bound [-16, 15].
cmple p14.h, p6/z, z29.h, #-17
// CHECK: error: index must be an integer in range [-16, 15].
