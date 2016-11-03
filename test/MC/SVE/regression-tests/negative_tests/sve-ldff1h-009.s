// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadFF2LSSZ
// Restricted predicate has range [0, 7].
ldff1h z16.d, p8/z, [x3, x28, lsl #1]
// CHECK: error: invalid operand
