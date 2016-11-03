// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MinVIX
// Immediate out of lower bound [-128, 127].
smin z8.h, z8.h, #-129
// CHECK: error: index must be an integer in range [-128, 127].
