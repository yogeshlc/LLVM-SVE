// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch1VI
// Restricted predicate has range [0, 7].
prfb pldl3keep, p8, [z8.s, #30]
// CHECK: error: invalid operand
