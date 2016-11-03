// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch1VI
// Immediate out of lower bound [0, 31].
prfb pstl2keep, p1, [z12.d, #-1]
// CHECK: error: immediate must be an integer in range [0, 31].
