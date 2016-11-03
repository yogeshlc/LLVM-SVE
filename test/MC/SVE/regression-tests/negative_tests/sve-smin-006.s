// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MinVIX
// Immediate out of upper bound [-128, 127].
smin z24.s, z24.s, #128
// CHECK: error: index must be an integer in range [-128, 127].
