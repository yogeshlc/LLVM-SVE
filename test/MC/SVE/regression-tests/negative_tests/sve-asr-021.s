// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrVIM
// Immediate not compatible with encode/decode function.
asr z22.d, p5/m, z22.d, #65
// CHECK: error: immediate must be an integer in range [1, 64]
