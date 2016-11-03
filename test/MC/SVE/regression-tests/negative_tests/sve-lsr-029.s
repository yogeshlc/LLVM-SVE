// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrVIM
// Immediate not compatible with encode/decode function.
lsr z1.b, p0/m, z1.b, #9
// CHECK: error: immediate must be an integer in range [1, 8]
