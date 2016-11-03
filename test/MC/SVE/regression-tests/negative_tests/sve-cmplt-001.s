// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgLTVIZ
// Immediate out of upper bound [-16, 15].
cmplt p3.h, p4/z, z29.h, #16
// CHECK: error: index must be an integer in range [-16, 15].
