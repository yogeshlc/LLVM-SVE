// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16LoadDup2SIZ
// Immediate out of upper bound [0, 126].
ld1rh z14.h, p1/z, [x1, #127]
// CHECK: error: index must be a multiple of 2 in range [0, 126].
