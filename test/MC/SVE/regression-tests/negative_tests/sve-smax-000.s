// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MaxVIX
// Immediate out of lower bound [-128, 127].
smax z18.h, z18.h, #-129
// CHECK: error: index must be an integer in range [-128, 127].
