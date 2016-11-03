// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64IndexIS
// Immediate out of upper bound [-16, 15].
index z11.d, #16, x29
// CHECK: error: index must be an integer in range [-16, 15].
