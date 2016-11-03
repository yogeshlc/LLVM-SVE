// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch4VI
// Immediate out of upper bound [0, 124].
prfw pldl2keep, p5, [z26.s, #125]
// CHECK: error: index must be a multiple of 4 in range [0, 124].
