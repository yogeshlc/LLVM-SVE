// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadNT8LSSZ
// Restricted predicate has range [0, 7].
ldnt1d z15.d, p8/z, [x18, x15, lsl #3]
// CHECK: error: invalid operand
