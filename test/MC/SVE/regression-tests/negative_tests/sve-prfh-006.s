// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch2VI
// Immediate out of lower bound [0, 62].
prfh pstl1strm, p3, [z29.s, #-1]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
