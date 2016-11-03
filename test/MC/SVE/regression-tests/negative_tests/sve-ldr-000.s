// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecPFillSI
// Immediate out of lower bound [-256, 255].
ldr p7, [x13, #-257, MUL VL]
// CHECK: error: index must be an integer in range [-256, 255].
