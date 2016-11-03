// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgLEVIZ
// Immediate out of upper bound [-16, 15].
cmple p10.d, p2/z, z9.d, #16
// CHECK: error: index must be an integer in range [-16, 15].
