// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch4LSS
// Restricted predicate has range [0, 7].
prfw #6, p8, [x10, x11, lsl #2]
// CHECK: error: invalid operand
