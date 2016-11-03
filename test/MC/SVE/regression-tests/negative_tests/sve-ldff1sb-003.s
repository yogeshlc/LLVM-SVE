// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF1VIZ
// Immediate out of lower bound [0, 31].
ldff1sb z3.s, p4/z, [z17.s, #-1]
// CHECK: error: immediate must be an integer in range [0, 31].
