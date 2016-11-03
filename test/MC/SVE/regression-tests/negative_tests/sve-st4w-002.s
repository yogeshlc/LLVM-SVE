// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E4Store4SIZ
// Restricted predicate has range [0, 7].
st4w {z30.s, z31.s, z0.s, z1.s}, p8, [x15, #9, MUL VL]
// CHECK: error: invalid operand
