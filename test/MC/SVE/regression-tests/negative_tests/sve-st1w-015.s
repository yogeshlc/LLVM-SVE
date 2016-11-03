// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStore4SIZ
// Immediate out of lower bound [-8, 7].
st1w z3.d, p5, [x16, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
