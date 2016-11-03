// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecPSpillSI
// Immediate out of upper bound [-256, 255].
str p13, [x14, #256, MUL VL]
// CHECK: error: index must be an integer in range [-256, 255].
