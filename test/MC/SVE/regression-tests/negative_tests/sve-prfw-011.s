// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch4VI
// Restricted predicate has range [0, 7].
prfw pstl3keep, p8, [z16.d, #19]
// CHECK: error: invalid operand
