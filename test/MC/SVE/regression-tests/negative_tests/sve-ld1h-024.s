// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load2VIZ
// Immediate out of lower bound [0, 62].
ld1h z29.d, p6/z, [z23.d, #-1]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
