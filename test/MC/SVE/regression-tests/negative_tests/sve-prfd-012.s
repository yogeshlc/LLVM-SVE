// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch8VI
// Immediate out of lower bound [0, 248].
prfd pldl2keep, p5, [z22.d, #-1]
// CHECK: error: index must be a multiple of 8 in range [0, 248].
