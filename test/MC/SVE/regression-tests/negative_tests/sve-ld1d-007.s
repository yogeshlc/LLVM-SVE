// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load8VIZ
// Immediate out of lower bound [0, 248].
ld1d z26.d, p1/z, [z4.d, #-1]
// CHECK: error: index must be a multiple of 8 in range [0, 248].
