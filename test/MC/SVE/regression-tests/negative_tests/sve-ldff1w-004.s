// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadFF4VIZ
// Immediate out of upper bound [0, 124].
ldff1w z9.s, p2/z, [z24.s, #125]
// CHECK: error: index must be a multiple of 4 in range [0, 124].
