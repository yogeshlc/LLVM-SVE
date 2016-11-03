// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch1VI
// Restricted predicate has range [0, 7].
prfb pldl1keep, p8, [z29.d, #27]
// CHECK: error: invalid operand
