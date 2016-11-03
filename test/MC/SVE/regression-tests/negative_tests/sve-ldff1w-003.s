// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadFF4VIZ
// Immediate out of lower bound [0, 124].
ldff1w z19.s, p6/z, [z26.s, #-1]
// CHECK: error: index must be a multiple of 4 in range [0, 124].
