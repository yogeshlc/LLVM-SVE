// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch1VI
// Immediate out of lower bound [0, 31].
prfb #15, p4, [z5.s, #-1]
// CHECK: error: immediate must be an integer in range [0, 31].
