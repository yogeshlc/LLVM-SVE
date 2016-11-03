// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MulVIX
// Immediate out of lower bound [-128, 127].
mul z2.b, z2.b, #-129
// CHECK: error: index must be an integer in range [-128, 127].
