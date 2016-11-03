// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch1VI
// Immediate out of upper bound [0, 31].
prfb pldl3keep, p0, [z16.s, #32]
// CHECK: error: immediate must be an integer in range [0, 31].
