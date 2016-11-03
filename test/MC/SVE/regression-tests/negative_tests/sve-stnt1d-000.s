// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStoreNT8LSSZ
// Restricted predicate has range [0, 7].
stnt1d z11.d, p8, [x24, x16, lsl #3]
// CHECK: error: invalid operand
