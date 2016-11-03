// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E3Store4SIZ
// Restricted predicate has range [0, 7].
st3w {z0.s, z1.s, z2.s}, p8, [x28, #14, MUL VL]
// CHECK: error: invalid operand
