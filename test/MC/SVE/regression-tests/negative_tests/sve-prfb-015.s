// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8Prefetch1SI
// Immediate out of upper bound [-32, 31].
prfb pstl2keep, p0, [x11, #32, MUL VL]
// CHECK: error: index must be an integer in range [-32, 31].
