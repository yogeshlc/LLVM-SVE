// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CStore1SIZ
// Immediate out of lower bound [-8, 7].
st1b z25.b, p0, [x9, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
