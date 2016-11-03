// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF2VIZ
// Immediate out of lower bound [0, 62].
ldff1sh z24.s, p4/z, [z12.s, #-1]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
