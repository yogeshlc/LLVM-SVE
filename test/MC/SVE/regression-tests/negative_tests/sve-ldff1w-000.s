// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoadFF4LSSZ
// Restricted predicate has range [0, 7].
ldff1w z27.s, p8/z, [x26, x6, lsl #2]
// CHECK: error: invalid operand
