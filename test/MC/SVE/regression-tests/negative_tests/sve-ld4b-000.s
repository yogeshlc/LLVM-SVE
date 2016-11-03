// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E4Load1LSSZ
// Restricted predicate has range [0, 7].
ld4b {z11.b, z12.b, z13.b, z14.b}, p8/z, [x11, x26]
// CHECK: error: invalid operand
