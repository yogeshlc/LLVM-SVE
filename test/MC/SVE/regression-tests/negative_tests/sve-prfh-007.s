// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch2VI
// Immediate out of upper bound [0, 62].
prfh pldl1strm, p1, [z17.s, #63]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
