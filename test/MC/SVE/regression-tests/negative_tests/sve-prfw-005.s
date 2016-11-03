// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch4VI
// Restricted predicate has range [0, 7].
prfw pstl2keep, p8, [z10.s, #30]
// CHECK: error: invalid operand
