// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E4Load4LSSZ
// Restricted predicate has range [0, 7].
ld4w {z24.s, z25.s, z26.s, z27.s}, p8/z, [x30, x17, lsl #2]
// CHECK: error: invalid operand
