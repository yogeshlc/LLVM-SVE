// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32TRIMADDVVI
// Immediate out of lower bound [0, 7].
ftmad z28.s, z28.s, z1.s, #-1
// CHECK: error: immediate must be an integer in range [0, 7].
