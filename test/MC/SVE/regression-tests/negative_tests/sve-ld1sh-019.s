// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load2VIZ
// Immediate out of lower bound [0, 62].
ld1sh z27.d, p4/z, [z21.d, #-1]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
