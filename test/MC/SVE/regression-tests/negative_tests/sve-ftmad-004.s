// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32TRIMADDVVI
// Immediate out of upper bound [0, 7].
ftmad z20.s, z20.s, z10.s, #8
// CHECK: error: immediate must be an integer in range [0, 7].
