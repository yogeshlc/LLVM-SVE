// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgEQVIZ
// Immediate out of lower bound [-16, 15].
cmpeq p8.h, p4/z, z30.h, #-17
// CHECK: error: index must be an integer in range [-16, 15].
