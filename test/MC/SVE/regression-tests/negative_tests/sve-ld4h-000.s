// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E4Load2LSSZ
// Restricted predicate has range [0, 7].
ld4h {z14.h, z15.h, z16.h, z17.h}, p8/z, [x23, x20, lsl #1]
// CHECK: error: invalid operand
