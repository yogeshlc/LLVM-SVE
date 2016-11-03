// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrVIM
// Immediate not compatible with encode/decode function.
asr z14.s, p5/m, z14.s, #0
// CHECK: error: immediate must be an integer in range [1, 32]
