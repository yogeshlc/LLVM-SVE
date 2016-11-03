// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrVIM
// Immediate not compatible with encode/decode function.
asr z4.h, p3/m, z4.h, #0
// CHECK: error: immediate must be an integer in range [1, 16]
