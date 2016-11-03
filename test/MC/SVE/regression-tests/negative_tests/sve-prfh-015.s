// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch2YSV
// Restricted predicate has range [0, 7].
prfh pstl3keep, p8, [x7, z4.d, uxtw #1]
// CHECK: error: invalid operand
