// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E4Load4SIZ
// Restricted predicate has range [0, 7].
ld4w {z15.s, z16.s, z17.s, z18.s}, p8/z, [x25, #13, MUL VL]
// CHECK: error: invalid operand
