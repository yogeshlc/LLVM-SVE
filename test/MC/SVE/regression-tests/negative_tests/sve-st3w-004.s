// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E3Store4SIZ
// Immediate out of upper bound [-24, 21].
st3w {z25.s, z26.s, z27.s}, p6, [x0, #22, MUL VL]
// CHECK: error: index must be a multiple of 3 in range [-24, 21].
