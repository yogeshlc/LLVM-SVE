// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch1YSV
// Restricted predicate has range [0, 7].
prfb #14, p8, [x16, z11.d, uxtw]
// CHECK: error: invalid operand
