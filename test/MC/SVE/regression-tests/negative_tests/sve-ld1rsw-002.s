// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadDup4SIZ
// Immediate out of upper bound [0, 252].
ld1rsw z29.d, p6/z, [x16, #253]
// CHECK: error: index must be a multiple of 4 in range [0, 252].
