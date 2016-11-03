// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8LoadDup1SIZ
// Immediate out of lower bound [0, 63].
ld1rb z26.b, p6/z, [x24, #-1]
// CHECK: error: index must be in range [0, 63].
