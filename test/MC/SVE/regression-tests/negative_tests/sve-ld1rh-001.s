// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16LoadDup2SIZ
// Immediate out of lower bound [0, 126].
ld1rh z13.h, p1/z, [x2, #-1]
// CHECK: error: index must be a multiple of 2 in range [0, 126].
