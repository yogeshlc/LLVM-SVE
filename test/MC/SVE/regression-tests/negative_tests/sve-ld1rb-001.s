// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16LoadDup1SIZ
// Immediate out of lower bound [0, 63].
ld1rb z16.h, p4/z, [x2, #-1]
// CHECK: error: index must be in range [0, 63].
