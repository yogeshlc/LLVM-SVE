// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32IndexIS
// Immediate out of lower bound [-16, 15].
index z21.s, #-17, w15
// CHECK: error: index must be an integer in range [-16, 15].
