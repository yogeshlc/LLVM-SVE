// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStore4SIZ
// Immediate out of upper bound [-8, 7].
st1w z25.s, p6, [x20, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
