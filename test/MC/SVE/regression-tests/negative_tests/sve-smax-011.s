// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MaxVIX
// Immediate out of upper bound [-128, 127].
smax z22.d, z22.d, #128
// CHECK: error: index must be an integer in range [-128, 127].
