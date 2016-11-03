// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16Prefetch2LSS
// Restricted predicate has range [0, 7].
prfh pstl1keep, p8, [x12, x28, lsl #1]
// CHECK: error: invalid operand
