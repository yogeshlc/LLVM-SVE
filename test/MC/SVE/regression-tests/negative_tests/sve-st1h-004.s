// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CStore2SIZ
// Immediate out of upper bound [-8, 7].
st1h z23.h, p6, [x5, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
