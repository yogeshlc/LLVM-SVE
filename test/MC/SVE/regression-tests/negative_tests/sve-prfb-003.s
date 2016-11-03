// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch1XSV
// Restricted predicate has range [0, 7].
prfb pldl1keep, p8, [x3, z29.s, sxtw]
// CHECK: error: invalid operand
