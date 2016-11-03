// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch2YSV
// Restricted predicate has range [0, 7].
prfh pstl1strm, p8, [x0, z8.s, uxtw #1]
// CHECK: error: invalid operand
