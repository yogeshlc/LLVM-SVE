// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrVIM
// Immediate not compatible with encode/decode function.
lsr z6.s, p0/m, z6.s, #0
// CHECK: error: immediate must be an integer in range [1, 32]
