// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E2Load4LSSZ
// Restricted predicate has range [0, 7].
ld2w {z5.s, z6.s}, p8/z, [x23, x11, lsl #2]
// CHECK: error: invalid operand
