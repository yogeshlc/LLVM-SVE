// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadFF4LSSZ
// Restricted predicate has range [0, 7].
ldff1w z19.d, p8/z, [x20, x4, lsl #2]
// CHECK: error: invalid operand
