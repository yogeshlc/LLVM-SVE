// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrVIM
// Immediate not compatible with encode/decode function.
lsr z25.s, p6/m, z25.s, #33
// CHECK: error: immediate must be an integer in range [1, 32]
