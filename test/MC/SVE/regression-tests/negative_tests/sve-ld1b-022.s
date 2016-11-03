// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load1VIZ
// Immediate out of upper bound [0, 31].
ld1b z9.d, p2/z, [z16.d, #32]
// CHECK: error: immediate must be an integer in range [0, 31].
