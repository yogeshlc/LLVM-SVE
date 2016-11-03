// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoad1SIZ
// Immediate out of lower bound [-8, 7].
ld1b z8.h, p0/z, [x0, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
