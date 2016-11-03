// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64IndexSI
// Immediate out of lower bound [-16, 15].
index z25.d, x7, #-17
// CHECK: error: index must be an integer in range [-16, 15].
