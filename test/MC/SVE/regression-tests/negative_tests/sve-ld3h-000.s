// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E3Load2LSSZ
// Restricted predicate has range [0, 7].
ld3h {z11.h, z12.h, z13.h}, p8/z, [x1, x22, lsl #1]
// CHECK: error: invalid operand
