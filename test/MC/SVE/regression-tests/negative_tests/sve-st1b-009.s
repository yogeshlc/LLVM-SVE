// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStore1SIZ
// Immediate out of upper bound [-8, 7].
st1b z24.s, p0, [x14, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
