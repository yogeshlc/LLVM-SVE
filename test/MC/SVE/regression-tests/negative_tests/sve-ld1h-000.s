// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoad2LSSZ
// Restricted predicate has range [0, 7].
ld1h z29.h, p8/z, [x26, x21, lsl #1]
// CHECK: error: invalid operand
