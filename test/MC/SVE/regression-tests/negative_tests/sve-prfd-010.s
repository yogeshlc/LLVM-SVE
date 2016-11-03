// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch8SV
// Restricted predicate has range [0, 7].
prfd #6, p8, [x28, z17.d, lsl #3]
// CHECK: error: invalid operand
