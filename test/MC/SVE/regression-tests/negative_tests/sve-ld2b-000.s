// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E2Load1LSSZ
// Restricted predicate has range [0, 7].
ld2b {z12.b, z13.b}, p8/z, [x23, x11]
// CHECK: error: invalid operand
