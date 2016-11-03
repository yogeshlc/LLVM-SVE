// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MulVIX
// Immediate out of upper bound [-128, 127].
mul z22.b, z22.b, #128
// CHECK: error: index must be an integer in range [-128, 127].
