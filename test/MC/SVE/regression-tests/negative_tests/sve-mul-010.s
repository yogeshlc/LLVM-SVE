// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MulVIX
// Immediate out of lower bound [-128, 127].
mul z26.d, z26.d, #-129
// CHECK: error: index must be an integer in range [-128, 127].
