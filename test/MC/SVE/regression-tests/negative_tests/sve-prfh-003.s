// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16Prefetch2SI
// Immediate out of lower bound [-32, 31].
prfh pstl2strm, p6, [x13, #-33, MUL VL]
// CHECK: error: index must be an integer in range [-32, 31].
