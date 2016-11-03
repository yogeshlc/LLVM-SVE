// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch8YSV
// Restricted predicate has range [0, 7].
prfd #7, p8, [x8, z5.d, uxtw #3]
// CHECK: error: invalid operand
