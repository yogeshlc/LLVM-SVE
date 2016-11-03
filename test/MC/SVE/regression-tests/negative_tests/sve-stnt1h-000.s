// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CStoreNT2LSSZ
// Restricted predicate has range [0, 7].
stnt1h z5.h, p8, [x2, x10, lsl #1]
// CHECK: error: invalid operand
