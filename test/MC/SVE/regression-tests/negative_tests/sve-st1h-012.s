// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store2VIZ
// Immediate out of lower bound [0, 62].
st1h z17.s, p6, [z23.s, #-1]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
