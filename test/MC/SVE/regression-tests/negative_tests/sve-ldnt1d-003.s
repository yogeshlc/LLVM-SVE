// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadNT8SIZ
// Immediate out of lower bound [-8, 7].
ldnt1d z17.d, p6/z, [x29, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
