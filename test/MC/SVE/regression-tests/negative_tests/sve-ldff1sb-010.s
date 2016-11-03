// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF1VIZ
// Immediate out of upper bound [0, 31].
ldff1sb z19.d, p0/z, [z0.d, #32]
// CHECK: error: immediate must be an integer in range [0, 31].
