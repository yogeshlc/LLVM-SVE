// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MulVIX
// Immediate out of lower bound [-128, 127].
mul z29.h, z29.h, #-129
// CHECK: error: index must be an integer in range [-128, 127].
