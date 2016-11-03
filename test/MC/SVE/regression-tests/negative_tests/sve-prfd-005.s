// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch8LSS
// Restricted predicate has range [0, 7].
prfd pstl3keep, p8, [x12, x13, lsl #3]
// CHECK: error: invalid operand
