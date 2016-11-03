// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoadNT2SIZ
// Immediate out of upper bound [-8, 7].
ldnt1h z21.h, p5/z, [x6, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
