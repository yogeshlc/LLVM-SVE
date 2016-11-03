// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CLoadNT1SIZ
// Immediate out of upper bound [-8, 7].
ldnt1b z24.b, p5/z, [x24, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
