// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStoreNT4LSSZ
// Restricted predicate has range [0, 7].
stnt1w z6.s, p8, [x2, x9, lsl #2]
// CHECK: error: invalid operand
