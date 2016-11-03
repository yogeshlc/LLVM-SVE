// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load1VIZ
// Immediate out of upper bound [0, 31].
ld1b z18.s, p4/z, [z2.s, #32]
// CHECK: error: immediate must be an integer in range [0, 31].
