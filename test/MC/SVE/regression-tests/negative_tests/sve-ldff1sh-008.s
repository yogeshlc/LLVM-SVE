// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoadFF2LSSZ
// Restricted predicate has range [0, 7].
ldff1sh z8.d, p8/z, [x19, x22, lsl #1]
// CHECK: error: invalid operand
