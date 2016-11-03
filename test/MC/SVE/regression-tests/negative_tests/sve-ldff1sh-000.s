// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoadFF2LSSZ
// Restricted predicate has range [0, 7].
ldff1sh z26.s, p8/z, [x10, x1, lsl #1]
// CHECK: error: invalid operand
