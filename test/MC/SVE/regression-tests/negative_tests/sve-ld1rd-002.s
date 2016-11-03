// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadDup8SIZ
// Immediate out of upper bound [0, 504].
ld1rd z7.d, p3/z, [x5, #505]
// CHECK: error: index must be a multiple of 8 in range [0, 504].
