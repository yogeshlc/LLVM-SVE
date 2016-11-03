// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch2VI
// Restricted predicate has range [0, 7].
prfh pldl3keep, p8, [z11.s, #15]
// CHECK: error: invalid operand
