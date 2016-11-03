// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load2VIZ
// Immediate out of lower bound [0, 62].
ld1h z7.s, p2/z, [z16.s, #-1]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
