// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoadNT4SIZ
// Immediate out of lower bound [-8, 7].
ldnt1w z12.s, p6/z, [x1, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
