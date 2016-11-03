// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64TRIMADDVVI
// Immediate out of lower bound [0, 7].
ftmad z23.d, z23.d, z5.d, #-1
// CHECK: error: immediate must be an integer in range [0, 7].
