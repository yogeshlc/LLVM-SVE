// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrVIM
// Immediate not compatible with encode/decode function.
asr z15.h, p2/m, z15.h, #17
// CHECK: error: immediate must be an integer in range [1, 16]
