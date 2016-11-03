// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF1VIZ
// Immediate out of upper bound [0, 31].
ldff1sb z25.s, p2/z, [z23.s, #32]
// CHECK: error: immediate must be an integer in range [0, 31].
