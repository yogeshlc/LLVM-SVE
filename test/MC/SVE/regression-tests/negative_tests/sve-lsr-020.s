// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShrVIM
// Immediate not compatible with encode/decode function.
lsr z30.d, p1/m, z30.d, #0
// CHECK: error: immediate must be an integer in range [1, 64]
