// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrVIM
// Immediate not compatible with encode/decode function.
asr z23.b, p5/m, z23.b, #9
// CHECK: error: immediate must be an integer in range [1, 8]
