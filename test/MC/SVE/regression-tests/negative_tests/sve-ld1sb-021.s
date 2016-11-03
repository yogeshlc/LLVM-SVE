// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load1VIZ
// Immediate out of lower bound [0, 31].
ld1sb z7.d, p4/z, [z18.d, #-1]
// CHECK: error: immediate must be an integer in range [0, 31].
