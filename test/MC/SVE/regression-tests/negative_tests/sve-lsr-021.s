// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShrVIM
// Immediate not compatible with encode/decode function.
lsr z17.d, p3/m, z17.d, #65
// CHECK: error: immediate must be an integer in range [1, 64]
