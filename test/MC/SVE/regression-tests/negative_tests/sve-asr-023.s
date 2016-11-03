// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrVIM
// Source and Destination Registers must match
asr z24.d, p5/m, z25.d, #1
// CHECK: error: operand must match destination register
