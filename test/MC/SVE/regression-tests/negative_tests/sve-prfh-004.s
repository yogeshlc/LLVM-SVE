// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16Prefetch2SI
// Immediate out of upper bound [-32, 31].
prfh pstl2keep, p3, [x3, #32, MUL VL]
// CHECK: error: index must be an integer in range [-32, 31].
