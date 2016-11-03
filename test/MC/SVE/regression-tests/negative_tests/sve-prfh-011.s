// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch2VI
// Restricted predicate has range [0, 7].
prfh pldl3keep, p8, [z1.d, #29]
// CHECK: error: invalid operand
