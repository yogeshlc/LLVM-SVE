// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadDup4SIZ
// Immediate out of lower bound [0, 252].
ld1rsw z5.d, p3/z, [x9, #-1]
// CHECK: error: index must be a multiple of 4 in range [0, 252].
