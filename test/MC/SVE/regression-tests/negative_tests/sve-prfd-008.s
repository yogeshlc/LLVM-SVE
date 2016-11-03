// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch8SI
// Immediate out of lower bound [-32, 31].
prfd pstl1keep, p4, [x18, #-33, MUL VL]
// CHECK: error: index must be an integer in range [-32, 31].
