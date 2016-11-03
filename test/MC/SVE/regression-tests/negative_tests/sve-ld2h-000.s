// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E2Load2LSSZ
// Restricted predicate has range [0, 7].
ld2h {z5.h, z6.h}, p8/z, [x27, x17, lsl #1]
// CHECK: error: invalid operand
