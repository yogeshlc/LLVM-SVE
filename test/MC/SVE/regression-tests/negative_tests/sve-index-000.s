// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16IndexII
// Immediate out of lower bound [-16, 15].
index z21.h, #-17, #-16
// CHECK: error: index must be an integer in range [-16, 15].
