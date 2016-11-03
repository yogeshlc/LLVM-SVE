// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadDup8SIZ
// Immediate out of lower bound [0, 504].
ld1rd z19.d, p3/z, [x7, #-1]
// CHECK: error: index must be a multiple of 8 in range [0, 504].
