// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadFF1VIZ
// Immediate out of upper bound [0, 31].
ldff1b z27.s, p0/z, [z8.s, #32]
// CHECK: error: immediate must be an integer in range [0, 31].
