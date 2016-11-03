// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store4VIZ
// Immediate out of lower bound [0, 124].
st1w z29.d, p6, [z14.d, #-1]
// CHECK: error: index must be a multiple of 4 in range [0, 124].
