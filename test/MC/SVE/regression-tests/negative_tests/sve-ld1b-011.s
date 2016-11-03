// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load1VIZ
// Immediate out of lower bound [0, 31].
ld1b z1.s, p6/z, [z7.s, #-1]
// CHECK: error: immediate must be an integer in range [0, 31].
