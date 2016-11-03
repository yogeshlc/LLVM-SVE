// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch1SV
// Restricted predicate has range [0, 7].
prfb pldl1keep, p8, [x21, z14.d]
// CHECK: error: invalid operand
