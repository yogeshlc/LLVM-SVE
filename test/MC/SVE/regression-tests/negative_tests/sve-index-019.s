// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64IndexII
// Immediate out of upper bound [-16, 15].
index z9.d, #-16, #16
// CHECK: error: index must be an integer in range [-16, 15].
