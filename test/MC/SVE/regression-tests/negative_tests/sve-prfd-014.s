// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch8XSV
// Restricted predicate has range [0, 7].
prfd pstl3strm, p8, [x3, z23.d, sxtw #3]
// CHECK: error: invalid operand
