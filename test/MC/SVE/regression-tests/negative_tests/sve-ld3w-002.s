// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E3Load4SIZ
// Restricted predicate has range [0, 7].
ld3w {z24.s, z25.s, z26.s}, p8/z, [x7, #9, MUL VL]
// CHECK: error: invalid operand
