// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch4XSV
// Restricted predicate has range [0, 7].
prfw #7, p8, [x1, z26.s, sxtw #2]
// CHECK: error: invalid operand
