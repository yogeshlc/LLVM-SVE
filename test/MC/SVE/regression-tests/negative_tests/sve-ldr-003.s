// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64FillSI
// Immediate out of upper bound [-256, 255].
ldr z16, [x18, #256, MUL VL]
// CHECK: error: index must be an integer in range [-256, 255].
