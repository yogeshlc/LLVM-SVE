// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E3Load4LSSZ
// Restricted predicate has range [0, 7].
ld3w {z17.s, z18.s, z19.s}, p8/z, [x22, x16, lsl #2]
// CHECK: error: invalid operand
