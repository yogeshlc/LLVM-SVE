// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF2VIZ
// Immediate out of upper bound [0, 62].
ldff1sh z26.s, p0/z, [z0.s, #63]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
