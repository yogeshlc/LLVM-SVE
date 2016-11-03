// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64TRIMADDVVI
// Immediate out of upper bound [0, 7].
ftmad z24.d, z24.d, z5.d, #8
// CHECK: error: immediate must be an integer in range [0, 7].
