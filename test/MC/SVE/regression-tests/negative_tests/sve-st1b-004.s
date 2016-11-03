// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CStore1SIZ
// Immediate out of upper bound [-8, 7].
st1b z17.h, p5, [x19, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
