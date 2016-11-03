// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E4Load8SIZ
// Restricted predicate has range [0, 7].
ld4d {z16.d, z17.d, z18.d, z19.d}, p8/z, [x16, #9, MUL VL]
// CHECK: error: invalid operand
