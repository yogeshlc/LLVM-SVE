// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadDup2SIZ
// Immediate out of upper bound [0, 126].
ld1rsh z27.s, p3/z, [x8, #127]
// CHECK: error: index must be a multiple of 2 in range [0, 126].
