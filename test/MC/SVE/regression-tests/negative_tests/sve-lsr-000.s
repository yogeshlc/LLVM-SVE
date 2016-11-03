// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShrVIM
// Immediate not compatible with encode/decode function.
lsr z15.h, p3/m, z15.h, #0
// CHECK: error: immediate must be an integer in range [1, 16]
