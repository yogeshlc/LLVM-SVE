// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrVIX
// Immediate not compatible with encode/decode function.
asr z1.h, z11.h, #0
// CHECK: error: immediate must be an integer in range [1, 16]
