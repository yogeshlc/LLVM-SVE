// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E3Load1LSSZ
// Restricted predicate has range [0, 7].
ld3b {z10.b, z11.b, z12.b}, p8/z, [x4, x4]
// CHECK: error: invalid operand
