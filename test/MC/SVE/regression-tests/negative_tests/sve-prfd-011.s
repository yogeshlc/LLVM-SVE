// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch8VI
// Restricted predicate has range [0, 7].
prfd pstl1strm, p8, [z2.d, #4]
// CHECK: error: invalid operand
