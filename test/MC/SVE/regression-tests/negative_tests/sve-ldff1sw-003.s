// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF4VIZ
// Immediate out of lower bound [0, 124].
ldff1sw z8.d, p2/z, [z6.d, #-1]
// CHECK: error: index must be a multiple of 4 in range [0, 124].
